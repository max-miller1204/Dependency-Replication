{
  description = "Nix development environment for Dependency-Replication";

  inputs = {
    # nixos-25.05 ships R 4.4.3, matching the version recorded in renv.lock.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
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
          # textshaping's configure runs `pkg-config --static --libs harfbuzz`,
          # which walks Requires.private: harfbuzz -> {freetype2, glib-2.0,
          # graphite2}, and glib-2.0 -> {sysprof-capture-4, libpcre2-8}. Any
          # missing link makes pkg-config error out, and textshaping then links
          # with an empty PKG_LIBS and fails to dlopen on _fribidi_log2vis.
          graphite2
          libsysprof-capture
          pcre2
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
            # scheme-medium lacks four styles the rendered .tex pulls in:
            # framed + upquote + xurl come from pandoc's LaTeX template,
            # fvextra from the Rmd's own header-includes.
            (texliveMedium.withPackages (ps: with ps; [
              framed
              fvextra
              upquote
              xurl
            ]))
          ] ++ nativeLibs;

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath nativeLibs;

          shellHook = ''
            echo "Entered the Dependency-Replication Nix shell."
            echo "Run: R -q -e 'renv::restore()'"
          '';
        };
      });
}
