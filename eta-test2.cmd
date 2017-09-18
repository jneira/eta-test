@echo off
set DIR=%~dp0
for /f "tokens=2 delims=:" %i in ('chcp') do set cp= %i
chcp 65001
java -Dfile.encoding=UTF-8 -classpath "%DIR%\eta-test.launcher.jar" eta.main %*
chcp %cp%
