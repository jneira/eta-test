ren eta-test.cabal eta-test.cabal.old
ren etlas.dhall.old etlas.dhall
rmdir dist /s /q
etlas build -v3 > output.dhall.txt 2>&1
ecw output.dhall.txt
