# Launch Windows Terminal with specific profile and command
Start-Process "wt.exe" '-p "Ubuntu-24.04" -- wsl -d Ubuntu-24.04 -e btop'

# Wait for the terminal window to appear
$hwnd = 0
$maxWait = 50
$count = 0

while (($hwnd -eq 0) -and ($count -lt $maxWait)) {
    Start-Sleep -Milliseconds 200
    $proc = Get-Process | Where-Object { $_.ProcessName -eq "WindowsTerminal" -and $_.MainWindowHandle -ne 0 } | Select-Object -First 1
    if ($proc) { $hwnd = $proc.MainWindowHandle }
    $count++
}

if ($hwnd -eq 0) {
    Write-Host "Windows Terminal window not found!"
    exit
}

# Add WinAPI MoveWindow
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll")]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@

# Get monitor 4 coordinates
Add-Type -AssemblyName System.Windows.Forms
$monitors = [System.Windows.Forms.Screen]::AllScreens

if ($monitors.Count -lt 4) {
    Write-Host "Less than 4 monitors detected. Exiting."
    exit
}

$mon4 = $monitors[3]   # monitor index is 0-based

$x = $mon4.Bounds.X
$y = $mon4.Bounds.Y
$width = $mon4.Bounds.Width
$height = $mon4.Bounds.Height

# Move the window
[WinAPI]::MoveWindow($hwnd, $x, $y, $width, $height, $true)

# Enable fullscreen (F11)

Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait("{F11}")
