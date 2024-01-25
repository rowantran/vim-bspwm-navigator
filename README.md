# Vim / Bspwm / Tmux Navigator

This plugin provides a means of sharing keybinds between bspwm, vim and tmux, allowing Super + HJKL to navigate both between system windows and vim windows. The overall structure and the vim plugin are adapted from [Chris Toomey's Vim Tmux Navigator](https://github.com/christoomey/vim-tmux-navigator) and [Rowan Tran Vim Bspwm Navigator](https://github.com/rowantran/vim-bspwm-navigator).

## Installation

### Dependencies

vim and bspwm are obviously required. The plugin also works in neovim.

You will need `xdotool` installed. Check your distribution's repos for this; most distros should have it readily available.

### Vim

Use your preferred package manager to install the Vim plugin.

using [vim-plug](https://github.com/junegunn/vim-plug):

```bash
Plug "joaopedroaat/vim-bspwm-tmux-navigator"
```

using [lazy](https://github.com/folke/lazy.nvim)

```lua
return { "joaopedroaat/vim-bspwm-tmux-navigator" }
```

**NOTE:** Ensure that `ctrl-h`, `ctrl-j`, `ctrl-k`, and `ctrl-l` are _not_ bound to any commands in vim.

### bspwm/sxhkd

Symlink `handle-window-navigation` to somewhere in your `$PATH`, e.g.

using [vim-plug](https://github.com/junegunn/vim-plug):

```bash
ln -s ~/.config/nvim/plugged/vim-bspwm-navigator/handle-window-navigation /usr/local/bin/handle-window-navigation
chmod +x /usr/local/bin/handle-window-navigation
```

using [lazy](https://github.com/folke/lazy.nvim)

```bash
ln -s ~/.local/share/nvim/lazy/vim-bspwm-tmux-navigator/handle-window-navigation /usr/local/bin/handle-window-navigation
chmod +x /usr/local/bin/handle-window-navigation
```

**NOTE:** You must change the above command depending on where your plugin is stored. If you have a different folder in `$PATH` to store shell scripts, symlink it to there instead of `/usr/local/bin`.

Use sxhkd to invoke `handle-window-navigation $DIRECTION`, where `$DIRECTION` can be: `west`, `south`, `north` or `east`.
`~/.config/sxhkd/sxhkdrc`:

```bash
super + {h,j,k,l}
    handle-window-navigation {west,south,north,east}
```

Ensure that you remove any conflicting keybinds.
