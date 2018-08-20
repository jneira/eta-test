ren eta-test.cabal eta-test.cabal.old
ren etlas.dhall.old etlas.dhall
rmdir dist /s /q
etlas build > output.dhall.txt 2>&1
