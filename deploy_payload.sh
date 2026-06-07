#!/bin/bash
# Extract the OS ID without quotes
ID=$(awk -F= '/^ID=/ {print $2}' /etc/os-release | tr -d '"')

echo ""$ID""

#backup the original image
#sudo mv /boot/grub/themes/"$ID"/grub-16x9.png  /boot/grub/themes/"$ID"/grub-16x9.png.bkp

# Define paths
TARGET_DIR="/boot/grub/themes/$ID"
TARGET_FILE="$TARGET_DIR/grub-16x9.png"

# 1. Backup the existing file if it exists
if [ -f "$TARGET_FILE" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    sudo mv "$TARGET_FILE" "${TARGET_FILE}.bkp_${TIMESTAMP}"
fi



# Copy the background image to the destination
sudo cp resources/grub-16x9.png "/boot/grub/themes/$ID/"

