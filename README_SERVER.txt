SERVER PC - PRINTER SHARING FIXES
==================================

This folder contains scripts for PCs that HAVE a printer installed
and want to SHARE it with other PCs on the network.

WHICH PC IS THIS?
=================
- This PC has a printer physically connected (USB, network, etc.)
- This PC wants to share the printer with other PCs
- Other PCs are getting error 0x00011b when trying to connect

SCRIPTS IN THIS FOLDER:
======================

1. fix_server_printer_sharing.bat
   - Main fix for server sharing issues
   - Fixes registry, services, and sharing settings
   - RUN THIS FIRST

2. enable_printer_sharing.bat
   - Enables printer sharing services
   - Use if you just need to enable sharing

HOW TO USE:
===========

STEP 1: Run the main fix
- Right-click "fix_server_printer_sharing.bat"
- Select "Run as administrator"
- Follow the prompts

STEP 2: Manually share your printer
- Go to Control Panel > Devices and Printers
- Right-click your printer > Printer Properties
- Go to Sharing tab
- Check "Share this printer"
- Give it a share name (e.g., "CanonPrinter")
- Click OK

STEP 3: Tell other PCs
- Give other PCs your IP address
- Tell them to run the CLIENT_PC scripts
- Give them the printer share name

IMPORTANT:
==========
- You need Administrator privileges
- Make sure your printer is actually shared after running scripts
- Other PCs need to run CLIENT_PC scripts to connect
