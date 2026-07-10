{
  description = "Nix development environment for Dependency-Replication";

  inputs = {
    # nixos-25.05 ships R 4.4.3, matching the version recorded in renv.lock.
    # The channel is end-of-life, as is 25.11; current stable is nixos-26.05,
    # which ships R 4.5.3. Staying on 25.05 is a deliberate tradeoff: flake.lock
    # pins an exact rev, so reproducibility does not depend on channel support,
    # whereas bumping the channel would change R's minor version, relocate
    # renv/library/R-4.4 to R-4.5, and recompile every package. The cost is that
    # `nix flake update` is inert and no upstream fixes reach this closure.
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
            # renv is deliberately absent: renv/activate.R pins renv 1.1.7 and
            # loads it only from the project library (renv/library/<platform>/),
            # so a nixpkgs renv in R's site library would never be used. The
            # first R startup bootstraps 1.1.7 from CRAN into that library.
            (rWrapper.override { packages = [ ]; })
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
