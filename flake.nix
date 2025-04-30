{
  description = "vnpy with nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
    ta-lib-nix.url = "github:reAsOn2010/vnpy/nix?dir=ta-lib";
    ta-lib-python-nix.url = "github:reAsOn2010/vnpy/nix?dir=ta-lib-python";
  };

  outputs = { self, nixpkgs, flake-utils, 
              ta-lib-nix, ta-lib-python-nix, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
          ta-lib = ta-lib-nix.packages.${system}.default;
          ta-lib-python = ta-lib-python-nix.packages.${system}.default;
        in
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              stdenv.cc.cc 
              gcc
              glibc
              glibc_multi
              python313
              ta-lib
              ta-lib-python
              pkg-config
              meson
              ninja
            ];
            buildInputs = with pkgs; [
              acl
              attr
              bzip2
              dbus
              expat
              fontconfig
              freetype
              fuse3
              icu
              libnotify
              libsodium
              libssh
              libunwind
              libusb1
              libuuid
              nspr
              nss
              stdenv.cc.cc
              util-linux
              zlib
              zstd 

              pipewire
              cups
              libxkbcommon
              pango
              mesa
              libdrm
              libglvnd
              libpulseaudio
              atk
              cairo
              alsa-lib
              at-spi2-atk
              at-spi2-core
              gdk-pixbuf
              glib
              gtk3
              libGL
              libappindicator-gtk3
              vulkan-loader
              xorg.libX11
              xorg.libXScrnSaver
              xorg.libXcomposite
              xorg.libXcursor
              xorg.libXdamage
              xorg.libXext
              xorg.libXfixes
              xorg.libXi
              xorg.libXrandr
              xorg.libXrender
              xorg.libXtst
              xorg.libxcb
              xorg.libxkbfile
              xorg.libxshmfence

              xorg.xcbutilwm
              xorg.xcbutilimage
              xorg.xcbutilkeysyms
              xorg.xcbutilrenderutil
              xcb-util-cursor
            ];
            LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
              glibc_multi

              acl
              attr
              bzip2
              dbus
              expat
              fontconfig
              freetype
              fuse3
              icu
              libnotify
              libsodium
              libssh
              libunwind
              libusb1
              libuuid
              nspr
              nss
              stdenv.cc.cc
              util-linux
              zlib
              zstd

              pipewire
              cups
              libxkbcommon
              pango
              mesa
              libdrm
              libglvnd
              libpulseaudio
              atk
              cairo
              alsa-lib
              at-spi2-atk
              at-spi2-core
              gdk-pixbuf
              glib
              gtk3
              libGL
              libappindicator-gtk3
              vulkan-loader
              xorg.libX11
              xorg.libXScrnSaver
              xorg.libXcomposite
              xorg.libXcursor
              xorg.libXdamage
              xorg.libXext
              xorg.libXfixes
              xorg.libXi
              xorg.libXrandr
              xorg.libXrender
              xorg.libXtst
              xorg.libxcb
              xorg.libxkbfile
              xorg.libxshmfence

              xorg.xcbutilwm
              xorg.xcbutilimage
              xorg.xcbutilkeysyms
              xorg.xcbutilrenderutil
              xcb-util-cursor
            ];
          };
        });
}
