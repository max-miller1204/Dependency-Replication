{
  description = "Nix development environment for Dependency-Replication";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        nativeLibs = with pkgs; [
          bzip2
          cairo
          curl
          fontconfig
          freetype
          fribidi
          gcc
          gfortran
          glib
          harfbuzz
          icu
          libjpeg
          libgit2
          libpng
          libtiff
          libxml2
          openssl
          pango
          pkg-config
          xz
          zlib
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            (rWrapper.override {
              packages = with rPackages; [
                renv
              ];
            })
            pandoc
            texlive.combined.scheme-medium
          ] ++ nativeLibs;

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath nativeLibs;

          shellHook = ''
            echo "Entered the Dependency-Replication Nix shell."
            echo "Run: R -q -e 'renv::restore()'"
          '';
        };
      });
}
