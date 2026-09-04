#    _  ___        ______ __
#   / |/ (_)_ __  / ___(_) /_
#  /    / /\ \ / / (_ / / __/
# /_/|_/_//_\_\  \___/_/\__/
# ------------------------------------------
# Git nix home package and config by lPhiNix
#
{...}: {
  programs.git = {
    enable = true;
    settings = {
      # Committer identity for all git commits.
      user.name = "lPhiNix";
      user.email = "152783810+lPhiNix@users.noreply.github.com";
    };
  };
}
