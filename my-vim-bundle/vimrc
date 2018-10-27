" Inspired from http://stevelosh.com/blog/2010/09/coming-home-to-vim/ and
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc

" General
    set nocompatible                "who cares about vi?
    set modelines=0                 "will not use modelines
    set ttyfast                     "Indicates a fast terminal connection

    " Determine OS
    let os=substitute(system('uname'), '\n', '', '')
    if os == 'Darwin' || os == 'Mac'
        let os='Mac'
    endif

" Setup Bundle Support through Vundle
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'
    " Use bundles config file
    if filereadable(expand("~/.vim/vimrc.bundles"))
        source ~/.vim/vimrc.bundles
    endif
    call vundle#end()
    filetype plugin indent on       " Automatically detect file types.

" System
    syntax enable                       " syntax highlighting
    scriptencoding utf-8
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter') use :file! to see full message
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set history=1000                " Store a ton of history (default is 20)
    set hidden                      " allow buffer switching without saving
    set viminfo='100,<100,:20,%,h,n~/.vim/.dirs/.viminfo

    " Setting up the directories
    set backup                      " backups are nice
    if has('persistent_undo')
        set undofile                "so is persistent undo
        set undolevels=1000         "maximum number of changes that can be undone
        set undoreload=10000        "maximum number lines to save for undo on a buffer reload
    endif

" Formatting
    set wrap                        " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspacehhhdelete indent

    " disable automatic commenting of lines after comments and line breaks
    set formatoptions-=tcro
    set textwidth=0

    " Remove trailing whitespaces and ^M chars
    autocmd FileType javascript,python autocmd BufWritePre <buffer> call StripTrailingWhitespace()


" Vim UI
    set title                       " set the terminal title
    set showmode                    " display the current mode
    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set showcmd                 " show partial commands in status line and selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\        " Filename
        set statusline+=%w%h%m%r    " Options
        if exists("*fugitive#statusline")
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%#warningmsg#
        if exists("*SyntasticStatuslineFlag")
            set statusline+=%{SyntasticStatuslineFlag()}
        endif
        set statusline+=%*
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set relativenumber              " instead of absolute numbers
    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=3                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list                        " show char listed below in listchars
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    set gdefault                    " apply global substitution to all occurrences in lines
    set splitright                  " new windows opens to the right

" Graphics
    if ! has("gui_running")
        set term=screen-256color
        set t_Co=256
    endif

    set background=dark
    silent! colorscheme giulius

    if has('gui_running') && os == 'Mac'
        set guifont=Inconsolata:h16.00
    endif

    " change color after column 85
    "let &colorcolumn=join(range(85,300),",")

