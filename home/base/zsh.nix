{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      findNoDups = true;
    };
    initContent = ''
      autoload -Uz add-zsh-hook
      export PATH=$PATH:/opt/homebrew/bin:$HOME/go/bin:$HOME/.local/bin
      export DISABLE_TELEMETRY=1
      export DISABLE_FEEDBACK_COMMAND=1
      export CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY=1
    '';
    plugins = [
      {
        name = "zsh-histdb";
        src = pkgs.zsh-histdb;
        file = "share/zsh-histdb/sqlite-history.zsh";
      }
    ];
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
