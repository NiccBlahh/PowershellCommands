Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("user32.dll")]
    public static extern short GetAsyncKeyState(int vKey);

    [DllImport("user32.dll")]
    public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);
}
"@

$VK_Z = 0x5A
$VK_ENTER = 0x0D

$MOUSEEVENTF_LEFTDOWN = 0x02
$MOUSEEVENTF_LEFTUP = 0x04

$clicking = $false
$clickIntervalMs = 100 # Adjust this value to change click speed (in milliseconds)

Clear-Host
Write-Host "Scanning for the last 10 executables run as Administrator..." -ForegroundColor Cyan

try {
    $recentAdminExecutables = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4688} -MaxEvents 5000 -ErrorAction Stop |
        Where-Object { 
            $_.Message -match "Token Elevation Type:\s*%%1931" -and 
            $_.Message -match "New Process Name:\s*(.*\.exe)"
        } | 
        Select-Object -First 10

    if ($recentAdminExecutables.Count -gt 0) {
        foreach ($evt in $recentAdminExecutables) {
            if ($evt.Message -match "New Process Name:\s*(.*\.exe)") {
                $exe = $matches[1]
                $time = $evt.TimeCreated
                Write-Host "[$time] $exe" -ForegroundColor DarkGray
            }
        }
    } else {
        Write-Host "No recent Admin executables detected (Process Creation Auditing might be disabled)." -ForegroundColor DarkGray
    }
} catch {
    Write-Host "[!] Could not read the Security event log." -ForegroundColor Red
}

Write-Host "`nPress Enter to exit" -ForegroundColor White
$null = Read-Host

# Clear the screen after the first Enter
Clear-Host

# BUG FIX: Wait until you completely let go of the Enter key before moving on!
# Otherwise, the script sees you are still holding Enter and thinks you want to close it immediately.
while (([Win32]::GetAsyncKeyState($VK_ENTER) -band 0x8000) -eq 0x8000) {
    Start-Sleep -Milliseconds 50
}
Start-Sleep -Milliseconds 200

while ($true) {
    # Check if ENTER is pressed to completely close the script
    $enterState = [Win32]::GetAsyncKeyState($VK_ENTER)
    if (($enterState -band 0x8000) -eq 0x8000) {
        break
    }

    # Check if Z is pressed
    $zState = [Win32]::GetAsyncKeyState($VK_Z)
    
    if (($zState -band 0x8000) -eq 0x8000) {
        $clicking = -not $clicking
        if ($clicking) {
            Write-Host "auto clicker on" -ForegroundColor Green
        } else {
            Write-Host "auto clicker off" -ForegroundColor Red
        }
        # Sleep briefly to debounce the key press
        Start-Sleep -Milliseconds 300 
    }

    if ($clicking) {
        # Perform the simulated click
        [Win32]::mouse_event($MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
        [Win32]::mouse_event($MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
        
        Start-Sleep -Milliseconds $clickIntervalMs
    } else {
        Start-Sleep -Milliseconds 50 
    }
}
