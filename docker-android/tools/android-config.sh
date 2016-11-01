#!/bin/bash

# Setup environment
export ANDROID_HOME=/opt/android-sdk-linux/;
export PATH=$ANDROID_HOME/platform-tools:$PATH/;
export PATH=$ANDROID_HOME/tools:$PATH/;

# Create emulator, if some elememnt of the Android sdk installation fail, the emulator creation fail and docker fail
android create avd --force --device "Nexus 5" --name test --target android-24 --abi armeabi-v7a --skin WVGA800 --sdcard 512M;

# Start SSH server
service ssh start;