" Key (re)Mappings

    let mapleader = ","

    " normal regex, not Vim's one
    "noremap / /\v

    " comma to de-highlight search
    nnoremap <leader>m :noh<CR>
    inoremap <leader>m <ESC>:noh<CR>a

    " easy moving to first non space and end of line
    nnoremap H ^
    nnoremap L $

    " Code folding options
    nnoremap <leader>f0 :set foldlevel=0<CR>
    nnoremap <leader>f1 :set foldlevel=1<CR>
    nnoremap <leader>f2 :set foldlevel=2<CR>
    nnoremap <leader>f3 :set foldlevel=3<CR>
    nnoremap <leader>f4 :set foldlevel=4<CR>
    nnoremap <leader>f5 :set foldlevel=5<CR>
    nnoremap <leader>f6 :set foldlevel=6<CR>
    nnoremap <leader>f7 :set foldlevel=7<CR>
    nnoremap <leader>f8 :set foldlevel=8<CR>
    nnoremap <leader>f9 :set foldlevel=9<CR>

    set pastetoggle=<leader>-           " pastetoggle (sane indentation on pastes)

    " Disable arrow keys and sane up and down
    imap <up> <nop>
    imap <down> <nop>
    imap <left> <nop>
    imap <right> <nop>
    nnoremap j gj
    nnoremap k gk

    " No more help staring by mistake
    noremap <F1> <ESC>

    " Some extra time savers
    nnoremap ; :
    imap <C-c> <ESC>

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

    " map <leader>ff to display all lines with keyword under cursor and ask which one to jump to
    nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    noremap zl zL
    noremap zh zH

    " use space to replay macro 'q' (qq / q to start/stop recording)
    nnoremap <Space> @q

    " Toggle line numbers and fold column for easy copying
    nnoremap <leader>3 :setlocal norelativenumber!<CR>:set foldcolumn=0<CR>

    " allow the . to execute once for each line of a visual selection
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    noremap <leader>ww :w !sudo tee % > /dev/null<CR>

    " to save and open current file
    nnoremap <leader>o :w<CR>:!open<space>%<CR>

    " to open new vertical split with new file
    nnoremap <leader>n :vne<CR>

    " Fast editing of the .vimrc
    noremap <leader>e :e! ~/.vim/vimrc<CR>

    " add blank lines above or below current line in insert mode
    inoremap <leader>[ <ESC>m`:put!=''<CR>``a
    inoremap <leader>] <ESC>m`:put=''<CR>``a

    " open vertical split
    nnoremap <leader>v <C-w>v<C-w>l

    " open horizontal split
    nnoremap <leader>s <C-w>s<C-w>l

    " Ctrl+s to save and if needed de-highlight search and select autocomplete
    noremap <C-s> :noh<CR>:w<CR>
    inoremap <C-s> <ESC>:noh<CR>:w<CR>

    " q to quit, qq to quit without saving
    noremap <leader>q :q<CR>
    noremap <leader>qq :q!<CR>

    " mm to toggle mouse mde
    noremap mm :call MouseToggle()<CR>

    "AA in insert mode brings to end of line in insert mode
    inoremap AA <ESC>A

    "Close buffer, not split
    nnoremap <leader>d :b#<bar>bd#<CR>

" Plugins

    " Buffer explorer
        nnoremap <leader>b :BufExplorer<CR>

    " Ctags
        set tags=./tags;/,~/.vimtags

    " ctrlp
        let g:ctrlp_working_path_mode = 0
        let g:ctrlp_map = '<c-t>'
        nmap <silent> <C-t> :CtrlPMixed<CR>
        let g:ctrlp_show_hidden = 1
        set wildignore+=*/..*
        let g:ctrlp_custom_ignore = {
                    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                    \ 'file': '\v\.(swp|so|zip)$', }

    "easy-align
        " Start interactive EasyAlign in visual mode
        vmap <Enter> <Plug>(EasyAlign)
        " Start interactive EasyAlign with a Vim movement
        nmap <Leader>a <Plug>(EasyAlign)
        nmap <Leader>= <Leader>a}=

    "html indent
        let g:html_indent_inctags = "html,body,head,tbody"
        let g:html_indent_script1 = "inc"
        let g:html_indent_style1 = "inc"

    " Hdevtools (haskell)
        au FileType haskell nnoremap <buffer> <leader>0 :HdevtoolsType<CR>
        au FileType haskell nnoremap <buffer> <silent> <leader>9 :HdevtoolsClear<CR>

    " NerdTree
        noremap <leader>2 :NERDTreeToggle<CR>
        " let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeShowLineNumbers=1

    " Session List
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nnoremap <leader>sl :SessionList<CR>
        nnoremap <leader>ss :SessionSave<CR>

    " Syntastic
         let g:syntastic_always_populate_loc_list = 1
         let g:syntastic_javascript_checker='jshint'
         let g:syntastic_haskell_ghc_mod_args = '-g -fno-warn-missing-signatures' "no missing signature warning

    " TagBar
        nnoremap <silent> tt :TagbarToggle<CR>

    " OmniComplete
        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        "imap <expr> <ESC>       pumvisible() ? "\<C-y><ESC>" : "\<ESC>"
        "imap <expr> <C-d>       pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        "imap <expr> <C-u>       pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menuone

    "YCM"
    let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

    "vim-go
        "let g:go_bin_path = $HOME . '/.vim/bundle/vim-go/bin'
        let g:go_fmt_fail_silently = 1
        let g:go_fmt_command = "goimports"

" Automatic commands

        " always switch to the current file directory.
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

        " HTML tabs to two spaces, no wrap, no expand tab to spaces, no show whitespaces
        autocmd FileType html setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2 nowrap nolist

        " When vimrc is edited, reload it
        autocmd! bufwritepost vimrc source ~/.vim/vimrc

        " Jump to last cursor position when opening file
        :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " golang commands courtesy of vim-go
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <leader>g <Plug>(go-run)
        au FileType go nmap <leader>gb <Plug>(go-build)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <Leader>d <Plug>(go-doc-vertical)
        au FileType go nmap <Leader>dd <Plug>(go-def)
        au FileType go nmap <Leader>ds <Plug>(go-def-split)
        au FileType go nmap <Leader>dv <Plug>(go-def-vertical)

" Functions

    " Set up centralized directories for vim temp files
    function! InitializeDirectories()
        let separator = "."
        let home = $HOME
        let parent = home . '/' . '.vim/.dirs'
        let prefix = '.vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/' . prefix . dirname . "/"
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory, "p")
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()

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

    " Toggle mouse mpde
    function! MouseToggle()
        if &mouse == ""
            let &mouse="a"
        else
            let &mouse=""
        endif
    endfunction
