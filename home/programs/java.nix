{pkgs, ...}: {
  home.packages = [
    pkgs.jdk17
    (pkgs.writeShellScriptBin "java8" "exec ${pkgs.jdk8}/bin/java \"$@\"")
    (pkgs.writeShellScriptBin "java17" "exec ${pkgs.jdk17}/bin/java \"$@\"")
    (pkgs.writeShellScriptBin "java21" "exec ${pkgs.jdk21}/bin/java \"$@\"")
  ];
}
