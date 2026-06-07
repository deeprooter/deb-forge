# deb-forge
This project build a debain package with a test payload to update the Kali linux splash image.
################HOWTO build package#############
1. in the current directory where the git repo is downloaded run the scrip build_pkg.sh script and you are done.
2. The debian pakage generated from the script is intentially named as John_Rambo.deb
3. The resources directory contains wallpapers that can be used to setup as splash screen.
By default there is a file named as grub-16x9.png which will be deployed as your potential splash screen if you install the John_Rambo.deb package. Please note that your original splash file will be backed up in directory before replacing.

####################HOWTO deploy the John_rambo.deb package################
1.Execute sudo apt install ./package-name.deb
2.sudo update-grub
3.reboot
4. You should see updated splash screen while Boot prompt displayed. 
