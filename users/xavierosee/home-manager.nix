{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:

let
  sources = imports ../../nix/sources.nix;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

in {
  xdg.enable = true;

  home.packages = [
    pkgs.bat
    pkgs.delta
    pkgs.gh
    pkgs.htop
    pkgs.jq
    pkgs.neovim
    pkgs.prettyping
    pkgs.speedtest-cli
    pkgs.tmux
    pkgs.tree
  ] ++ (lib.optionals isDarwin [
    pkgs.cachix
  ]) ++ (lib.optionals (isLinux && !isWSL) [
    pkgs.chromium
  ]);

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "delta";
  };

  programs.gpg.enable = !isDarwin;

  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups", "ignorespace" ];
    initExtra = builtins.readFile ./bashrc;

    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      mkdir = "mkdir -pv";
      ll = "ls -lAFh";
      la = "ls -Al";
      less = "less -FSRXc";
      wget = "wget -c";
      c = "clear";
      show_options = "shopt";
      src = "source ~/.bashrc";
      dkpg = "sudo dkpg";

      gap = "git add --patch";
      glg = "git lg -20";

      ping = "prettyping --nolegend"
      top = "htop"
      vim = "nvim"
    };

    programs.direnv = {
      enable = true;

      config = {
        whitelist = {
          exact = ["$HOME/.envrc"];
        };
      };
    };

    programs.git = {
      enable = true;
      userName = "Xavier Rosee";
      userEmail = "xrosee@live.cn";
      aliases = {
        co = "checkout";
        st = "status -sb";
        br = "branch";
        ci = "commit";
        fo = "fetch origin";
        d = "!git --no-pager-diff";
        dt = "difftool";
        stat = "!git --no-pager-diff stat";
        pf = "push --force-with-lease";
        lg = "log --graph --pretty=format:'%Cred%h%Creset - %s = %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
      };
      extraConfig = {
        color.branch = auto;
        color.diff = auto;
        color.interactive = auto;
        color.status = auto;
        core.pager = delta;
        core.editor = nvim;
        core.visual = nvim;
        delta.navigate = true;
        delta.line-numbers = true;
        delta.side-by-side = true;
        delta.syntax-theme = GitHub;
        fetch.prune = true;
        help.autocorrect = 1;
        init.defaultBranch = "main";
        interactive.diffFilter = "delta --color-only";
        pull.rebase = "i";
        push.default = "tracking";
        github.user = "xavierosee";
      };
    };

    programs.tmux = {
      enable = true;
      terminal = "screen-256color";
      secureSocket = false;
      extraConfig = ''
        unbind C-b
        set -g prefix C-s
        bind C-s send-prefix

        bind -n C-h select-pane -L
        bind -n C-j select-pane -D
        bind -n C-k select-pane -U
        bind -n C-l select-pane -R

        bind - split-window -v -c "#{pane_current_path}"
        bind | split-window -h -c "#{pane_current_path}"

        bind -n S-Left resize-pane -L 2
        bind -n S-Right resize-pane -R 2
        bind -n S-Up resize-pane -U 2
        bind -n S-Down resize-pane -D 2
        bind -n C-Left resize-pane -L 10
        bind -n C-Left resize-pane -L 10
        bind -n C-Left resize-pane -L 5
        bind -n C-Left resize-pane -L 5

        bind c new-window -c "#{pane_current_path}"

        set -g base-index 1
        set -g renumber-windows on

        bind b break-pane -d

        bind a copy-mod
        bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip"

        # TODO: add pane switching with awareness of vim splits

        bind h split-window -h htop
        bind j command-prompt -p "join page from " join-pane -h -s '%%'"

        bind C-d send-keys 'ta && exit' 'C-m'
        bind k run-shell 'tmux-switch-client -n \; kill-session -t "$(tmux display-message -p "#S")" || tmux kill-session'
      '';
    };

    programs.neovim = {
      enable = true;
      package = pkgs.neovim;

      withPython3 = true;

      plugins = with pkgs; [
        customVim.vim-fish
        customVim.vim-devicons

        vimPlugins.vim-markdown
        vimPlugins.vim-nix
      ];

      extraConfig = (import ./vim-config.nix) { inherit sources; };
    };
  };
}
