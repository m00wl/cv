{
  description = "flake for m00wl's CV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-minimal latex-bin latexmk;
      };
      cv = pkgs.stdenvNoCC.mkDerivation {
        name = "cv";
        src = self;
        buildInputs = [
          pkgs.coreutils
          tex
        ];
        buildPhase = ''
          mkdir -p .cache/texmf-var
          env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
            latexmk -interaction=nonstopmode -pdf -lualatex \
            cv.tex
        '';
        installPhase = ''
          mkdir -p $out
          cp cv.pdf $out/
        '';
      };
      cv-inspect = pkgs.writeShellScriptBin "cv-inspect" ''
        ${pkgs.exiftool}/bin/exiftool ${cv}/cv.pdf
      '';
    in
    {
      packages = flake-utils.lib.flattenTree {
        inherit cv;
      };
      defaultPackage = self.packages.${system}.cv;
      apps = {
        cv-inspect = flake-utils.lib.mkApp {
          drv = cv-inspect;
        };
      };
      defaultApp = self.apps.${system}.cv-inspect;
      devShell = pkgs.mkShell {
        buildInputs = cv.buildInputs ++ [
          pkgs.exiftool
        ];
      };
    }
  );
}
