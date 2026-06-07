#!/bin/bash

BUILD_DIR="John_Rambo"
# 1. Define the absolute destination path using your variable
#TARGET_PATH="/home/$MY_USER/Documents/$BUILD_DIR"
TARGET_PATH="./$BUILD_DIR"

#PART-1
# Tries SUDO_USER first, then logname, then the standard USER variable
MY_USER=${SUDO_USER:-$(logname 2>/dev/null || echo $USER)}
echo "Validated user: $MY_USER"

#check if directory exists
if [ -d "TARGET_PATH" ]; then
        echo "Directory exists"
        rm -rf "TARGET_PATH"
        echo "All clean"
else
        echo "Directory creating"
fi
mkdir -p "$TARGET_PATH"
#echo "Created a new one"

#user owns what I created
chown -R "$MY_USER":"$MY_USER" "$TARGET_PATH"



#PART-2

echo "Creating folder structure in ~/${BUILD_DIR}..."

# Create the directories simultaneously 
mkdir -p "${BUILD_DIR}/DEBIAN"
mkdir -p "${BUILD_DIR}/usr/share/splash-changer"

# Create empty files for the configuration and splash image
touch "${BUILD_DIR}/DEBIAN/control"

##############################################
#Create dummy payload, content will be loaded in the build-pkg.sh
##############################################
touch "${BUILD_DIR}/DEBIAN/postinst"
touch "${BUILD_DIR}/usr/share/splash-changer/my-custom-splash.png"

############## move the PNG file in the directory structure
echo "Current directory using command: $(pwd)"
cp resources/grub-16x9.png "${BUILD_DIR}"/usr/share/splash-changer/

echo "PNG file coppied"

# Make the post-installation script executable (required by dpkg)
chmod 755 "${BUILD_DIR}/DEBIAN/postinst"

echo "Structure successfully created!"
