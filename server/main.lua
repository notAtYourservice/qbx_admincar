-- Admin car command for vehicle management
local DoesEntityExist = DoesEntityExist
local GetEntityType = GetEntityType
local GetEntityModel = GetEntityModel
local GetVehicleBodyHealth = GetVehicleBodyHealth
local GetVehicleEngineHealth = GetVehicleEngineHealth
local NetworkGetEntityFromNetworkId = NetworkGetEntityFromNetworkId

-- Validate vehicle entity
local function validateVehicle(vehicle)
    if not vehicle or vehicle == 0 then
        return false, "Vehicle does not exist"
    end
    
    if not DoesEntityExist(vehicle) then
        return false, "Vehicle does not exist"
    end
    
    if GetEntityType(vehicle) ~= 2 then -- 2 = vehicle entity
        return false, "Invalid entity type"
    end
    
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    if not netId or netId == 0 then
        return false, "Vehicle is not networked"
    end
    
    local bodyHealth = GetVehicleBodyHealth(vehicle)
    local engineHealth = GetVehicleEngineHealth(vehicle)
    if bodyHealth <= 0 or engineHealth <= 0 then
        return false, "Vehicle is too damaged"
    end
    
    return true, netId
end

-- Register admincar command
lib.addCommand('admincar', {
    help = 'Transfer vehicle ownership to yourself or target player',
    restricted = config.saveVehicle,
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player ID (optional)',
            optional = true
        }
    }
}, function(source, args)
    -- Get vehicle network ID from client-side detection
    local vehicleNetId = lib.callback.await('qbx_admin:client:GetVehicleInFront', source)
    
    if not vehicleNetId or vehicleNetId == 0 then
        return exports.qbx_core:Notify(source, 'No vehicle found. Look at a vehicle within 10 meters.', 'error')
    end
    
    -- Convert network ID to entity
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not vehicle or vehicle == 0 then
        return exports.qbx_core:Notify(source, 'Vehicle does not exist', 'error')
    end
    
    local isValid, validationError, validatedNetId = validateVehicle(vehicle)
    if not isValid then
        return exports.qbx_core:Notify(source, validationError, 'error')
    end
    
    local vehModel = GetEntityModel(vehicle)
    local playerData = exports.qbx_core:GetPlayer(source).PlayerData
    
    -- Determine target player
    local targetPlayer = source
    local targetName = "your"
    local targetCitizenId = playerData.citizenid
    
    if args.target then
        local target = exports.qbx_core:GetPlayer(args.target)
        if not target then
            return exports.qbx_core:Notify(source, 'Target player not found', 'error')
        end
        targetPlayer = args.target
        targetCitizenId = target.PlayerData.citizenid
        targetName = target.PlayerData.name .. "'s"
    end
    
    -- Get vehicle info from client
    local vehName, props = lib.callback.await('qbx_admin:client:GetVehicleInfo', source, validatedNetId)
    if not vehName or not props then
        return exports.qbx_core:Notify(source, 'Failed to get vehicle information', 'error')
    end
    
    local existingVehicleId = Entity(vehicle).state.vehicleid
    
    if existingVehicleId then
        local response = lib.callback.await('qbx_admin:client:SaveCarDialog', source)
        if not response then
            return exports.qbx_core:Notify(source, 'Canceled.', 'inform')
        end
        
        local success, err = exports.qbx_vehicles:SetPlayerVehicleOwner(existingVehicleId, targetCitizenId)
        if not success then 
            exports.qbx_core:Notify(source, 'Failed to transfer vehicle: ' .. tostring(err), 'error')
            return
        end
    else
        local vehicleData = {
            model = vehName,
            citizenid = targetCitizenId,
            props = props,
        }
        
        local vehicleInfo = exports.qbx_core:GetVehiclesByHash()[vehModel]
        if vehicleInfo then
            vehicleData.model = vehicleInfo.model
        end
        
        local vehicleId, err = exports.qbx_vehicles:CreatePlayerVehicle(vehicleData)
        if err then 
            exports.qbx_core:Notify(source, 'Failed to save vehicle: ' .. tostring(err), 'error')
            return
        end
        Entity(vehicle).state:set('vehicleid', vehicleId, true)
    end
    
    -- Give keys to target player
    TriggerClientEvent('qb-vehiclekeys:client:AddKeys', targetPlayer, validatedNetId)
    
    exports.qbx_core:Notify(source, string.format('Vehicle is now %s.', targetName), 'success')
    if targetPlayer ~= source then
        exports.qbx_core:Notify(targetPlayer, 'An admin has given you a vehicle', 'success')
    end
end)
