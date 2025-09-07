@echo off
echo ===============================================
echo    SERVER PC - ENABLE PRINTER SHARING
echo ===============================================
echo.
echo This script enables printer sharing on the server PC
echo (the PC that has the printer physically connected)
echo.

echo [1/4] Enabling File and Printer Sharing...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

echo.
echo [2/4] Starting Required Services...
sc config "LanmanServer" start= auto
sc start "LanmanServer"
sc config "LanmanWorkstation" start= auto
sc start "LanmanWorkstation"
sc config "Spooler" start= auto
sc start "Spooler"

echo.
echo [3/4] Enabling Network Discovery...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoInplaceSharing /t REG_DWORD /d 0 /f

echo.
echo [4/4] Setting Printer Sharing Registry...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f

echo.
echo ===============================================
echo    PRINTER SHARING ENABLED!
echo ===============================================
echo.
echo Now you need to manually share your printer:
echo.
echo MANUAL STEPS:
echo 1. Press Windows + R, type "control printers"
echo 2. Right-click your printer
echo 3. Select "Printer Properties"
echo 4. Go to "Sharing" tab
echo 5. Check "Share this printer"
echo 6. Enter a share name (e.g., "CanonPrinter")
echo 7. Click OK
echo.
echo Your printer is now shared and other PCs can connect to it!
echo.
pause
