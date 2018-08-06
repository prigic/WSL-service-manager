@echo off
 :: BatchGotAdmin
 :-------------------------------------
 REM  --> Check for permissions
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
 if '%errorlevel%' NEQ '0' (
     echo Requesting administrative privileges...
     goto UACPrompt
 ) else ( goto gotAdmin )

:UACPrompt
     echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
     echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
     exit /B

:gotAdmin
     if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
     pushd "%CD%"
     CD /D "%~dp0"
 :-------------------------------------- 

:main
cls
echo.
echo ----- WSL Service Manager -----
echo.
echo.
echo  1. WSL Start
echo.
echo  2. WSL Stop
echo.
echo  3. WSL Restart
echo.
echo  4. Exit
echo.
echo.
echo  Enter number selection and press Enter
echo.
set /p a=Num : 
if %a%==1 goto start
if %a%==2 goto stop
if %a%==3 goto restart
if %a%==4 goto exit

:start
cls
sc start LxssManager
timeout /t 5
goto main

:stop
cls
sc stop LxssManager
timeout /t 5
goto main

:restart
cls
sc stop LxssManager
timeout /t 5 /nodreak
sc start LxssManager
timeout /t 5
goto main

:exit
exit