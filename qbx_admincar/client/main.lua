-- Client-side callbacks for admincar command
local function GetVehicleInfo()
    -- This function should return vehicle info for the detected vehicle
    local playerPed = PlayerPedId()
    
    -- Try to get vehicle player is looking at
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination = vector3(
        cameraCoord.x + direction.x * 15.0,
        cameraCoord.y + direction.y * 15.0,
        cameraCoord.z + direction.z * 15.0
    )
    
    local rayHandle = StartShapeTestLosProbe(
        cameraCoord.x, cameraCoord.y, cameraCoord.z,
        destination.x, destination.y, destination.z,
        10, playerPed, 4
    )
    
    local _, hit, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    if hit and DoesEntityExist(entityHit) and GetEntityType(entityHit) == 2 then
        local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(entityHit))
        local props = lib.getVehicleProperties(entityHit)
        return vehName, props
    end
    
    -- Fallback: Check closest vehicle within 10 meters
    local vehicles = GetGamePool('CVehicle')
    local playerCoords = GetEntityCoords(playerPed)
    local closestVehicle = nil
    local closestDistance = 9999
    
    for _, vehicle in ipairs(vehicles) do
        local vehCoords = GetEntityCoords(vehicle)
        local distance = #(playerCoords - vehCoords)
        
        if distance <= 10.0 and distance < closestDistance then
            closestVehicle = vehicle
            closestDistance = distance
        end
    end
    
    if closestVehicle then
        local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(closestVehicle))
        local props = lib.getVehicleProperties(closestVehicle)
        return vehName, props
    end
    
    -- Last resort: Check if player is in a vehicle
    local currentVehicle = GetVehiclePedIsIn(playerPed, false)
    if currentVehicle ~= 0 then
        local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))
        local props = lib.getVehicleProperties(currentVehicle)
        return vehName, props
    end
    
    return nil, nil
end

local function SaveCarDialog()
    local input = lib.inputDialog('Save Vehicle', {
        {type = 'checkbox', label = 'Confirm save vehicle', checked = false}
    })
    
    return input and input[1] or false
end

-- Fixed function to get vehicle network ID
local function GetVehicleInFront()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    -- Method 1: Check if player is in a vehicle
    local currentVehicle = GetVehiclePedIsIn(playerPed, false)
    if currentVehicle ~= 0 then
        local netId = NetworkGetNetworkIdFromEntity(currentVehicle)
        if netId and netId ~= 0 then
            return netId
        end
    end
    
    -- Method 2: Camera raycast for what player is looking at
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination = vector3(
        cameraCoord.x + direction.x * 15.0,
        cameraCoord.y + direction.y * 15.0,
        cameraCoord.z + direction.z * 15.0
    )
    
    local rayHandle = StartShapeTestLosProbe(
        cameraCoord.x, cameraCoord.y, cameraCoord.z,
        destination.x, destination.y, destination.z,
        10, playerPed, 4
    )
    
    local _, hit, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    if hit and DoesEntityExist(entityHit) and GetEntityType(entityHit) == 2 then
        local netId = NetworkGetNetworkIdFromEntity(entityHit)
        if netId and netId ~= 0 then
            return netId
        end
    end
    
    -- Method 3: Check for closest vehicle within 10 meters
    local vehicles = GetGamePool('CVehicle')
    local closestVehicle = 0
    local closestDistance = 9999
    
    for _, vehicle in ipairs(vehicles) do
        local vehCoords = GetEntityCoords(vehicle)
        local distance = #(playerCoords - vehCoords)
        
        if distance <= 10.0 and distance < closestDistance then
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
            if netId and netId ~= 0 then
                closestVehicle = netId
                closestDistance = distance
            end
        end
    end
    
    return closestVehicle
end

-- Helper function to convert rotation to direction vector
function RotationToDirection(rotation)
    local adjustedRotation = vector3(
        (math.pi / 180) * rotation.x,
        (math.pi / 180) * rotation.y,
        (math.pi / 180) * rotation.z
    )
    local direction = vector3(
        -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        math.sin(adjustedRotation.x)
    )
    return direction
end

-- Register callbacks
lib.callback.register('qbx_admin:client:GetVehicleInfo', GetVehicleInfo)
lib.callback.register('qbx_admin:client:SaveCarDialog', SaveCarDialog)
lib.callback.register('qbx_admin:client:GetVehicleInFront', GetVehicleInFront)
