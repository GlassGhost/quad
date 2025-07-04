    { pkgs ? import <nixpkgs> {} }:
      pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          stdenv
          gnumake
          xorg.libX11.dev
          xorg.libXft
          xorg.libXinerama
          libGLU
          libGL
          #libX11
          xcbutilxrm
          xorg.xcbutil
          xorg.xcbutilwm
          mesa
          freeglut
        ];
    }
