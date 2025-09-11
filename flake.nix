{
  description = "R Data Science Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; # For Positron
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            positron-bin
            quarto
            R
            
            # for LaTeX:
            # texlive.combined.scheme-medium
            # tectonic
          ]  ++
          
          (with pkgs.rPackages; [
            devtools
            froggeR
            fs
            glue
            here
            kableExtra
            knitr
            quarto
            shiny
            table1
            tidyverse
            
            # add others below here...
          ]);

          shellHook = ''
            echo "📊 r-accessories R & Quarto Environment Ready"
          '';
        };
      });
}
