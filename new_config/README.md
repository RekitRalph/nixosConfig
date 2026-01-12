# Modular NixOS Configuration

A fully modular, option-driven NixOS configuration with zero hardcoded values.

## Features

- **Options-Driven**: All configuration via `myOptions` namespace
- **Host-Aware Home Manager**: Different home configs per host and desktop environment
- **Conditional Module Loading**: Only load what you need
- **Type Safety**: All options have explicit types and defaults
- **Zero Duplication**: Shared settings in one place

## Structure

```
new_config/
├── flake.nix                 # Main entry point
├── options/default.nix       # All configurable options
├── hosts/                    # Host-specific configs
│   ├── starchy/             # Desktop config
│   └── lappy/               # Laptop config
├── modules/
│   ├── system/              # System-level modules
│   │   ├── core/           # Always loaded
│   │   ├── shared/         # Common settings
│   │   ├── desktop/        # Desktop environments
│   │   ├── hardware/       # Hardware-specific
│   │   ├── optional/       # Optional features
│   │   └── programs/       # System programs
│   └── home/               # Home-manager modules
│       ├── common/         # Shared home config
│       ├── desktop/        # Desktop-specific
│       └── profiles/       # Host-specific
└── overlays/               # Package overlays
```

## Testing the Configuration

### 1. Add to git (required for flakes)

```bash
cd ~/nixos
git add new_config
```

### 2. Check flake validity

```bash
nix flake check ~/nixos/new_config --allow-dirty
```

### 3. Dry build

```bash
# For starchy
sudo nixos-rebuild dry-build --flake ~/nixos/new_config#starchy

# For lappy
sudo nixos-rebuild dry-build --flake ~/nixos/new_config#lappy
```

### 4. Test in VM (optional)

```bash
nixos-rebuild build-vm --flake ~/nixos/new_config#starchy
./result/bin/run-starchy-vm
```

### 5. Switch to new config

```bash
sudo nixos-rebuild switch --flake ~/nixos/new_config#starchy
```

## Configuration Examples

### Change Desktop Environment

Edit `hosts/starchy/configuration.nix`:

```nix
myOptions.desktop.environment = "hyprland";  # Changed from "kde"
```

### Add NFS Share

```nix
myOptions.networking.nfs.shares.videos = {
  server = "192.168.1.150";
  remotePath = "/export/videos";
  mountPoint = "/mnt/videos";
  idleTimeout = 300;
};
```

### Enable Gaming on Laptop

```nix
myOptions.features.gaming.enable = true;
myOptions.hardware.gpu.enable32Bit = true;
```

### Change Cursor Size

```nix
myOptions.appearance.cursor.size = 32;  # Changed from 24
```

### Enable Optional Home Modules

```nix
# In hosts/starchy/configuration.nix
myOptions.home = {
  enableOhMyPosh = true;   # Enable fancy shell prompt
  enableStylix = true;     # Enable base16 theming
  enableGtkTheme = true;   # Enable Dracula GTK theme
  enableHelix = true;      # Enable Helix editor
};
```

## Available Options

All options are defined in `options/default.nix`:

- `myOptions.user.*` - User account settings
- `myOptions.system.*` - System identity
- `myOptions.desktop.*` - Desktop environment
- `myOptions.hardware.*` - Hardware configuration
- `myOptions.features.*` - Optional features (gaming, VMs, etc)
- `myOptions.networking.*` - Network settings (firewall, NFS, samba)
- `myOptions.locale.*` - Timezone, locale, keyboard
- `myOptions.appearance.*` - Cursor theme, size
- `myOptions.storage.*` - Mounts, garbage collection
- `myOptions.boot.*` - Bootloader, kernel
- `myOptions.specialHardware.*` - AMD GPU settings, udev rules
- `myOptions.home.*` - Optional home modules:
  - `enableOhMyPosh` - Shell prompt theming (default: false)
  - `enableStylix` - System-wide base16 theming (default: false)
  - `enableGtkTheme` - GTK/Qt Dracula theme (default: false)
  - `enablePywal` - Color scheme generator (default: false)
  - `enableHelix` - Helix editor with LSPs (default: false)

## Bugs Fixed

✅ Hardcoded usernames removed
✅ NFS server IP now configurable
✅ Cursor size consistent (24px)
✅ Boot timeout configurable
✅ Pywal typo fixed (environment)
✅ Dead code removed (pp alias)
✅ Commented code cleaned up

## Performance Improvements

✅ Reduced duplication (home-manager setup)
✅ Lazy evaluation (conditional modules)
✅ Optimized package sets (desktop-specific)
✅ Better overlay management

## Rollback

If something goes wrong:

1. Reboot and select previous generation from boot menu
2. Or: `sudo nixos-rebuild switch --flake ~/nixos#starchy` (old config)

## Migration from Old Config

The old configuration in `~/nixos` remains untouched. You can:

1. Test the new config on one host
2. If successful, switch both hosts
3. Backup old config: `mv ~/nixos ~/nixos.backup`
4. Move new config: `mv ~/nixos/new_config ~/nixos`
5. Update flake paths from `~/nixos/new_config#` to `~/nixos#`
