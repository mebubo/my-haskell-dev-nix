let
  compiler = pkgs.haskell.packages.ghc863;
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
  aoc2018
  purescript
  spago
  dhall
  dhall-json
  cabal-install
  cabal2nix
  ;
}
