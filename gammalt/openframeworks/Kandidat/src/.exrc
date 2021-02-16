let s:cpo_save=&cpo
set cpo&vim
cnoremap <silent> <Plug>+ <Nop>
cnoremap <silent> <Plug>_ <Nop>
inoremap <silent> <expr> <Plug>+ deoplete#mapping#_dummy('deoplete#mapping#_prev_complete')
inoremap <silent> <expr> <Plug>_ deoplete#mapping#_dummy('deoplete#mapping#_complete')
inoremap <silent> <C-Tab> =UltiSnips#ListSnippets()
inoremap <Plug>(emmet-merge-lines) =emmet#util#closePopup()=emmet#mergeLines()
inoremap <Plug>(emmet-anchorize-summary) =emmet#util#closePopup()=emmet#anchorizeURL(1)
inoremap <Plug>(emmet-anchorize-url) =emmet#util#closePopup()=emmet#anchorizeURL(0)
inoremap <Plug>(emmet-remove-tag) =emmet#util#closePopup()=emmet#removeTag()
inoremap <Plug>(emmet-split-join-tag) :call emmet#splitJoinTag()
inoremap <Plug>(emmet-toggle-comment) =emmet#util#closePopup()=emmet#toggleComment()
inoremap <Plug>(emmet-image-encode) =emmet#util#closePopup()=emmet#imageEncode()
inoremap <Plug>(emmet-image-size) =emmet#util#closePopup()=emmet#imageSize()
inoremap <Plug>(emmet-move-prev-item) :call emmet#moveNextPrevItem(1)
inoremap <Plug>(emmet-move-next-item) :call emmet#moveNextPrevItem(0)
inoremap <Plug>(emmet-move-prev) =emmet#util#closePopup()=emmet#moveNextPrev(1)
inoremap <Plug>(emmet-move-next) =emmet#util#closePopup()=emmet#moveNextPrev(0)
inoremap <Plug>(emmet-balance-tag-outword) :call emmet#balanceTag(-1)
inoremap <Plug>(emmet-balance-tag-inward) :call emmet#balanceTag(1)
inoremap <Plug>(emmet-update-tag) =emmet#util#closePopup()=emmet#updateTag()
inoremap <Plug>(emmet-expand-word) =emmet#util#closePopup()=emmet#expandAbbr(1,"")
inoremap <Plug>(emmet-expand-abbr) =emmet#util#closePopup()=emmet#expandAbbr(0,"")
inoremap <silent> <expr> <Plug>delimitMateS-BS delimitMate#WithinEmptyPair() ? "\<Del>" : "\<S-BS>"
inoremap <silent> <Plug>delimitMateBS =delimitMate#BS()
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>
imap <M-Left> :tabp
imap <M-Right> :tabn
snoremap <silent>  "_c
nmap  h
xmap  h
snoremap <silent> <NL> :call UltiSnips#ExpandSnippet()
nmap <NL> gj
xnoremap <silent> <NL> :call UltiSnips#SaveLastVisualSelection()gvs
nmap  gk
vmap  gk
nmap  l
vmap  l
nmap  <Plug>(RepeatRedo)
snoremap  "_c
vmap c <Plug>(emmet-code-pretty)
nmap m <Plug>(emmet-merge-lines)
nmap A <Plug>(emmet-anchorize-summary)
nmap a <Plug>(emmet-anchorize-url)
nmap k <Plug>(emmet-remove-tag)
nmap j <Plug>(emmet-split-join-tag)
nmap / <Plug>(emmet-toggle-comment)
nmap I <Plug>(emmet-image-encode)
nmap i <Plug>(emmet-image-size)
nmap N <Plug>(emmet-move-prev)
nmap n <Plug>(emmet-move-next)
vmap D <Plug>(emmet-balance-tag-outword)
nmap D <Plug>(emmet-balance-tag-outword)
vmap d <Plug>(emmet-balance-tag-inward)
nmap d <Plug>(emmet-balance-tag-inward)
nmap u <Plug>(emmet-update-tag)
nmap ; <Plug>(emmet-expand-word)
vmap , <Plug>(emmet-expand-abbr)
nmap , <Plug>(emmet-expand-abbr)
map   za
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nmap ,T :NERDTreeFind
nmap . <Plug>(RepeatDot)
nnoremap :!compiledb -n make
nnoremap K :YcmCompleter GetDoc
xmap S <Plug>VSurround
nmap U <Plug>(RepeatUndoLine)
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nmap [C 9999[c
nmap [c <Plug>(signify-prev-hunk)
nmap \tc <Plug>Colorizer
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
nmap ]C 9999]c
nmap ]c <Plug>(signify-next-hunk)
xmap a% <Plug>(MatchitVisualTextObject)
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nmap cr <Plug>(abolish-coerce-word)
nmap ds <Plug>Dsurround
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
xmap gS <Plug>VgSurround
nnoremap si :YcmCompleter GoToDefinition
map tt :tabnew 
nmap td :bd
nmap u <Plug>(RepeatUndo)
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
nmap zuz <Plug>(FastFoldUpdate)
nnoremap <silent> <Plug>(RepeatRedo) :call repeat#wrap("\<C-R>",v:count)
nnoremap <silent> <Plug>(RepeatUndoLine) :call repeat#wrap('U',v:count)
nnoremap <silent> <Plug>(RepeatUndo) :call repeat#wrap('u',v:count)
nnoremap <silent> <Plug>(RepeatDot) :exe repeat#run(v:count)
nnoremap <SNR>176_: :=v:count ? v:count : ''
noremap <silent> <Plug>+ <Nop>
noremap <silent> <Plug>_ <Nop>
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
vmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
vnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
vnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
vnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
vnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v')m'gv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nnoremap <silent> <Plug>SurroundRepeat .
snoremap <silent> <Del> "_c
snoremap <silent> <BS> "_c
snoremap <silent> <C-Tab> :call UltiSnips#ListSnippets()
nnoremap <silent> <Plug>(FastFoldUpdate) :FastFoldUpdate!
xnoremap <silent> <Plug>(signify-motion-outer-visual) :call sy#util#hunk_text_object(1)
onoremap <silent> <Plug>(signify-motion-outer-pending) :call sy#util#hunk_text_object(1)
xnoremap <silent> <Plug>(signify-motion-inner-visual) :call sy#util#hunk_text_object(0)
onoremap <silent> <Plug>(signify-motion-inner-pending) :call sy#util#hunk_text_object(0)
nnoremap <silent> <expr> <Plug>(signify-prev-hunk) &diff ? '[c' : ":\call sy#jump#prev_hunk(v:count1)\"
nnoremap <silent> <expr> <Plug>(signify-next-hunk) &diff ? ']c' : ":\call sy#jump#next_hunk(v:count1)\"
vnoremap <Plug>(emmet-code-pretty) :call emmet#codePretty()
nnoremap <Plug>(emmet-merge-lines) :call emmet#mergeLines()
nnoremap <Plug>(emmet-anchorize-summary) :call emmet#anchorizeURL(1)
nnoremap <Plug>(emmet-anchorize-url) :call emmet#anchorizeURL(0)
nnoremap <Plug>(emmet-remove-tag) :call emmet#removeTag()
nnoremap <Plug>(emmet-split-join-tag) :call emmet#splitJoinTag()
nnoremap <Plug>(emmet-toggle-comment) :call emmet#toggleComment()
nnoremap <Plug>(emmet-image-encode) :call emmet#imageEncode()
nnoremap <Plug>(emmet-image-size) :call emmet#imageSize()
nnoremap <Plug>(emmet-move-prev-item) :call emmet#moveNextPrevItem(1)
nnoremap <Plug>(emmet-move-next-item) :call emmet#moveNextPrevItem(0)
nnoremap <Plug>(emmet-move-prev) :call emmet#moveNextPrev(1)
nnoremap <Plug>(emmet-move-next) :call emmet#moveNextPrev(0)
vnoremap <Plug>(emmet-balance-tag-outword) :call emmet#balanceTag(-1)
nnoremap <Plug>(emmet-balance-tag-outword) :call emmet#balanceTag(-1)
vnoremap <Plug>(emmet-balance-tag-inward) :call emmet#balanceTag(1)
nnoremap <Plug>(emmet-balance-tag-inward) :call emmet#balanceTag(1)
nnoremap <Plug>(emmet-update-tag) :call emmet#updateTag()
nnoremap <Plug>(emmet-expand-word) :call emmet#expandAbbr(1,"")
vnoremap <Plug>(emmet-expand-abbr) :call emmet#expandAbbr(2,"")
nnoremap <Plug>(emmet-expand-abbr) :call emmet#expandAbbr(3,"")
nnoremap <silent> <Plug>Colorizer :ColorToggle
map <F1> :w:! quickgit 
map <F9> :set spell!
map <F10> :set hls!
nmap <Down> gj
nmap <Up> gk
vmap <Down> gj
vmap <Up> gk
nmap <F5> <Plug>(scnvim-send-block)
map <F3> :NERDTreeToggle
map <M-Left> :tabp
map <M-Right> :tabn
cnoremap  <Home>
cnoremap  <Left>
cnoremap  <End>
cnoremap  <Right>
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> <NL> =UltiSnips#ExpandSnippet()
cnoremap  <Down>
cnoremap  <Up>
imap  <Plug>Isurround
imap m <Plug>(emmet-merge-lines)
imap A <Plug>(emmet-anchorize-summary)
imap a <Plug>(emmet-anchorize-url)
imap k <Plug>(emmet-remove-tag)
imap j <Plug>(emmet-split-join-tag)
imap / <Plug>(emmet-toggle-comment)
imap I <Plug>(emmet-image-encode)
imap i <Plug>(emmet-image-size)
imap N <Plug>(emmet-move-prev)
imap n <Plug>(emmet-move-next)
imap D <Plug>(emmet-balance-tag-outword)
imap d <Plug>(emmet-balance-tag-inward)
imap u <Plug>(emmet-update-tag)
imap ; <Plug>(emmet-expand-word)
imap , <Plug>(emmet-expand-abbr)
let &cpo=s:cpo_save
unlet s:cpo_save
set fileencodings=utf-8
set fillchars=vert:\ 
set helplang=en
set makeprg=cd\ ../\ ;\ make\ ;\ make\ RunRelease\ ;\ cd\ src
set operatorfunc=<SNR>103_opfunc
set runtimepath=~/.config/nvim,~/.config/nvim/plugged/vim-pandoc/,~/.config/nvim/plugged/vim-pandoc-syntax/,~/.config/nvim/plugged/haskell-ide-engine/,~/.config/nvim/plugged/SimpylFold/,~/.config/nvim/plugged/vim-autoclose/,~/.config/nvim/plugged/nerdtree-visual-selection/,~/.config/nvim/plugged/delimitMate/,~/.config/nvim/plugged/colorizer/,~/.config/nvim/plugged/vim-isort/,~/.config/nvim/plugged/MatchTagAlways/,~/.config/nvim/plugged/emmet-vim/,~/.config/nvim/plugged/neomake/,~/.config/nvim/plugged/vim-signify/,~/.config/nvim/plugged/vim-cpp-modern/,~/.config/nvim/plugged/vim-maktaba/,~/.config/nvim/plugged/vim-codefmt/,~/.config/nvim/plugged/vim-glaive/,~/.config/nvim/plugged/scnvim/,~/.config/nvim/plugged/vimtex/,~/.config/nvim/plugged/FastFold/,~/.config/nvim/plugged/vim-tex-fold/,~/.config/nvim/plugged/ultisnips/,~/.config/nvim/plugged/vim-snippets/,~/.config/nvim/plugged/vim-processing/,~/.config/nvim/plugged/deoplete.nvim/,~/.config/nvim/plugged/deoplete-jedi/,~/.config/nvim/plugged/nerdtree/,~/.config/nvim/plugged/
set shiftwidth=2
set softtabstop=4
set tabstop=4
set window=66
" vim: set ft=vim :
