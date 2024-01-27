if exists("g:loaded_bspwm_navigator") || &cp || v:version < 700
  finish
endif
let g:loaded_bspwm_navigator = 1

function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

if !get(g:, 'bspwm_navigator_no_mappings', 0)
  noremap <silent> <c-h> :BspwmNavigateWest<cr>
  noremap <silent> <c-j> :BspwmNavigateSouth<cr>
  noremap <silent> <c-k> :BspwmNavigateNorth<cr>
  noremap <silent> <c-l> :BspwmNavigateEast<cr>
endif

command! BspwmNavigateWest call s:BspwmAwareNavigate('h')
command! BspwmNavigateSouth call s:BspwmAwareNavigate('j')
command! BspwmNavigateNorth call s:BspwmAwareNavigate('k')
command! BspwmNavigateEast call s:BspwmAwareNavigate('l')

function! s:HandleNavigationOnTmux(direction)
  if a:direction ==? 'h'
    let isEdgePane = system("tmux display -p '#{pane_at_left}'")
    if isEdgePane
      call s:HandleNavigationOnBspwm(a:direction)
    else 
      silent call system('tmux select-pane -L')
    endif 
  elseif a:direction ==? 'j'
    let isEdgePane = system("tmux display -p '#{pane_at_bottom}'")
    if isEdgePane
      call s:HandleNavigationOnBspwm(a:direction)
    else 
      silent call system('tmux select-pane -D')
    endif 
  elseif a:direction ==? 'k'
    let isEdgePane = system("tmux display -p '#{pane_at_top}'")
    if isEdgePane
      call s:HandleNavigationOnBspwm(a:direction)
    else 
      silent call system('tmux select-pane -U')
    endif 
  elseif a:direction ==? 'l'
    let isEdgePane = system("tmux display -p '#{pane_at_right}'")
    if isEdgePane
      call s:HandleNavigationOnBspwm(a:direction)
    else 
      silent call system('tmux select-pane -R')
    endif 
  endif
endfunction

function! s:HandleNavigationOnBspwm(direction)
  if a:direction ==? 'h'
    let bspc_direction = 'west'
  elseif a:direction ==? 'j'
    let bspc_direction = 'south'
  elseif a:direction ==? 'k'
    let bspc_direction = 'north'
  elseif a:direction ==? 'l'
    let bspc_direction = 'east'
  endif

  call system(['bspc', 'node', '-f', bspc_direction])
endfunction

function! s:BspwmAwareNavigate(direction)
  let nr = winnr()
  call s:VimNavigate(a:direction)

  let at_tab_page_edge = (nr == winnr())
  if at_tab_page_edge
    let window = system('xdotool getwindowfocus getwindowname')
    let inside_tmux = !empty(matchstr(window, 'tmux a\|tmux'))
    if inside_tmux
      call s:HandleNavigationOnTmux(a:direction)
    else
      call s:HandleNavigationOnBspwm(a:direction)
    endif
  endif
endfunction
