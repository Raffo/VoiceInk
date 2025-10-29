#!/bin/bash

# Simple build script for VoiceInk
echo "Building VoiceInk..."

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf ./build

# Build VoiceInk with Debug configuration (Release has entitlements issues)
echo "Building with xcodebuild (Debug configuration)..."
xcodebuild -project VoiceInk.xcodeproj \
    -scheme VoiceInk \
    -configuration Debug \
    clean build \
    -derivedDataPath ./build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "� App built at: ./build/Build/Products/Debug/VoiceInk.app"
    
    # Check if app exists
    if [ -d "./build/Build/Products/Debug/VoiceInk.app" ]; then
        echo "✅ VoiceInk.app created successfully"
        ls -la "./build/Build/Products/Debug/VoiceInk.app/Contents/"
    else
        echo "❌ VoiceInk.app not found"
        exit 1
    fi
else
    echo "❌ Build failed"
    exit 1
fi