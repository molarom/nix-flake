{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH=$HOME/.krew/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colorize"
        "colored-man-pages"
        "cp"
        "docker"
        "git"
        "github"
        "history-substring-search"
        "jump"
        "kubectl"
        "rsync"
      ];
      theme = "sorin";
    };
  };
}
