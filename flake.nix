{
  description = "A command-line utility for local notes management";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    secrets.url = "github:randoragon/secrets";
    lxmake.url = "github:randoragon/lxmake";
  };
  outputs = { self, nixpkgs, secrets, lxmake }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = nixpkgs.legacyPackages;
      deps = system: with pkgsFor.${system}; [
        coreutils
        findutils
        gnused
        git
        rsync
        fzf bemenu

        md4c
        typst
        lilypond
      ] ++ [
        secrets.packages.${system}.default
        lxmake.packages.${system}.default
      ];
      note = system: pkgsFor.${system}.runCommand "note" {
        nativeBuildInputs = with pkgsFor.${system}; [ makeWrapper ];
      } ''
        mkdir -p "$out/bin"
        cp ${./note} "$out/bin/note"
        wrapProgram "$out/bin/note" \
          --prefix PATH : ${pkgsFor.${system}.lib.makeBinPath (deps system)}
      '';
    in {
      packages = forAllSystems (system: {
        default = note system;
      });

      devShells = forAllSystems (system: {
        default = pkgsFor.${system}.mkShell {
          buildInputs = deps system;
        };
      });
    };
}
