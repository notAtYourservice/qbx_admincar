# Admin Car Command - Qbox Resource

![GitHub release (latest by date)](https://img.shields.io/github/v/release/qbox-framework/qbx_admincar)
![GitHub contributors](https://img.shields.io/github/contributors/qbox-framework/qbx_admincar)
![GitHub issues](https://img.shields.io/github/issues/qbox-framework/qbx_admincar)
![GitHub license](https://img.shields.io/github/license/qbox-framework/qbx_admincar)
![Discord](https://img.shields.io/discord/1012753553418354748?color=5865f2&label=Discord&logo=discord&logoColor=white)

## 📋 Description
This resource provides an admin command (`/admincar`) that allows players with appropriate permissions to save vehicles to their garage. The resource has been successfully enhanced with comprehensive security features and universal vehicle support.

## ✨ Features
- **Save any vehicle** you're currently in to your garage
- **Transfer ownership** of existing vehicles
- **Give vehicles to other players** using `/admincar [playerId]`
- **Universal vehicle support** - works with both database and non-database vehicles
- **Enhanced security** with comprehensive anti-cheat protection
- **Configurable permission levels**
- **Clean notifications** using Qbox Core

## 🚀 Installation

### Quick Start
1. **Download** the latest release from [GitHub Releases](https://github.com/qbox-framework/qbx_admincar/releases)
2. **Extract** to `resources/[standalone]/admincar`
3. **Add** to your `server.cfg`:
   ```
   ensure admincar
   ```
4. **Configure** permissions in `config.lua`
5. **Restart** your server

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/qbox-framework/qbx_admincar.git resources/[standalone]/admincar

# Ensure the resource
echo "ensure admincar" >> server.cfg
```

## 🎯 Usage

### Basic Usage
1. Get in any vehicle
2. Type `/admincar` in chat
3. Follow the prompts to save the vehicle

### Advanced Usage
- `/admincar` - Save current vehicle to your garage
- `/admincar [playerId]` - Give current vehicle to target player

### Examples
```bash
# Save your current vehicle
/admincar

# Give your current vehicle to player with ID 5
/admincar 5
```

## 🔧 Configuration

Edit `config.lua` to customize the resource:

```lua
config = {
    -- Permission level required to use the admincar command
    saveVehicle = 'admin',  -- Can be 'admin', 'god', or specific ace permission
}
```

## 🛡️ Security Features
- ✅ Entity validation
- ✅ Vehicle type verification
- ✅ Model hash validation
- ✅ Network ID verification
- ✅ Vehicle health checks
- ✅ Anti-cheat protection
- ✅ Rate limiting for non-admin users

## 📦 Dependencies
- **qbx-core** - Core framework
- **qbx_vehicles** - Vehicle management
- **ox_lib** - UI and utility functions

## 🎮 Commands
| Command | Description | Permission |
|---------|-------------|------------|
| `/admincar` | Save current vehicle to your garage | `config.saveVehicle` |
| `/admincar [playerId]` | Give current vehicle to target player | `config.saveVehicle` |

## 🤝 Contributing
We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 🐛 Bug Reports & Feature Requests
- **Bug Reports**: [Create an issue](https://github.com/qbox-framework/qbx_admincar/issues/new?template=bug_report.md)
- **Feature Requests**: [Create an issue](https://github.com/qbox-framework/qbx_admincar/issues/new?template=feature_request.md)

## 📄 License
This resource is part of the Qbox framework and is released under the [MIT License](LICENSE).

## 🙏 Acknowledgments
- Qbox Team for the framework
- Community contributors
- FiveM community for inspiration

---

<div align="center">
  <p>
    <a href="https://discord.gg/qbox">
      <img src="https://discordapp.com/api/guilds/1012753553418354748/widget.png?style=banner2" alt="Discord Banner"/>
    </a>
  </p>
</div>
