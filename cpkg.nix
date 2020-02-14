let
  pkgs = import <nixpkgs> { inherit config; };
  haskellPackages = pkgs.haskellPackages;
  config = with pkgs.haskell.lib; {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = self: super: {
          dhall = super.dhall_1_29_0;
          libarchive = dontCheck (unmarkBroken super.libarchive);
          chs-cabal = (unmarkBroken super.chs-cabal).override {
            Cabal = self.Cabal_3_0_0_0;
          };
          cpkg = self.callCabal2nix "cpkg" ../../vmchale/cpkg {};
        };
      };
    };
  };
  haskellBuildInputs = p: (pkgs.haskell.lib.getBuildInputs p).haskellBuildInputs;
  tags = p: pkgs.callPackage ../haskell-sources-tags-nix/tag-sources.nix {
    inherit pkgs haskellPackages;
    packages = haskellBuildInputs p;
  };
in with pkgs.haskellPackages; {
  inherit
  cpkg;
  tags = tags cpkg;
}
