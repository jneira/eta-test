let prelude =
      https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/prelude.dhall sha256:22685aa004763d3d783a116b307a3b3d61cc49aa48e6ff07257668336c27b4a9

let types =
      https://raw.githubusercontent.com/eta-lang/dhall-to-etlas/master/dhall/types.dhall sha256:4de5daf77713923a6510c4eff516a6f9caf9a52761fc0558d7a924eef0050e09

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
          → srcRepo ⫽ { tag = Some "0.1.0.1", kind = types.RepoKind.RepoThis }
        )

let project =
      prelude.utils.GitHub-project { owner = "jneira", repo = "eta-test" }

in  updateRepo
      (   project
        ⫽ { license-files = [ "LICENSE" ]
          , author = "Javier Neira Sanchez"
          , maintainer = "Javier Neira Sanchez <atreyu.bbb@gmail.com>"
          , version = v "0.1.0.0"
          , cabal-version = v "1.12"
          , extra-source-files = [ "eta-test.cabal" ]
          , library =
              prelude.unconditional.library
                (   prelude.defaults.Library
                  ⫽ { exposed-modules = [ "Lib" ]
                    , hs-source-dirs = [ "src" ]
                    , build-depends = commonDeps
                    }
                )
          , executables =
              [ prelude.unconditional.executable
                  "eta-test-prog"
                  (   prelude.defaults.Executable
                    ⫽ { build-depends = commonDeps # [ pkgAnyVer "eta-test" ]
                      , hs-source-dirs = [ "app" ]
                      , main-is = "Main.hs"
                      }
                  )
              ]
          }
      )
