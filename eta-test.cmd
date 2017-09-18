@echo off
set DIR=%~dp0
for /f "tokens=*" %%i in ('powershell -Command "[console]::OutputEncoding.BodyName"') do set cp=%%i
set cp=%cp:﻿=%
echo %cp%
java -Dfile.encoding=%cp% -classpath "%DIR%\eta-test.launcher.jar" eta.main %*
