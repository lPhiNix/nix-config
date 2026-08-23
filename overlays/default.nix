{inputs, ...}: {
  additions = final: _prev: import ../pkgs final;

  modifications = final: prev: {};

  unstable-packages = final: _prev: {
    unstablePkgs = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
