@echo off
set DIR=%~dp0
java  -classpath "%DIR%\eta-test.launcher.jar" %JAVA_ARGS% %JAVA_OPTS% eta.main %*

