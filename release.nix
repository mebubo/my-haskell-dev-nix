let
  compiler = pkgs.haskell.packages.ghc863;
  config = {
    packageOverrides = pkgs: {
      hp = compiler.override {
        overrides = self: super: {
          criterion = self.criterion_1_5_3_0;
          vector-sized = self.vector-sized_1_2_0_0;
          haskell-names = self.callPackage ./haskell-names.nix {};
          singletons = self.singletons_2_5_1;
          th-desugar = self.th-desugar_1_9;
          RSA = pkgs.haskell.lib.dontCheck super.RSA;

          funflow = self.callPackage ../funflow/funflow {};
          funflow-examples = self.callPackage ../funflow/funflow-examples {};
          advent-of-code-2018 = self.callPackage ../advent-of-code-2018 {};
          codex = pkgs.haskell.lib.doJailbreak (self.callPackage ../codex {});
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in {
  funflow = pkgs.hp.funflow;
  funflow-examples = pkgs.hp.funflow-examples;
  advent-of-code-2018 = pkgs.hp.advent-of-code-2018;
  codex = pkgs.hp.codex;
}
