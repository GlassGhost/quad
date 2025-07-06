{
  description = "Simple OpenGL X11 demo using flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.quad = pkgs.stdenv.mkDerivation {
      pname = "quad";
      version = "0.1";

      src = ./.;
      buildInputs = [
        pkgs.xorg.libX11
        pkgs.libGL
        pkgs.libGLU
      ];

      buildPhase = ''
        gcc -o quad quad.c -lX11 -lGL -lGLU
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp quad $out/bin/
      '';
    };
    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.quad}/bin/quad";
    };

    # For local dev environment like your shell.nix
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.gcc
        pkgs.gnumake
        pkgs.xorg.libX11.dev
        pkgs.libGL
        pkgs.libGLU
      ];
    };
  };
}
