{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs
    pkgs.nodePackages.npm
  ];

  shellHook = ''
    export PATH=$PWD/node_modules/.bin:$PATH
    echo "Nix shell for VSCode theme packaging. Run: npx vsce package"
  '';
}
