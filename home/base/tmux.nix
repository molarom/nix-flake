{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs; [
      tmuxPlugins.yank
    ];

    extraConfig = ''
      set-option -g default-shell ${pkgs.zsh}/bin/zsh
      # split panes using | and -, make sure they open in the same path
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      unbind '"'
      unbind %

      # open new windows in the current path
      bind c new-window -c "#{pane_current_path}"

      # reload config file
      bind r source-file /etc/tmux.conf

      unbind p
      bind p previous-window

      # shorten command delay
      set -sg escape-time 1

      # don't rename windows automatically
      set -g allow-rename off

      # mouse control (clickable windows, panes, resizable panes)
      set -g mouse on

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # enable vi mode keys
      set-window-option -g mode-keys vi

      # present a menu of URLs to open from the visible pane. sweet.
      bind u capture-pane \;\
        save-buffer /tmp/tmux-buffer \;\
        split-window -l 10 "urlview /tmp/tmux-buffer"


      ######################
      ### DESIGN CHANGES ###
      ######################

      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"

      # loud or quiet?
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # Tokyonight Theme
      set -g mode-style "fg=#82aaff,bg=#3b4261"

      set -g message-style "fg=#82aaff,bg=#3b4261"
      set -g message-command-style "fg=#82aaff,bg=#3b4261"

      set -g pane-border-style "fg=#3b4261"
      set -g pane-active-border-style "fg=#82aaff"

      set -g status "on"
      set -g status-justify "left"

      set -g status-style "fg=#82aaff,bg=#1e2030"

      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g status-left-style NONE
      set -g status-right-style NONE

      set -g status-left "#[fg=#1b1d2b,bg=#82aaff,bold] #S #[fg=#82aaff,bg=#1e2030,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#1e2030] #{prefix_highlight} #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#82aaff,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1b1d2b,bg=#82aaff,bold] #h "

      setw -g window-status-activity-style "underscore,fg=#828bb8,bg=#1e2030"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#828bb8,bg=#1e2030"
      setw -g window-status-format "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#1e2030,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#82aaff,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]"

      # tmux-plugins/tmux-prefix-highlight support
      set -g @prefix_highlight_output_prefix "#[fg=#ffc777]#[bg=#1e2030]#[fg=#1e2030]#[bg=#ffc777]"
      set -g @prefix_highlight_output_suffix ""
    '';
  };
}
