    let prelude =
          https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/prelude.dhall sha256:79cc2d35ac1c25845b091f3d234014ccfd14b09dec99f9e4a16547f436a546e9

in  let types =
          https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/types.dhall sha256:c95cb0d15ccbf4634b6762122896e09e095da0555d1d223b48ac98ce716c8b5b

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
          , pkg "aeson" prelude.anyVersion
          ]

in  let updateRepo =
          prelude.utils.mapSourceRepos
          (   λ(srcRepo : types.SourceRepo)
            →   srcRepo
              ⫽ { tag =
                    [ "etlas-dhall" ] : Optional Text
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
