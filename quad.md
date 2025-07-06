
### With `flake.nix`, you get:

- `nix develop`: spins up your dev environment (replaces `shell.nix`)
- `nix build`: builds your package
- `nix run`: launches your binary if defined in `apps`
- Reproducibility & remote sharing (via GitHub URLs, pinning, etc.)

So yes—**if your `flake.nix` is well-structured, you don’t need `shell.nix` anymore**.

[Ultimate Nix Flakes Guide - Vimjoyer](https://youtu.be/JCeYq72Sko0)

```
nix develop --no-warn-dirty
nix build
./result/bin/quad
```

______________________________________________________________________

### 🔙 When `shell.nix` might still be useful

Only in a few niche cases:
- You're working with tools or environments that don’t yet support flakes
- You’re onboarding someone who hasn’t enabled flake support yet
- You want to keep a fallback for non-flake `nix-shell` users

```
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
```

______________________________________________________________________

-Idir
   Specify  an  additional include path. Include paths are searched in the
   order they are specified.

   System include paths are always  searched  after.  The  default  system
   include     paths    are:    /usr/local/include,    /usr/include    and
   PREFIX/lib/tcc/include. (PREFIX is usually /usr or /usr/local).
-Ldir
     Specify an additional static library path for the -l option. The
     default library paths are /usr/local/lib, /usr/lib and /lib.

 -lxxx
     Link your program with dynamic library libxxx.so or static library
     libxxx.a. The library is searched in the paths specified by the -L
     option and LIBRARY_PATH variable.

 -Bdir
     Set the path where the tcc internal libraries (and include files) can
     be found (default is PREFIX/lib/tcc).

 -shared
     Generate a shared library instead of an executable.

```bash
echo | gcc -E -Wp,-v -
tcc -L/usr/lib -lX11 -lGL -lGLU ./quad -Idir \
 /nix/store/cnsbbj66kz0fdp41xhy9nd45pashpai7-gnumake-4.4.1/include \
 /nix/store/vj8zbmb5fzz9i5vs9nn904k7x8f21y8w-libX11-1.8.7-dev/include \
 /nix/store/nzw7krhdm0ijbfmskvqrzw9nabqygv18-xorgproto-2023.2/include \
 /nix/store/kqhlcmgr3cbg8b8wvisdcxq34l2y0814-libxcb-1.16-dev/include \
 /nix/store/15irnnkhrrmbik3wba57h1y0wvp8avdw-libXft-2.3.8-dev/include \
 /nix/store/7cqygan2568h6aisf9dnchs01spdkn4d-libXrender-0.9.11-dev/include \
 /nix/store/4q1b6baa364dx88s3h5dz4np2a0zsnrl-freetype-2.13.2-dev/include \
 /nix/store/9a4ivnm2hwggi6qjg0gcpk05f5hsw5r5-zlib-1.3-dev/include \
 /nix/store/xkdlrvnwfdjvr1l1k718gr9knfs1s5dz-bzip2-1.0.8-dev/include \
 /nix/store/mz8v2i7iq2w1b3r5zjxz0i4k2iggviwl-brotli-1.1.0-dev/include \
 /nix/store/j239iqdfsmz527i28pqw9b48dq31kimv-libpng-apng-1.6.40-dev/include \
 /nix/store/vb04m4a3qjlv036nv0zgfzmr5scyhfnw-fontconfig-2.14.2-dev/include \
 /nix/store/q0fxqx0xbp3i19q1qmvr4k7389w1vzy3-libXinerama-1.1.5-dev/include \
 /nix/store/ddjzs8h43a55a2q0mmfdbzs732dk2m7a-glu-9.0.3-dev/include \
 /nix/store/5951hf0fgy51yvmw8f7dinkglr0z22g9-libGL-1.7.0-dev/include \
 /nix/store/aq6nx26kl0pkfrszhjljgz52s4a3jvqh-xcb-util-xrm-1.3/include \
 /nix/store/n8qf2jzagdg8lii3xycpjzjjq8pcagnx-xcb-util-0.4.1-dev/include \
 /nix/store/1h9ix75zl32190mvrr4mkz7cbf52gpi2-xcb-util-wm-0.4.2-dev/include \
 /nix/store/7q4sjyh957pkx55c27w8ygmcrw9316a5-mesa-23.1.9-dev/include \
 /nix/store/n0ycahm6p87fl7h0lgfkr8xlhs1476nc-libXdamage-1.1.6-dev/include \
 /nix/store/l6yr6cwpa00a3q6sikzy97z8m5cgxjh9-libXfixes-6.0.1-dev/include \
 /nix/store/ilw8c31ycxaql2h25qszlpyj1xq49mjn-libXxf86vm-1.1.5-dev/include \
 /nix/store/d9x9cfy7w1dphrd21kd9wjb1aqn3yanq-libdrm-2.4.117-dev/include \
 /nix/store/kpw9h740nrhdrv2jd6wxr8m2b3r09wq0-freeglut-3.4.0-dev/include \
 /nix/store/hf2gy3km07d5m0p1lwmja0rg9wlnmyr7-gcc-12.3.0/lib/gcc/x86_64-unknown-linux-gnu/12.3.0/include \
 /nix/store/hf2gy3km07d5m0p1lwmja0rg9wlnmyr7-gcc-12.3.0/include \
 /nix/store/hf2gy3km07d5m0p1lwmja0rg9wlnmyr7-gcc-12.3.0/lib/gcc/x86_64-unknown-linux-gnu/12.3.0/include-fixed \
 /nix/store/mrgib0s2ayr81xv1q84xsjg8ijybalq3-glibc-2.38-27-dev/include \
```

