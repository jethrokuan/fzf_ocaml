with import <nixpkgs> {} ;

let
  ocamlPackages = pkgs.recurseIntoAttrs pkgs.ocamlPackages_latest;
in
stdenv.mkDerivation rec {
  version = "0.0.1";
  src = ./.;
  name = "fzf-${version}";
  buildInputs = [dune] ++ (with ocamlPackages; [ocaml findlib async core ppx_tools_versioned]);

  buildPhase = "dune build fzf.exe";


  installPhase = ''
    mkdir -p $out/bin;
    cp ${src}/_build/default/fzf.exe $out/bin/fzf;
  '';
}
