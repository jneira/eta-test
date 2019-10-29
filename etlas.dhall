let prelude =
      https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/prelude.dhall sha256:70cd34dd7884336f82875950a74076bac538eb511b83703f5818a1d50cbe0dea

let types =
      https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/types.dhall sha256:f1376671820900d7e97de52f5803f1279d5052c2b8db47896fb0bfa33e254f0a

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
      ]

let updateRepo =
      prelude.utils.mapSourceRepos
      (   λ(srcRepo : types.SourceRepo)
        →   srcRepo
          ⫽ { tag =
                Some "0.1.0.1"
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
