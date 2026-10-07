{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      fontsConf = pkgs.makeFontsConf {
        fontDirectories = [
          pkgs.corefonts
        ];
      };

    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.nixfmt-rs
          pkgs.typst
          pkgs.typstyle
          pkgs.liberation_ttf
          pkgs.corefonts
        ];

        shellHook = ''
          export FONTCONFIG_FILE="${fontsConf}"
        '';
      };
    };
}
