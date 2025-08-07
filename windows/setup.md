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

4. Check working
```
> FIDO_DEBUG=1 fido2-token -L
run_manifest: found 1 hid device
run_manifest: found 0 nfc devices
/dev/hidraw1: vendor=0x1050, product=0x0407 (Yubico YubiKey OTP+FIDO+CCID)
```

5. Add Udev rules
```
sudo vi /etc/udev/rules.d/99-yubikey.rules
```
```
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
```

6. Reload rules
```
sudo udevadm control --reload-rules
sudo udevadm trigger
```

7. Generate SSH-key
```
ssh-keygen -t ed25519-sk
or
ssh-keygen -t ed25519-sk -O resident -O no-touch-required
```
