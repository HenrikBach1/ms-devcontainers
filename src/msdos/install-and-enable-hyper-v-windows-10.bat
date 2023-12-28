@REM .devcontainer\HYPER-V Package Installer.bat
@REM Inspiration from:
@REM    https://github.com/MicrosoftDocs/Virtualization-Documentation/issues/915
@REM Tested on:
@REM    Windows 10 Home

dir /b "%SystemRoot%\servicing\Packages\*Hyper-V*.mum" > hyper-v.txt
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hyper-v.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
pause