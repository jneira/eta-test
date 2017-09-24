@echo off
set DIR=%~dp0
set ETA_JAVA_PROG=java.exe
if defined JAVA_HOME (
  set JAVA_HOME=%JAVA_HOME:"=%
  set ETA_JAVA_PROG=%JAVA_HOME%\bin\%ETA_JAVA_PROG%
)

"%ETA_JAVA_PROG%"  -classpath "%DIR%\eta-test.launcher.jar" %JAVA_ARGS% %JAVA_OPTS% eta.main %*

