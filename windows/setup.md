# Setup guides
Guides to setup windows tools

## Legacy setup

### Setup Windows Terminal on Windows 10
1. Download executable from [mircosoft/terminal](https://github.com/microsoft/terminal/releases)
2. Copy executable into `~/Programs` directory
3. Open Registory Editor
4. Create Key: `Computer\HKEY_CLASSES_ROOT\directory\background\shell\Terminal`  
    * (Default) | REG_EXPAND_SZ | Open With Terminal
    * Icon | REG_EXPAND_SZ | `<PATH_TO_TERMINAL.exe>`
5. Create subkey: `Computer\HKEY_CLASSES_ROOT\directory\background\shell\Terminal\command`
    * (default) | REG_EXPAND_SZ | `<PATH_TO_TERMINAL.exe> -d "%V"`
           
## [FZF](https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration)
```powershell
winget install fzf
Install-Module -Name PSFzf
```

## Using USBIPD
Attach USB devices to WSL2

### Attaching Yubikey to WSL

1. Add usermod group
```
sudo usermod -aG plugdev $USER
```

2. Restart WSL
```
wsl --shutdown
```

3. Install yubikey-manager and fido2-tools
```
sudo apt install yubikey-manager
sudo apt install fido2-tools
```

4. Add Udev rules
```
sudo vi /etc/udev/rules.d/99-yubikey.rules
```
```
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
```

5. Reload rules
```
sudo udevadm control --reload-rules
sudo udevadm trigger
```

6. Check working
```
> FIDO_DEBUG=1 fido2-token -L
run_manifest: found 1 hid device
run_manifest: found 0 nfc devices
/dev/hidraw1: vendor=0x1050, product=0x0407 (Yubico YubiKey OTP+FIDO+CCID)
```

7. Generate SSH-key
```
ssh-keygen -t ed25519-sk
or
ssh-keygen -t ed25519-sk -O resident -O no-touch-required
```


## Using USBIP on Fedora

1. Install USBIP

2. Attach USB device from Fedora using `sudo usbip attach -r 192.168.10.1 -b 1-4`
3. Use `lsusb` to check if device is attached
4. Use `fido2-token -L` to see if Security Key is recognised. (Continue if you see permission denied)
5. Create plugdev group:
```
sudo groupadd plugdev
sudo usermod -aG plugdev $USER
```
Apply new group
```
newgrp plugdev
```
6. Create rule (For trustkey, use the previous example for yubikey)
`sudo nano /etc/udev/rules.d/70-trustkey-fido.rules`
Add this:
```
# TrustKey G320H FIDO2 key
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="plugdev", TAG+="uaccess", ATTRS{idVendor}=="311f", ATTRS{idProduct}=="4a2a"
```
6. Reload rules
```
sudo udevadm control --reload-rules
sudo udevadm trigger
```
7. Test it `fido2-token -L`

## Setup GPG on WSL
> [!NOTE]  
> DOES NOT WORK RELIABLY ON WSL

Add windows' gpg.exe path to WSL (e.g. `C:\Program Files\GnuPG\bin`)

Then use `gpg.exe` for everything


