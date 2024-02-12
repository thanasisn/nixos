with import <nixpkgs> {}; { execEnv = stdenv.mkDerivation { name = "IPythonIPyKernelForSpyder3"; buildInputs = [stdenv python3Full python3Packages.ipython python3Packages.ipykernel]; }; } 
