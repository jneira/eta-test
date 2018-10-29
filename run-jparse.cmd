etlas clean
etlas build --enable-uberjar-mode
javac -cp dist\build\eta-0.8.6.3\eta-test-0.1.0.0\x\eta-test-prog\build\eta-test-prog\eta-test-prog.jar java-main\JParse.java
java -cp java-main;dist\build\eta-0.8.6.3\eta-test-0.1.0.0\x\eta-test-prog\build\eta-test-prog\eta-test-prog.jar JParse
