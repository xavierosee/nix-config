{ inputs }:

self: super:

let sources = import ../../nix/sources.nix; in rec {
    customVim = with self; {
        vim-fish = vimUtils.buildVimPlugin {
            name = "vim-fish";
            src = sources.vim-fish;
        };

        vim-misc = vimUtils.buildVimPlugin {
            name = "vim-misc";
            src = sources.vim-misc;
        };

        vim-devicons = vimUtils.buildVimPlugin {
            name = "vim-devicons";
            src = sources.vim-devicons;
        };

        nvim-comment = vimUtils.buildVimPlugin {
            name = "nvim-comment";
            src = sources.nvim-comment;
            buildPhase = ":";
        };
    };
}
