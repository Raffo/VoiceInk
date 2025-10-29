#!/bin/bash

# VoiceInk Install and Permission Fix Script
# Installs the app and fixes accessibility permissions

set -e

APP_NAME="VoiceInk"
BUILD_PATH="./build/Build/Products/Debug/${APP_NAME}.app"
INSTALL_PATH="/Applications/${APP_NAME}.app"

echo "🚀 Installing VoiceInk and fixing permissions..."

# Check if built app exists
if [ ! -d "$BUILD_PATH" ]; then
    echo "❌ Built app not found at: $BUILD_PATH"
    echo "   Please run './build_simple.sh' first"
    exit 1
fi

# Remove old version if it exists
if [ -d "$INSTALL_PATH" ]; then
    echo "🗑️  Removing old version..."
    rm -rf "$INSTALL_PATH"
fi

# Copy new version
echo "📦 Installing new version..."
cp -R "$BUILD_PATH" "$INSTALL_PATH"

# Fix ownership and permissions
echo "🔧 Fixing app permissions..."
chown -R "$(whoami):staff" "$INSTALL_PATH"
chmod -R 755 "$INSTALL_PATH"

# Get bundle identifier
BUNDLE_ID=$(defaults read "$INSTALL_PATH/Contents/Info.plist" CFBundleIdentifier 2>/dev/null || echo "com.prakashjoshipax.VoiceInk")

echo "📱 Bundle ID: $BUNDLE_ID"

# Remove existing accessibility permissions
echo "🔐 Resetting accessibility permissions..."
sudo tccutil reset Accessibility "$BUNDLE_ID" 2>/dev/null || true

# Kill any running instances
echo "🛑 Stopping any running VoiceInk instances..."
pkill -f "$APP_NAME" 2>/dev/null || true
sleep 1

# Clear system caches
echo "🧹 Clearing system caches..."
sudo killall -SIGTERM cfprefsd 2>/dev/null || true
sleep 1

# Update app timestamp
touch "$INSTALL_PATH"

# Get version info
APP_VERSION=$(defaults read "$INSTALL_PATH/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || echo "unknown")
BUILD_VERSION=$(defaults read "$INSTALL_PATH/Contents/Info.plist" CFBundleVersion 2>/dev/null || echo "unknown")

echo ""
echo "✅ Installation complete!"
echo "📍 Installed to: $INSTALL_PATH"
echo "🔢 Version: $APP_VERSION ($BUILD_VERSION)"
echo ""
echo "🔐 To complete setup:"
echo "1. Launch VoiceInk (it will request accessibility permission)"
echo "2. Grant the permission when prompted"
echo ""
echo "🚀 Launch now:"
echo "   open '$INSTALL_PATH'"