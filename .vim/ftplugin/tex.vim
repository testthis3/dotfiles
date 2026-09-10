vim9script 

compiler tex

def Compile()
    cd %:p:h
    w
    silent make
    cd -
    cwindow
    redraw! 
enddef

def Openpdf()
    const opta = "--synctex-forward "
    const optb = line(".") .. ":" .. col(".") .. ":" .. '%:p'
    exec "silent !zathura '%:p:r'.pdf " .. opta .. optb .. " & disown"
    redraw!
enddef
nnoremap <buffer> <localleader>c <ScriptCmd>Compile()<LF>
nnoremap <buffer> <localleader>r <ScriptCmd>Openpdf()<LF>

nnoremap <buffer> <localleader>s :so /home/marouane/.vim/ftplugin/tex.vim<LF>
