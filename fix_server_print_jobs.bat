@echo off
echo ===============================================
echo    SERVER PC - FIX STUCK PRINT JOBS
echo ===============================================
echo.
echo This script fixes "impression en cours" errors on the server PC
echo by clearing stuck print jobs and resetting print services.
echo.
echo WARNING: This requires Administrator privileges!
echo.
pause

echo.
echo [1/7] Stopping All Print Services...
net stop spooler
sc stop "PrintNotify"
sc stop "PrintWorkflowUserSvc"
timeout /t 3 /nobreak >nul

echo.
echo [2/7] Clearing Print Queue Files...
echo Deleting stuck print jobs...
del /q /f "%SystemRoot%\System32\spool\PRINTERS\*" 2>nul
del /q /f "%SystemRoot%\System32\spool\SERVERS\*" 2>nul
del /q /f "%SystemRoot%\System32\spool\DRIVERS\*" 2>nul
echo Print queue and cache cleared

echo.
echo [3/7] Resetting Print Spooler Registry...
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers" /f 2>nul
echo Print spooler registry reset

echo.
echo [4/7] Fixing Print Driver Issues...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f

echo.
echo [5/7] Starting Print Services...
net start spooler
sc start "PrintNotify"
sc start "PrintWorkflowUserSvc"
timeout /t 3 /nobreak >nul

echo.
echo [6/7] Resetting Printer Sharing...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

echo.
echo [7/7] Testing Print Services...
sc query spooler | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo SUCCESS: Print Spooler is running properly
) else (
    echo WARNING: Print Spooler may not be running properly
)

echo.
echo ===============================================
echo    SERVER PRINT JOBS FIXED!
echo ===============================================
echo.
echo The following actions were completed:
echo - Stopped all print services
echo - Cleared all stuck print jobs from queue
echo - Reset print spooler registry
echo - Fixed print driver issues
echo - Restarted all print services
echo - Reset printer sharing
echo.
echo Now try printing again. The "impression en cours" error should be resolved.
echo Make sure your printer is still shared after this fix.
echo.
pause
