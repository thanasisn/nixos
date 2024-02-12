let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: [
       python-pkgs.pandas
       python-pkgs.requests
       python-pkgs.ipython
       python-pkgs.ipykernel
    ]))
  ];
  nativeBuildInputs = with pkgs.buildPackages; [ spyder python3 ];
}
