@echo off
set DIR=%~dp0
if defined JAVA_HOME goto findJavaFromJavaHome
set ETA_JAVA_CMD=java.exe
goto init
:findJavaFromJavaHome
set ETA_JAVA_HOME=%JAVA_HOME:"=%
set ETA_JAVA_CMD=%ETA_JAVA_HOME%\bin\java.exe
:init
"%ETA_JAVA_CMD%" -version
rem "%ETA_JAVA_CMD%" %JAVA_ARGS% %JAVA_OPTS% %ETA_JAVA_ARGS% -classpath "%DIR%\eta-test.launcher.jar" eta.main %*

