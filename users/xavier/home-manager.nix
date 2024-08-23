{ pkgs, config, ... }:

{
  home = {
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
      BAT_THEME = "GitHub";
    };
  };

  programs = {

    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        PS1='\n\[\e[1;36m\]\w\[\e[0m\]\n\u@\h -> ';
      '';
    };

    git = {
      enable = true;
      userName = "Xavier Rosée";
      userEmail = "xavier.rosee@gmail.com";
      lfs.enable = true;
      ignores = [
        # General
        "log/"
        "*.log"

        # Ansible
        "ansible_shared_secret*"

        # macOS
        "**/.DS_Store"

        # Node
        "npm-debug.log"

        # Python
        "**/.python-version"

        # Vim
        "*~"
        "*.swp"

        # VSCode
        "**/.vscode/"

        # Windows
        "**/.Thumbs.db"
      ];
      aliases = {
        co = "checkout";
        lg = "log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        m = "!git checkout main && git pull";
        ms = "!git checkout master && git pull";
        pf = "push --force-with-lease";
      };
      extraConfig = {
        color = {
          branch = "auto";
          diff = "auto";
          interactive = "auto";
        };
        core = {
          pager = "delta";
          editor = "nvim";
          visual = "nvim";
        };
        delta = {
          navigate = true;
          line-numbers = true;
          side-by-side = true;
          syntax-theme = "Github";
        };
        fetch.prune = true;
        help.autocorrect = true;
        init.defaultBranch = "main";
        interactive.diffFilter = "delta --color-only";
        pull.rebase = true;
        push = {
          autoSetupRemote = true;
          default = "current";
        };
      };
    };

    htop.enable = true;

    home-manager.enable = true;

    jq.enable = true;

    neovim = {
      enable = true;
      extraConfig = ''
        colorscheme catppuccin-latte
        syntax on
        set number
        set nocompatible
        set smartindent
        filetype plugin on
        set expandtab
        set tabstop = 4
        set shiftwidth = 4

        set noswapfile
        set nobackup
        set nowritebackup
        set viminfo=

        nnoremap <SPACE> <nop>
        let mapleader = " "
        nnoremap <tab> za

        autocmd VimResized * :wincmd =
      '';
      plugins = with pkgs.vimPlugins; [
          vim-nix
      ];
      vimAlias = true;
    };

    ssh.enable = true;
  };
}
