#!/usr/bin/env bash

version_pat='s/^tmux[^0-9]*([.0-9]+).*/\1/p'

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
tmux bind-key -n C-h if "$is_vim" \
	"send-keys C-h" "run '$CURRENT_DIR/scripts/handle-tmux-navigation h'"
tmux bind-key -n C-j if "$is_vim" \
	"send-keys C-j" "run '$CURRENT_DIR/scripts/handle-tmux-navigation j'"
tmux bind-key -n C-k if "$is_vim" \
	"send-keys C-k" "run '$CURRENT_DIR/scripts/handle-tmux-navigation k'"
tmux bind-key -n C-l if "$is_vim" \
	"send-keys C-l" "run '$CURRENT_DIR/scripts/handle-tmux-navigation l'"

tmux_version="$(tmux -V | sed -En "$version_pat")"
tmux setenv -g tmux_version "$tmux_version"

#echo "{'version' : '${tmux_version}', 'sed_pat' : '${version_pat}' }" > ~/.tmux_version.json

tmux if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
	"bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
tmux if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
	"bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

tmux bind-key -T copy-mode-vi C-h select-pane -L
tmux bind-key -T copy-mode-vi C-j select-pane -D
tmux bind-key -T copy-mode-vi C-k select-pane -U
tmux bind-key -T copy-mode-vi C-l select-pane -R
tmux bind-key -T copy-mode-vi C-\\ select-pane -l
