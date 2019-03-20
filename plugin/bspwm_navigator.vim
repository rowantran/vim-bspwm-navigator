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

function! s:BspwmAwareNavigate(direction)
    let nr = winnr()
    call s:VimNavigate(a:direction)
    
    let at_tab_page_edge = (nr == winnr())
    if at_tab_page_edge
        if a:direction ==? 'h'
            system("bspc node -f west")
        elseif a:direction ==? 'j'
            system("bspc node -f south")
        elseif a:direction ==? 'k'
            system("bspc node -f north")
        elseif a:direction ==? 'l'
            system("bspc node -f east")
        endif
    endif
endfunction
