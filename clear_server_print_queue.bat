@echo off
echo ===============================================
echo    SERVER PC - CLEAR PRINT QUEUE
echo ===============================================
echo.
echo This script quickly clears the print queue on the server PC
echo to resolve stuck print jobs.
echo.

echo [1/4] Stopping Print Services...
net stop spooler
sc stop "PrintNotify"
timeout /t 2 /nobreak >nul

echo [2/4] Clearing Print Queue...
del /q /f "%SystemRoot%\System32\spool\PRINTERS\*" 2>nul
del /q /f "%SystemRoot%\System32\spool\SERVERS\*" 2>nul
echo Print queue cleared

echo [3/4] Starting Print Services...
net start spooler
sc start "PrintNotify"
timeout /t 2 /nobreak >nul

echo [4/4] Verifying Services...
sc query spooler | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo SUCCESS: Print services are running
) else (
    echo WARNING: Print services may not be running properly
)

echo.
echo ===============================================
echo    SERVER PRINT QUEUE CLEARED!
echo ===============================================
echo.
echo The print queue has been cleared on the server.
echo Try printing again now.
echo.
pause
