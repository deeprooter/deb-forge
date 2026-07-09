#!/bin/bash
set -e
#Flow:
#Create folder structure for the build environment
echo "#### Creatin the Directory structure for build"
source ./create-folders.sh
echo "Directory structure created ###"

#generate control file
echo "#### Generating control file"
source ./generate-control.sh
echo ""$TARGET_DIR"/DEBIAN/control ####"

#Deliver the payload to the Directory
#location of the payload1:${BUILD_DIR}/DEBIAN/postinst
cp ./postinst "${BUILD_DIR}/DEBIAN/"

echo "#### postinst delivered ####"

# Target workspace definitions
##############################
# TARGET_DIR Def exists in generate-control.sh create-folders.sh
#.deb package will be named on the TARGET_DIR
TARGET_DIR="change-splash"
##############################
DEB_PACKAGE="${TARGET_DIR}.deb"
CONTROL_FILE="$TARGET_DIR/DEBIAN/control"

# 1. Determine the next auto-incremented version number
echo "=== PHASE 1: Version Auto-Increment ==="
VERSION="1.0-1" # Fallback if no old control file exists
if [ -f "$CONTROL_FILE" ]; then
    # Extract existing Version field
    CURRENT_VERSION=$(grep "^Version:" "$CONTROL_FILE" | awk '{print $2}')

    if [[ "$CURRENT_VERSION" =~ ^([0-9]+\.[0-9]+)-([0-9]+)$ ]]; then
        BASE_VER="${BASH_REMATCH[1]}"
        RELEASE_NUM="${BASH_REMATCH[2]}"

        # Increment the release suffix by 1
        NEW_RELEASE=$((RELEASE_NUM + 1))
        NEW_VERSION="${BASE_VER}-${NEW_RELEASE}"

        # Safely update the Version entry inside the file
        sed -i "s/^Version:.*/Version: $NEW_VERSION/" "$CONTROL_FILE"
        echo "✓ Version bumped from $CURRENT_VERSION to $NEW_VERSION"
    else
        echo "⚠ Found control file but could not parse version format. Keeping defaults."
    fi
else
    echo "Error: '$CONTROL_FILE' not found. Run your metadata generator script first."
    exit 1
fi

# 2. Clean up old build outputs before proceeding
echo -e "\n=== PHASE 2: Cleaning Old Artifacts ==="
if [ -f "$DEB_PACKAGE" ]; then
    echo "Removing old package asset: $DEB_PACKAGE"
    rm "$DEB_PACKAGE"
else
    echo "Workspace is already clean."
fi

# 3. Build the fresh package with proper root permissions mapped automatically
echo -e "\n=== PHASE 3: Compilation under Root Map ==="
echo "📦 Building package structure..."
dpkg-deb --root-owner-group --build "$TARGET_DIR"
echo "Build completed successfully as: $DEB_PACKAGE"



#echo -e "\n=== PHASE 4: Local Deployment Test ==="
#read -p "🚀 Do you want to deploy and test the package now? (y/N): " CONFIRM
#if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
#    echo "⚙️ Triggering installation hook..."
#    sudo apt-get install --reinstall ./"$DEB_PACKAGE"
#    echo "✅ Pipeline sequence finished."
#else
#    echo "⏭️ Package deployment test skipped."
#fi
