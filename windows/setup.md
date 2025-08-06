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
