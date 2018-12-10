with import <nixpkgs> {};

let
  ocamlPackages = pkgs.recurseIntoAttrs pkgs.ocamlPackages_latest;
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    dune
    fswatch                     #  for dune -w switch
  ] ++ ( with ocamlPackages;
  [
    async
    ocaml
    ppx_tools_versioned
    core
    core_extended
    findlib
    utop
    merlin
    ocp-indent
  ]);
  IN_NIX_SHELL = 1;
  DUNE_SITE_LISP = "${dune}/share/emacs/site-lisp";
  UTOP_SITE_LISP = "${ocamlPackages.utop}/share/emacs/site-lisp";
  MERLIN_SITE_LISP = "${ocamlPackages.merlin}/share/emacs/site-lisp";
  OCP_INDENT_SITE_LISP="${ocamlPackages.ocp-indent}/share/emacs/site-lisp";
}
