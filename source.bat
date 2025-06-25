@echo off
title DokiDoki.rpa
color 0D
cls

set file=No file
set option=
set extension=
set bool=false
set check=rpa
set doki=installed

:: check if python is installed
echo Verifying if Python is installed...
python --version >nul 2>&1
IF %errorlevel%==0 (
    echo Python is installed!
) ELSE (
    color 04
    set doki=not installed
    echo [ERROR]: Python is not installed or not added to PATH.
    pause
    exit /b
)

:: load RPC
echo Loading RPC...
start "" /b python assets\api\isRPC.py "%file%" "%option%" "%extension%" "%bool%"
echo Loaded RPC!
timeout /t 1 >nul
cls

setlocal enabledelayedexpansion
for /f "tokens=2" %%a in ('tasklist /fi "imagename eq cmd.exe" /fo list ^| findstr /i "PID"') do (
    set PID=%%a
    goto :pid_done
)
:pid_done
echo PID: !PID!
timeout /t 2 >nul
cls

:: banner
echo ==========================================================================
echo         Doki Doki RPA by levyzdev (Python: %doki%)
echo ==========================================================================

:: question
set /p option=Extract or Decompile (E/D):
set /p file=File (no extension):

:: option if
IF /I "%option%"=="E" (
    set extension=.rpa
    set check=check "%file%" dir!
) ELSE (
    set extension=.rpyc
    set check=check put_rpyc dir!
)

set bool=true

:: change RPC
echo Changing RPC...
start "" /b python assets\api\isRPC.py "%file%" "%option%" "%extension%" "%bool%"
echo Changed!
timeout /t 1 >nul
cls
color 0A

:: banner
echo ==========================================================================
echo         Doki Doki RPA by levyzdev
echo ==========================================================================

:: create output folder
set "outfolder=%file%"
md "%outfolder%" >nul 2>&1

IF "%extension%"==".rpyc" (
    dir /b "put_rpyc\*.rpyc" >nul 2>&1
    if errorlevel 1 (
        color 04
        echo [ERROR]: No .rpyc files found in "put_rpyc" directory.
        pause
        exit /b
    )

    echo.
    echo [UPD] Decompiling .rpyc files to "%outfolder%"...
    for %%f in (put_rpyc\*.rpyc) do (
        set "base=%%~nf"
        set "comfolder=%outfolder%\!base!"
        echo Decompiling %%f...
        md "!comfolder!" >nul 2>&1
        python assets\api\unrpyc.py "!cd!\%%f"
    )
) ELSE (
    if not exist "..\%file%.rpa" (
        color 04
        echo [ERROR]: File ..\%file%.rpa not found.
        pause
        exit /b
    )
    echo.
    echo [UPD] Extracting files from %file%%extension% to "%outfolder%"...
    python assets\api\rpatool.py -x "..\%file%%extension%" -o "%cd%\%outfolder%"
)

echo.
color 0A
echo [INFO] Done, %check% 
pause
exit
