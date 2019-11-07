let
  pkgs = import <nixpkgs> { inherit config; };
  haskellPackages = pkgs.haskellPackages;
  config = with pkgs.haskell.lib; {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = self: super: {
          funflow = self.callCabal2nix "funflow" ../../tweag/funflow/funflow {};
          funflow-examples = self.callCabal2nix "funflow-examples" ../../tweag/funflow/funflow-examples {};
          docrecords = self.callCabal2nix "docrecords" ../../tweag/porcupine/docrecords {};
          reader-soup = self.callCabal2nix "reader-soup" ../../tweag/porcupine/reader-soup {};
          porcupine-core = self.callCabal2nix "porcupine-core" ../../tweag/porcupine/porcupine-core {};
          build-systems-a-la-carte = doJailbreak (self.callCabal2nix "build" ../../snowleopard/build {});
          purescript = doJailbreak ((self.callCabal2nix "purescript" ../../purescript/purescript {}).override {
            happy = self.happy_1_19_9;
          });
          spago = self.callCabal2nix "spago" ../../spacchetti/spago {};
          dhall = dontCheck (self.callCabal2nix "dhall" ../../dhall-lang/dhall-haskell/dhall {});
          dhall-json = self.callCabal2nix "dhall-json" ../../dhall-lang/dhall-haskell/dhall-json {};
          dhall-lsp-server = dontCheck (self.callCabal2nix "dhall-lsp-server" ../../dhall-lang/dhall-haskell/dhall-lsp-server {});

          algebraic-graphs = dontCheck (unmarkBroken super.algebraic-graphs);
          happy_1_19_9 = self.callPackage ./happy.nix {};
          vinyl = doJailbreak (unmarkBroken super.vinyl);
          streaming-conduit = doJailbreak (unmarkBroken super.streaming-conduit);
        };
      };
    };
  };
  tags = p: pkgs.callPackage ../haskell-sources-tags-nix/tag-sources.nix {
    inherit pkgs haskellPackages;
    packages = [ p ];
  };
in with pkgs.haskellPackages; {
  inherit
  funflow
  funflow-examples
  porcupine-core
  build-systems-a-la-carte
  purescript
  spago
  dhall
  dhall-json
  dhall-lsp-server
  ;

  dhall-lsp-server-tags = tags dhall-lsp-server;
}
