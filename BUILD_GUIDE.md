# Build and Install Guide

This guide provides command-line tools to build and install VoiceInk exactly like Xcode, while solving the accessibility permissions issue.

## 🔨 Building VoiceInk

### Option 1: Simple Build (Recommended)
```bash
./build_simple.sh
```
This builds VoiceInk exactly like Xcode using Release configuration.

### Option 2: Archive Build (For Distribution)
```bash
./build.sh
```
This creates a proper archive and export, similar to Xcode's "Archive" feature.

## 🚀 Installing and Fixing Permissions

### All-in-One Installation
```bash
./install_and_fix.sh
```
This script:
1. Installs the built app to `/Applications/`
2. Fixes file permissions
3. Resets accessibility permissions 
4. Clears system caches
5. Prepares the app for first launch

### Manual Installation
If you prefer to do it step by step:

1. **Install the app:**
   ```bash
   cp -R ./build/Build/Products/Release/VoiceInk.app /Applications/
   ```

2. **Fix permissions:**
   ```bash
   ./reset_permissions.sh
   ```

3. **Launch and grant permissions:**
   ```bash
   open /Applications/VoiceInk.app
   ```

## 🔐 Why Accessibility Permissions Reset?

macOS identifies apps by their code signature and bundle identifier. When you build locally:

- The app gets a different signature than the previous version
- macOS treats it as a "new" application
- Previous accessibility permissions don't carry over
- You need to grant permissions again

Our scripts solve this by:
1. Completely removing old accessibility permissions
2. Clearing system caches
3. Ensuring clean app installation
4. Triggering fresh permission requests

## 📋 Available Scripts

| Script | Purpose |
|--------|---------|
| `build_simple.sh` | Quick build (like Xcode build) |
| `build.sh` | Archive and export build |
| `install_and_fix.sh` | Install app and fix permissions |
| `reset_permissions.sh` | Reset accessibility permissions only |

## 🛠️ Exact Xcode Equivalent Commands

The `build_simple.sh` script runs this exact command that matches Xcode:

```bash
xcodebuild \
  -scheme VoiceInk \
  -configuration Release \
  -derivedDataPath ./build \
  clean build
```

This produces the exact same binary as Xcode's "Build" button.

## 🔍 Troubleshooting

### Build Fails
- Ensure you have Xcode installed
- Make sure all dependencies are resolved: `xcodebuild -resolvePackageDependencies`

### Permissions Still Not Working
1. Manually remove VoiceInk from System Preferences → Privacy & Security → Accessibility
2. Run `./reset_permissions.sh`
3. Launch VoiceInk and grant permissions when prompted

### App Won't Launch
- Check if the app exists: `ls -la /Applications/VoiceInk.app`
- Try launching from Terminal: `open /Applications/VoiceInk.app`
- Check Console.app for error messages

## 🎯 Quick Start

For the fastest build and install:

```bash
# Build the app
./build_simple.sh

# Install and fix everything
./install_and_fix.sh

# Launch the app
open /Applications/VoiceInk.app
```

That's it! The app should launch and ask for accessibility permissions.