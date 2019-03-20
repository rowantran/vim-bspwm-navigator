# Vim Bspwm Navigator

This plugin provides a means of sharing keybinds between bspwm and vim, allowing Super + HJKL to navigate both between system windows and vim windows. The overall structure and the vim plugin are adapted from [Chris Toomey's Vim Tmux Navigator](https://github.com/christoomey/vim-tmux-navigator).

## Installation
### Vim
Use your preferred package manager to install the Vim plugin, e.g. using [vim-plug](https://github.com/junegunn/vim-plug):
```
Plug 'rowantran/vim-bspwm-navigator'
```
Then run `:PlugInstall`.

**NOTE:** Ensure that `ctrl-h`, `ctrl-j`, `ctrl-k`, and `ctrl-l` are *not* bound to any commands in vim.

### bspwm/sxhkd
Symlink `change-split-or-window` to somewhere in your `$PATH`, e.g.
```
ln -s ~/.config/nvim/plugged/vim-bspwm-navigator/change-split-or-window /usr/local/bin/change-split-or-window
```
**NOTE:** You must change the above command depending on where your plugin is stored. If you have a different folder in `$PATH` to store shell scripts, symlink it to there instead of `/usr/local/bin`.

Use sxhkd to call `change-split-or-window $DIRECTION`, where `$DIRECTION` is either `west`, `south`, `north`, or `east`. This will focus the split in the given direction if in vim, or if not in vim, call `bspc` to focus the window in the given direction.
```
mod4 + {h,j,k,l}
    change-split-or-window {west,south,north,east}
```
Ensure that you remove any conflicting keybinds.
