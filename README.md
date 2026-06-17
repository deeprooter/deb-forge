# 📦 Bash-to-Debian Packaging Framework

A framework for packaging Bash automation scripts into `.deb` binaries. This project currently features a GRUB splash image updater equipped with automatic backup functionality.

This repository builds a Debian package containing a test payload designed to safely update the Kali Linux splash image.

---

## 🛠️ How to Build the Package

To generate the Debian package, run the build script from the root directory of your cloned repository:

```bash
./build_pkg.sh
```

### 📝 Important Build Notes:
* **Output Binary:** The script intentionally generates a package named `John_Rambo.deb`.
* **Customizing Assets:** The `resources/` directory contains wallpapers available for your splash screen. 
* **Default Payload:** By default, the framework uses `grub-16x9.png`. Installing the package will deploy this file as your new splash screen.
* **Safety First:** Your original splash screen file is automatically backed up in its original directory before any replacement occurs.

---

## 🚀 How to Deploy the `John_Rambo.deb` Package

Follow these steps to install the package and apply your new GRUB splash screen:

### 1. Install the package
Navigate to the directory containing your generated `.deb` file and run:
```bash
sudo apt install ./John_Rambo.deb
```

### 2. Update the GRUB configuration
Apply the changes to your bootloader:
```bash
sudo update-grub
```

### 3. Reboot your system
Restart your machine to initialize the new configurations:
```bash
sudo reboot
```

### 4. Verify the deployment
You should now see your updated splash screen displayed during the system boot prompt.



---

# Future ideas for the project
### 1. Implementing customization for Zorin and Ubuntu Linux destros.
### 2. Rollback feature restoring the previous configuration.
### 3. Providing more control to the user over payload selection.
### 4. implementing SOTA functionality on a host maching using the payload. 



### <EOF>
