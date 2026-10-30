vim9script 

compiler gcc 

def Compile()
    cd %:p:h
    w
    silent make
    cd -
    cwindow
    redraw! 
enddef

def Run()
    cd %:p:h
    execute '!./' .. shellescape(expand('%:t:r'))
    cd -
    redraw!
enddef

nnoremap <buffer> <localleader>c <ScriptCmd>Compile()<LF>
nnoremap <buffer> <localleader>r <ScriptCmd>Run()<LF>

nnoremap <buffer> <localleader>s :so /home/marouane/.vim/ftplugin/c.vim<LF>
