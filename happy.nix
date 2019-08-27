{ mkDerivation, array, base, Cabal, containers, directory, filepath
, mtl, process, stdenv
}:
mkDerivation {
  pname = "happy";
  version = "1.19.9";
  sha256 = "3e81a3e813acca3aae52721c412cde18b7b7c71ecbacfaeaa5c2f4b35abf1d8d";
  revision = "3";
  editedCabalFile = "0kwlh964nyqvfbm02np8vpc28gbhsby0r65jhz1918rm0wip9izq";
  isLibrary = false;
  isExecutable = true;
  setupHaskellDepends = [ base Cabal directory filepath ];
  executableHaskellDepends = [ array base containers mtl ];
  testHaskellDepends = [ base process ];
  homepage = "https://www.haskell.org/happy/";
  description = "Happy is a parser generator for Haskell";
  license = stdenv.lib.licenses.bsd2;
}
