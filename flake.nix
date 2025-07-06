{
  description = "Simple OpenGL X11 demo using flake";

#   inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system} = {
      default = self.packages.${system}.quad;
        quad = pkgs.stdenv.mkDerivation {
    #     packages.${system}.quad = pkgs.stdenv.mkDerivation {
          pname = "quad";
          version = "0.1";

          src = ./.;
          buildInputs = [
            pkgs.xorg.libX11
            pkgs.libGL
            pkgs.libGLU
          ];
          shellHook = ''
              if [[ $- == *i* ]]; then
                export ORIGINAL_PS1="$PS1"
                export PS1="[nix-dev:\u@\h:\w] "
              fi
          '';

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
            name = "my-env";  # Optional, for context
          nativeBuildInputs = [
            pkgs.gcc
            pkgs.gnumake
            pkgs.xorg.libX11.dev
            pkgs.libGL
            pkgs.libGLU
          ];
        };
        packages.${system}.default = self.packages.${system}.quad;

      };
  };
}
