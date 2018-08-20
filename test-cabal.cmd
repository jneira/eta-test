ren eta-test.cabal.old eta-test.cabal
ren etlas.dhall etlas.dhall.old
etlas clean
etlas build > output.cabal.txt 2>&1
