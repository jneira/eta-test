    let prelude =
          https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/prelude.dhall sha256:47a62403bcd28107cb0a99b05fc4d8bc73f06277c422d059ba9efdd50307abbc

in  let types =
          https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/types.dhall sha256:d36b3384c6e0dc1837f5740b14eb20b1c51de1cb16a8008ee577d7d8f7ea115e

in  let v = prelude.v

in  let defaultLang =
          [ prelude.types.Languages.Haskell2010 {=} ] : Optional types.Language

in  let pkg =
            λ(name : Text)
          → λ(version-range : types.VersionRange)
          → { bounds = version-range, package = name }

in  let pkgAnyVer = λ(packageName : Text) → pkg packageName prelude.anyVersion

in  let commonDeps =
          [ pkg
            "base"
            ( prelude.intersectVersionRanges
              (prelude.orLaterVersion (v "4.8"))
              (prelude.earlierVersion (v "4.12"))
            )
          ]

in  let updateRepo =
          prelude.utils.mapSourceRepos
          (   λ(srcRepo : types.SourceRepo)
            →   srcRepo
              ⫽ { tag =
                    [ "0.1.0.0" ] : Optional Text
                , kind =
                    prelude.types.RepoKind.RepoThis {=}
                }
          )

in  let project =
          prelude.utils.GitHub-project { owner = "jneira", repo = "eta-test" }

in  updateRepo
    (   project
      ⫽ { license-files =
            [ "LICENSE" ]
        , author =
            "Javier Neira Sanchez"
        , maintainer =
            "Javier Neira Sanchez <atreyu.bbb@gmail.com>"
        , version =
            v "0.1.0.0"
        , cabal-version =
            v "1.12"
        , extra-source-files =
            [ "eta-test.cabal" ] : List Text
        , library =
            prelude.unconditional.library
            (   prelude.defaults.Library
              ⫽ { exposed-modules =
                    [ "Lib" ]
                , hs-source-dirs =
                    [ "src" ]
                , default-language =
                    defaultLang
                , build-depends =
                    commonDeps
                }
            )
        , executables =
            [ prelude.unconditional.executable
              "eta-test-prog"
              (   prelude.defaults.Executable
                ⫽ { build-depends =
                      commonDeps # [ pkgAnyVer "eta-test" ]
                  , hs-source-dirs =
                      [ "app" ]
                  , main-is =
                      "Main.hs"
                  , default-language =
                      defaultLang
                  }
              )
            ]
        }
    )
