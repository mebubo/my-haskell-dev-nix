let
  config = {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: {
          bears = haskellPackagesOld.callCabal2nix "bears" ../../Gabriel439/Haskell-Bears-Library { };
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
  haskellPackages = pkgs.haskellPackages;

in
  pkgs.callPackage ../haskell-sources-tags-nix/tag-sources.nix {
    inherit pkgs haskellPackages;
    packages = (with haskellPackages; [ adjunctions fused-effects polysemy turtle lens bears ]);
  }


