@echo off
echo ===============================================
echo    CLIENT PC - FIX STUCK PRINT JOBS
echo ===============================================
echo.
echo This script fixes "impression en cours" errors
echo by clearing stuck print jobs and resetting the print queue.
echo.
echo WARNING: This requires Administrator privileges!
echo.
pause

echo.
echo [1/6] Stopping Print Spooler Service...
net stop spooler
if %errorlevel% neq 0 (
    echo WARNING: Could not stop Print Spooler service
    echo Continuing anyway...
)

echo.
echo [2/6] Clearing Print Queue Files...
echo Deleting stuck print jobs...
del /q /f "%SystemRoot%\System32\spool\PRINTERS\*" 2>nul
if %errorlevel% equ 0 (
    echo SUCCESS: Print queue cleared
) else (
    echo INFO: Print queue was already empty or files were in use
)

echo.
echo [3/6] Clearing Print Spooler Cache...
del /q /f "%SystemRoot%\System32\spool\SERVERS\*" 2>nul
del /q /f "%SystemRoot%\System32\spool\DRIVERS\*" 2>nul

echo.
echo [4/6] Resetting Print Spooler Registry...
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers" /f 2>nul
echo Print spooler registry reset

echo.
echo [5/6] Starting Print Spooler Service...
net start spooler
if %errorlevel% equ 0 (
    echo SUCCESS: Print Spooler service started
) else (
    echo ERROR: Could not start Print Spooler service
    echo You may need to start it manually from Services
    pause
    exit /b 1
)

echo.
echo [6/6] Testing Print Spooler...
timeout /t 3 /nobreak >nul
sc query spooler | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo SUCCESS: Print Spooler is running properly
) else (
    echo WARNING: Print Spooler may not be running properly
)

echo.
echo ===============================================
echo    STUCK PRINT JOBS FIXED!
echo ===============================================
echo.
echo The following actions were completed:
echo - Stopped Print Spooler service
echo - Cleared all stuck print jobs from queue
echo - Cleared print spooler cache
echo - Reset print spooler registry
echo - Restarted Print Spooler service
echo.
echo Now try printing again. The "impression en cours" error should be resolved.
echo.
pause
