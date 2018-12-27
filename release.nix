let
  compiler = pkgs.haskell.packages.ghc863;
  config = with pkgs.haskell.lib; {
    packageOverrides = pkgs: {
      hp = compiler.override {
        overrides = self: super: {
          criterion = self.criterion_1_5_3_0;
          vector-sized = self.vector-sized_1_2_0_0;
          haskell-names = self.callPackage ./haskell-names.nix {};
          singletons = self.singletons_2_5_1;
          th-desugar = self.th-desugar_1_9;
          RSA = dontCheck super.RSA;
          megaparsec = self.megaparsec_7_0_4;
          protolude = self.protolude_0_2_3;
          async-pool = doJailbreak super.async-pool;
          repline = self.repline_0_2_0_0;
          dhall = dontCheck self.dhall_1_19_1;
          dhall-json = self.dhall-json_1_2_5;
          Cabal = self.Cabal_2_4_1_0;

          funflow = self.callPackage ../funflow/funflow {};
          funflow-examples = self.callPackage ../funflow/funflow-examples {};
          advent-of-code-2018 = dontCheck (self.callPackage ../advent-of-code-2018 {});
          codex = doJailbreak (self.callPackage ../codex {});
          aoc2018 = self.callPackage ../adventofcode/2018 {};
          purescript = self.callPackage ../purescript {};
          spago = self.callPackage ../spago {};
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
  aoc2018
  purescript
  spago
  dhall
  dhall-json
  pandoc
  cabal-install
  ;
}
