let
  compiler = pkgs.haskellPackages;
  config = with pkgs.haskell.lib; {
    packageOverrides = pkgs: {
      hp = compiler.override {
        overrides = self: super: {
          funflow = self.callCabal2nix "funflow" ../../tweag/funflow/funflow {};
          funflow-examples = self.callCabal2nix "funflow-examples" ../funflow/funflow-examples {};
          build-systems-a-la-carte = self.callCabal2nix "build-systems-a-la-carte" ../../snowleopard/build {};
          purescript = doJailbreak (self.callCabal2nix "purescript" ../../purescript/purescript {});
          spago = self.callCabal2nix "spago" ../../spacchetti/spago {};
          dhall = self.dhall_1_25_0;
          dhall-json = unmarkBroken self.dhall-json_1_4_0;
          happy = self.callPackage ./happy.nix {};
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in with pkgs.hp; {
  inherit
  funflow
  funflow-examples
  build-systems-a-la-carte
  purescript
  spago
  ;
  hp = pkgs.hp;
}
