" Plugin ,managed via vim-plug
call plug#begin('~/.local/share/nvim/plugged')
    Plug '~/.config/nvim/my-vim-bundle'
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/syntastic'
    " For Clojure
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    " For Rust
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
call plug#end()

" General
    set modelines=0                 "will not use modelines
    set mouse=""                    "no mouse mode
    set visualbell                  "no beep

    "line below commented out because not working in nvim
    "set t_ti= t_te=                "don't delete screen on exit

" System
    "set shortmess+=filmnrxoOtT      " abbreviated messages (no 'hit enter') use :file! to see full msg
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set hidden                      " allow buffer switching without saving
    set undofile                    " persistent undo is nice

" Formatting
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set textwidth=0                 " Hard-wrap long lines as you type them

    " Remove trailing whitespaces and ^M chars
    autocmd FileType javascript,python,clojure,clojurescript,haskell autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    "No auto comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Vim UI
    :let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1    "make the cursor a pipe in insert-mode, and a block in normal-mode

    set title                       " set the terminal title
    set showmode                    " display the current mode
    set cursorline                  " highlight current line
    set ruler                       " show the ruler
    set showcmd                     " show partial commands in status line and selected characters/lines in visual mode

    " Statusline broken down into easily includeable segments
    set statusline=%<%f\            " Filename
    set statusline+=%w%h%m%r        " Options
    set statusline+=\ [%{&ff}/%Y]   " filetype
    set statusline+=\ [%{getcwd()}] " current dir
    set statusline+=%#warningmsg#
    set statusline+=%*
    set statusline+=%=%-15.(%l,%c%V%)\ %p%%  " Right aligned file navigation info

    set relativenumber              " instead of absolute numbers
    set linespace=0                 " No extra spaces between rows
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set showmatch                   " show matching brackets/parenthesis
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=3                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    "set list                        " show char listed below in listchars
    set gdefault                    " apply global substitution to all occurrences in lines
    set splitright                  " new windows opens to the right
    set splitbelow                  " new windows opens to the right
    set nostartofline               " Do not jump to first character with page commands.

" Graphics

    set termguicolors
    set background=dark
    silent! colorscheme giulius

    " change color after column 90
    let &colorcolumn=join(range(90,300),",")

" Key (re)Mappings

    " normal regex, not Vim's one
    "noremap / /\v

    " easy moving to first non space and end of line
    nnoremap H ^
    nnoremap L $

    set pastetoggle=<F2>           " pastetoggle (sane indentation on pastes)
    " see syntax defintion under cursor
    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

    " Some extra time savers
    nnoremap ; :
    nnoremap : ;
    imap <C-c> <ESC>
    " No more help staring by mistake
    noremap <F1> <ESC>

    " move around with ctrl + movement key
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

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
    "inoremap <leader>m <ESC>:noh<CR>a

    " Toggle line numbers and fold column for easy copying
    nnoremap <leader>3 :setlocal norelativenumber!<CR>:set foldcolumn=0<CR>

    " to open new vertical split with new file
    nnoremap <leader>n :vne<CR>

    " Fast editing of the init.vim
    noremap <leader>e :e! ~/.config/nvim/init.vim<CR>

    " add blank lines above or below current line in insert mode
    "inoremap <leader>[ <ESC>m`:put!=''<CR>``a
    "inoremap <leader>] <ESC>m`:put=''<CR>``a

    " open vertical split
    nnoremap <leader>v <C-w>v<C-w>l

    " open horizontal split
    nnoremap <leader>s <C-w>s<C-w>l

    " q to quit, w to close buffer
    nnoremap <leader>q :q<CR>
    nnoremap <leader>w :bw<CR>

    " [ and ] to add blank lines in normal mode
    nnoremap <silent><leader>[ :set paste<CR>m`O<Esc>``:set nopaste<CR>
    nnoremap <silent><leader>] :set paste<CR>m`o<Esc>``:set nopaste<CR>

    " t to run tests (for now just for Clojure with fireplace plugin
    nnoremap <leader>t :w<CR>:Require!<CR>:RunTests<CR>

    " ff to display all lines with keyword under cursor and ask where jump to
    nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " enter to add a blank lime above and type into it with a blank line below
    nnoremap <leader><CR> <up>o<ESC><up>o
    inoremap <leader><CR> <ESC><up>o<ESC><up>o

    " close '{' one line below and add newline
    inoremap {{ {<CR>}<ESC>O

" Plugins

    " Ctags
        set tags=./tags;/,~/.vimtags

    " ctrlp
        let g:ctrlp_working_path_mode = 0
        nnoremap <leader>p :CtrlPMixed<CR>
        nnoremap <leader>b :CtrlPBuffer<CR>
        let g:ctrlp_show_hidden = 1
        let g:ctrlp_custom_ignore = {
                    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                    \ 'file': '\v\.(swp|so|zip)$', }

    " NerdTree
        noremap <leader>2 :NERDTreeToggle<CR>
        " let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeShowLineNumbers=1

    " rust.vim
        " RustFmt on save
        let g:rustfmt_autosave = 1

    " syntastic
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_mode_map = {
                \ "mode": "active",
                \ "active_filetypes": [],
                \ "passive_filetypes": [] }

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 0
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0

        nnoremap <leader>s :SyntasticCheck<CR>

" Automatic commands

        " always switch to the current file directory.
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

        " HTML tabs to two spaces, no wrap, no expand tab to spaces, no show whitespaces
        autocmd FileType html setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2 nowrap nolist

        " For C indent on 2 cols
        autocmd FileType c setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

        " When init.vim is edited, reload it
        autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim

        " Jump to last cursor position when opening file
        :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


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
