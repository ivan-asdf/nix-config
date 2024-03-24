{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    extraConfig = ''
      set-option -sg escape-time 10
      set-option -g focus-events on

      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      #set -g @resurrect-processes 'nvim man'
      #set -g @resurrect-strategy-nvim 'session'
      #set -g @resurrect-capture-pane-contents 'on'
      #set -g @continuum-restore 'on'
      #set-option -g allow-rename off
      #set-option -g allow-rename on

      #bind-key -n C-s run-shell "tmuxp freeze -p ~/.tmuxp/default.yaml && echo 'Session frozen.'"
    '';

    # plugins = with pkgs.tmuxPlugins; [ resurrect continuum ];
  };
  home.packages = with pkgs; [
    #tmuxp
    #smug
    tmuxinator
  ];
  # PROBLEMS
  # It doesnt render nvim properly sometimes (tmux does)
  # It doesnt render image preview (tmux does somewhat)
}
