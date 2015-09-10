@echo off
REM      BATCH FILE CREATED BY CHARLES DE HAVILLAND 10/09/2015
cls
net session >nul 2>&1
    if %errorLevel% == 0 (
        echo.
    ) else (
        GOTO :NOPERM
    )
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
@cd /d "%~dp0"
for %%* in (.) do set RULENAME=%%~nx*
ECHO|set /p ="- Add "
call :ColorText 0a "Block In & Out "
ECHO  Firewall rules for all *.exe ^& *.dll files
ECHO.
ECHO|set /p = "- located at '"
  call :ColorText 0b "%CD%'" 
ECHO  (inc subfolders)
ECHO.
ECHO|set /p = "- creating "
  call :ColorText 1b "%RULENAME%"
ECHO  as the Firewall rule name ?
ECHO.
ECHO.
ECHO.
ECHO Press any key to continue  or  CTRL+C to terminate now ...
pause >nul
cls
Echo.
FOR /r %%G in ("*.exe") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes")
FOR /r %%G in ("*.exe") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes")
FOR /r %%G in ("*.dll") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes")
FOR /r %%G in ("*.dll") Do (@echo %%G
NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes")
Echo.
  call :ColorText 0a "done"
ECHO|set /p =" ... Goodbye"
ECHO.
ECHO.
ECHO Press a key to exit ...
pause >nul
goto :eof

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

:Finish
Echo.
Echo.
Echo Batch ended...
Goto :END

:NOPERM
ECHO.
ECHO   You must run this file in CMD as 'Administrator'
ECHO.
ECHO.
ECHO.
ECHO   Press any key to exit ...
Pause >NUL
ECHO.
ECHO   Goodbye
ECHO.
ECHO.
:END
