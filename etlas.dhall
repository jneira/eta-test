let prelude =
      https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/prelude.dhall sha256:079be4d5b0cccd4d3e3ef03369c86770864eb56dc28afcdfb5f52280dcaf9f3e

let types =
      https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/types.dhall sha256:7f440b74d4e727ccaaee1a714bd290b4fe92d5cd018f3a3a5ab218dc2b1e7a8b

let v = prelude.v

let pkg =
        λ(name : Text)
      → λ(version-range : types.VersionRange)
      → { bounds = version-range, package = name }

let pkgAnyVer = λ(packageName : Text) → pkg packageName prelude.anyVersion

let commonDeps =
      [ pkg
        "base"
        ( prelude.intersectVersionRanges
          (prelude.orLaterVersion (v "4.8"))
          (prelude.earlierVersion (v "4.12"))
        )
      , pkg "aeson" prelude.anyVersion
      ]

let updateRepo =
      prelude.utils.mapSourceRepos
      (   λ(srcRepo : types.SourceRepo)
        →   srcRepo
          ⫽ { tag =
                [ "0.1.0.0" ] : Optional Text
            , kind =
                types.RepoKind.RepoThis
            }
      )

let project =
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
            [ "eta-test.cabal" ]
        , library =
            prelude.unconditional.library
            (   prelude.defaults.Library
              ⫽ { exposed-modules =
                    [ "Lib" ]
                , hs-source-dirs =
                    [ "src" ]
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
                  }
              )
            ]
        }
    )
