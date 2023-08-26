"jPlugin ,managed via vim-plug
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-unimpaired'
    Plug 'preservim/nerdcommenter'
    if !exists('g:vscode')
        Plug '~/.config/nvim/my-vim-bundle'
        Plug 'preservim/nerdtree'
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'dense-analysis/ale'
        Plug 'arcticicestudio/nord-vim'
        Plug 'github/copilot.vim'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
        Plug 'rust-lang/rust.vim', { 'for': 'rust' }
        Plug 'alvan/vim-closetag', { 'for': 'html' }
        Plug 'aldur/vim-algorand-teal', { 'for': 'teal' }
        Plug 'eslint/eslint', { 'for': 'javascript' }
    endif
call plug#end()

" General
    set modelines=0                 "will not use modelines
    set mouse=""                    "no mouse mode
    set undofile                    " persistent undo is nice

" Formatting
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set textwidth=0                 " Hard-wrap long lines as you type them

    " Remove trailing whitespaces and ^M chars
    autocmd FileType javascript,python,clojure,clojurescript,haskell autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    " Comment out following for no auto comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Vim UI
    set cursorline                  " highlight current line
    set relativenumber              " show relative line numbers
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=3                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set gdefault                    " apply global substitution to all occurrences in lines
    set nostartofline               " Do not jump to first character with page commands.
    set splitright                  " new windows opens to the right
    set splitbelow                  " new windows opens to the right

" Graphics

    set termguicolors

    if $ITERM_PROFILE == "dark"
        set background=dark
        silent! colorscheme nord
        let g:airline_theme='base16'
    else
        set background=light
        silent! colorscheme selenized
        let g:airline_theme='base16'
    endif

    " change color after column 90
    "let &colorcolumn=join(range(90,300),",")

" Key (re)Mappings

    " easy moving to first non space and end of line
    nnoremap H ^
    nnoremap L $

    " Some extra time savers
    nnoremap ; :
    nnoremap : ;

    " move around with ctrl + movement key
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " also in terminal
    "tnoremap <C-h> <C-\><C-n><C-w>h
    "tnoremap <C-j> <C-\><C-n><C-w>j
    "tnoremap <C-k> <C-\><C-n><C-w>k
    "tnoremap <C-l> <C-\><C-n><C-w>l

    " ESC, ctrl-[ to enter normal mode in terminal
    tnoremap <ESC> <C-\><C-n>

    " ctrl-w q to quit terminal
    tnoremap <C-w>q <C-\><C-n>:bd!<CR>

    " resize with movement key
    nnoremap <left> <C-w>2>
    nnoremap <down> <C-w>2+
    nnoremap <up> <C-w>2-
    nnoremap <right> <C-w>2<

    " Ctrl-W to delete the previous word, Ctrl-U to delete to start of line
    " all while remaining in insert mode
    inoremap <silent> <C-W> <C-\><C-O>db
    inoremap <silent> <C-U> <C-\><C-O>d0

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Easier horizontal scrolling
    noremap zl zL
    noremap zh zH

    " use Q to replay macro 'q' (qq / q to start/stop recording)
    nnoremap Q @q

    " allow the . to execute once for each line of a visual selection
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee > /dev/null %

    "AA in insert mode brings to end of line in insert mode
    inoremap AA <ESC>A

    " Ctrl+s to save and if needed de-highlight search and select autocomplete
    noremap <C-s> :noh<CR>:w<CR>
    inoremap <C-s> <ESC>:noh<CR>:w<CR>

    " Alt-A and Alt-x to increment and decrement numbers
    :nnoremap <A-a> <C-a>
    :nnoremap <A-x> <C-x>


"Leader mappings"
    let mapleader = "\<SPACE>"

    " space to de-highlight search
    nnoremap <leader><Space> :noh<CR>

    " Toggle line numbers and fold column for easy copying
    nnoremap <leader>3 :setlocal norelativenumber!<CR>:set foldcolumn=0<CR>

    " to open new vertical split with new file
    nnoremap <leader>n :vne<CR>

    " Fast editing of the init.vim
    noremap <leader>e :e! ~/.config/nvim/init.vim<CR>

    " open vertical split
    nnoremap <leader>v <C-w>v<C-w>l

    " open horizontal split
    nnoremap <leader>s <C-w>s<C-w>l

    " q to quit, w to close buffer
    nnoremap <leader>q :q<CR>
    nnoremap <leader>w :bw<CR>

    " t to run tests (for now just for Clojure with fireplace plugin
    nnoremap <leader>t :w<CR>:Require!<CR>:RunTests<CR>

    " ff to display all lines with keyword under cursor and ask where jump to
    nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " enter to add a blank lime above and type into it with a blank line below
    nnoremap <leader><CR> <up>o<ESC><up>o
    "inoremap <leader><CR> <ESC><up>o<ESC><up>o

    " close '{' one line below and add newline
    inoremap {{ {<CR>}<ESC>O

    " open Neovim terminal in right split (use autocommands below to run current file based on filetype)
    nnoremap <leader>r :vnew term://bash<CR>a

    " toggle mouse mode
    nnoremap <leader>m :call ToggleMouse()<CR>
    vnoremap <leader>m :call ToggleMouse()<CR>

" Automatic commands

        " <leader>r runs interactively pyrhon files
        autocmd FileType python nnoremap<leader>r :vnew term://python3 -i %<CR>a

        " always switch to the current file directory.
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

        " HTML tabs to two spaces, no wrap, no expand tab to spaces, no show whitespaces
        autocmd FileType html setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2 nowrap nolist

        " When init.vim is edited, reload it
        autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim

        " Jump to last cursor position when opening file
        :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Set comment options for teal files
         autocmd BufNewFile,BufRead *.teal setlocal comments+=://

" Plugins

    " ctrlp
    if has('CtrlP')
        let g:ctrlp_working_path_mode = 0
        nnoremap <leader>p :CtrlPMRU<CR>
        nnoremap <leader>b :CtrlPBuffer<CR>
        let g:ctrlp_show_hidden = 1
        let g:ctrlp_custom_ignore = {
                    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                    \ 'file': '\v\.(swp|so|zip)$', }
    endif

    " NerdTree
    if has('NERDTree')
        noremap <leader>2 :NERDTreeToggle<CR>
        " let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeShowLineNumbers=1
    endif

    " rust.vim
        " RustFmt on save
        let g:rustfmt_autosave = 1

    " airline with ALE
        let g:airline#extensions#ale#enabled = 1

    " ALE
    if has('ALEGoToDefinition')
        nnoremap <leader>d :ALEGoToDefinition<CR>

        let g:ale_fixers = {
                    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                    \   'python': ['autoimport'],
                    \}

        let g:ale_fix_on_save = 1
    endif

" Functions

    " Strip whitespace
    function! StripTrailingWhitespace()
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction

    " Toggle mouse mode
    function! ToggleMouse()
        if &mouse == 'a'
            set mouse=
            echo "Mouse disabled"
        else
            set mouse=a
            echo "Mouse enabled"
        endif
    endfunction
