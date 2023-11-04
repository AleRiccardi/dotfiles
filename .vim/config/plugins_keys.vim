""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CoC Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent><leader>ce :CocEnable<cr>
nnoremap <silent><leader>ct :CocToggle<cr>
nnoremap <silent><leader>cd :CocDisable<cr>
nnoremap <silent><leader>cr :CocRestart<cr>
nnoremap <silent><leader>co :CocConfig<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Format Keybindings (using Neoformat)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent><leader>ff :Neoformat<cr> :Isort<cr>
nmap <silent><leader>af :Autoflake<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc-fzf Keybindigs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a
nnoremap <silent><leader>cl      :<C-u>CocFzfList<CR>
nnoremap <silent><leader>d       :<C-u>CocFzfList diagnostics --current-buf<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc-explorer bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: Fix this shit!
" let $foo=expand('%:p:h')
nmap <silent><leader>m       :CocCommand explorer<cr>
nmap <silent><leader>n       :CocCommand explorer --preset floating<cr>
nmap <silent><leader>b       :CocCommand explorer --preset buffer<cr>
nmap <silent><leader><space> :CocCommand explorer --preset floating<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SilverSearcher bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <silent><leader>ag :Ag<cr>
nmap <silent><leader>ag :Ag <c-r><c-w><cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent>gc <Plug>NERDCommenterToggle<cr>
xmap <silent>gc <Plug>NERDCommenterToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent><Leader>t :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => BufferLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump buffer buffer with just ALT+h or ALT+l
nnoremap <silent><M-h> :BufferLineCyclePrev<CR>
nnoremap <silent><M-l> :BufferLineCycleNext<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-p> :Files<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Doxygen Support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent><leader>do :Dox<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Codeium custom bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <script><silent><nowait><expr> <C-f> codeium#Accept()
imap <C-d>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-c>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>
