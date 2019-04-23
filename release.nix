let
  compiler = pkgs.haskell.packages.ghc864;
  config = with pkgs.haskell.lib; {
    packageOverrides = pkgs: {
      hp = compiler.override {
        overrides = self: super: {
          haskell-names = doJailbreak super.haskell-names;
          async-pool = doJailbreak super.async-pool;
          these = doJailbreak super.these;

          funflow = self.callPackage ../funflow/funflow {};
          funflow-examples = self.callPackage ../funflow/funflow-examples {};
          advent-of-code-2018 = dontCheck (self.callPackage ../advent-of-code-2018 {});
          codex = (self.callPackage ../codex {}).override {
            Cabal = self.Cabal_2_4_1_0;
            hackage-db = self.hackage-db.override {
              Cabal = self.Cabal_2_4_1_0;
            };
          };
          aoc2018 = self.callPackage ../adventofcode/2018 {};
          purescript = self.callPackage ../purescript {};
          spago = self.callPackage ../spago {};
          codex-light = (self.callPackage ../codex-light {}).override {
            Cabal = self.Cabal_2_4_1_0;
          };
          codex-plan = self.callPackage ../codex-plan {};
          cabal-dependency-licenses = (self.callPackage ../cabal-dependency-licenses {}).override {
            Cabal = self.Cabal_2_4_1_0;
          };
          unison-parser-typechecker = self.callPackage ../unison/parser-typechecker {};
          guid = self.callPackage ../guid {};
          funflow-nix = dontCheck (self.callPackage ../funflow-nix {});
          funflow-example-map-scrapper = self.callPackage ../funflow-example-map-scrapper {};
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in with pkgs.hp; {
  inherit
  funflow
  funflow-examples
  advent-of-code-2018
  codex
  codex-light
  codex-plan
  aoc2018
  purescript
  spago
  dhall
  dhall-json
  cabal-install
  cabal2nix
  cabal-dependency-licenses
  unison-parser-typechecker
  funflow-nix
  funflow-example-map-scrapper
  ;
}
