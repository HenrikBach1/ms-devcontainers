@REM install-and-enable-hyper-v-windows-11.bat
@REM Inspiration from:
@REM    https://gist.github.com/1eedaegon/2535436ade80b28e4d97f517c6434638

pushd
%~dp0
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hv.txt
for /f %%i in ('findstr /i . hv.txt 2^>nul') do dism /online /norestart /add-package:%SystemRoot%\servicing\Packages\%%i
del hv.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
pause