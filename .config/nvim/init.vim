" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif  " Disable Vi compatibility

" Initialize Python plugin in Neovim
if has('nvim')
    runtime! plugin/python_setup.vim
endif

" Initialize Plug package management
if has('vim_starting')
  call plug#begin('~/.vim/plugged')

  " My custom configurations. This is akin to what most people might put into one
  " giant .vimrc file.
  Plug 'monokrome/vim-user-configuration'

  " Utility plugins - used by other scripts for their features.
  Plug 'Shougo/unite.vim' " Library for generalized navigation of item lists
  Plug 'Shougo/vimproc.vim' " Async utility library
  Plug 'mattn/webapi-vim' " HTTP access to VimScript commands
  Plug 'rizzatti/funcoo.vim' " Adds 'object-oriented' constructs to VimL
  Plug 'vim-scripts/L9' " Helper library for VimL


  " Colors
  Plug 'altercation/vim-colors-solarized' " Solarized color scheme
  Plug 'sjl/badwolf' " A nice, warm color scheme
  Plug 'junegunn/seoul256.vim' " Add seoul256.vim color scheme
  Plug 'jeetsukumaran/vim-nefertiti' " Colorscheme formerly known as MochaLatte
  Plug 'ajh17/Spacegray.vim' " Based on the XCode SpaceGray theme
  Plug 'chrisbra/Colorizer' " Colorize hex values and such <3

  " Completions for nvim
  if has('nvim')
    Plug 'Shougo/deoplete.nvim' " Completion support that isn't YouCompleteMe
  endif

  " Helper plugins
  Plug 'Lokaltog/vim-easymotion' " Allows quick motions to characters that are currently in vim
  Plug 'Raimondi/delimitMate' " Puts things after other things!
  Plug 'Shougo/unite-outline' " A nested outline of the current buffer's tags
  Plug 'SirVer/ultisnips' " Much smarter TextMate-style snippet support
  Plug 'duff/vim-bufonly' " A command for removing all buffers except the active one
  Plug 'editorconfig/editorconfig-vim' " Allows a common format for storing editor configuration conventions
  Plug 'ervandew/supertab' " Use tab for completions (This breaks stuff?)
  Plug 'gcmt/wildfire.vim' " Smart visual selection of nearest objects by pressing <Enter>
  Plug 'godlygeek/tabular' " Simplify horizontal alignment of text
  Plug 'goldfeld/vim-seek' " A two-character context version of the 'f' and 'F' motion
  Plug 'gregsexton/MatchTag' " Highlights matching tags when the cursor is over one of them
  Plug 'guns/vim-sexp' " More nice text objects, operators, and motions!
  Plug 'honza/vim-snippets' " A decent library of standard snippets
  Plug 'https://github.com/rking/ag.vim' " Use silver searcher for :find-like searches with :Ag
  Plug 'itchyny/lightline.vim' " A lightweight alternative to PowerLIne for pretty statusbars
  Plug 'johnsyweb/vim-makeshift' " 'intelligent' selection of makeprg
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'kana/vim-exjumplist' " Plug mappings to jump between buffers in the jumplist
  Plug 'majutsushi/tagbar' " A tagbar pane for the current buffer
  Plug 'mattn/emmet-vim' " Add shortcuts for making HTML elements
  Plug 'mattn/gist-vim' " Allows simple posting to Gist from within Vim
  Plug 'mhinz/vim-signify' " Signs that describe your current SCM changeset
  Plug 'michaeljsmith/vim-indent-object' " An indentation (i) text object for indent-based languages
  Plug 'monokrome/vim-flow' " Rhyme completion and syllable counting
  Plug 'monokrome/vim-projector' " Load project-specific configuration files
  Plug 'nathanaelkane/vim-indent-guides' " Guide lines for indentation
  Plug 'neochrome/todo.vim' " A todo list for Vim.
  Plug 'neomake/neomake'
  Plug 'nicholaides/words-to-avoid.vim' " Highlights words that should be avoided in technical writing
  Plug 'sbdchd/neoformat' " Clean code for me, plz!
  Plug 'sjl/gundo.vim' " Tools to help better manage the undo tree
  Plug 'taxilian/a.vim' " Commands for jumping between alternate related files
  Plug 'terryma/vim-multiple-cursors' " The ability to use multiple cursors
  Plug 'tommcdo/vim-exchange' " Use cx to exchange text over motions
  Plug 'tpope/heroku-remote' " Helpers for working with Heroku
  Plug 'tpope/vim-abolish' " For performing replaces, fixing typos, and otherwise managing many variants of phrases
  Plug 'tpope/vim-characterize' " Enhances 'ga' to provide more useful information
  Plug 'tpope/vim-classpath' " Manages the Java classpath
  Plug 'tpope/vim-commentary' " Comment and uncomment lines with 'gc' verbs
  Plug 'tpope/vim-dispatch' " Forks processes from Vim, and get their output in a buffer after they finish.
  Plug 'tpope/vim-endwise' " Automatically insert redundant block-closing code
  Plug 'tpope/vim-eunuch' " File management from inside Vim
  Plug 'tpope/vim-fireplace' " Clojure REPL integration
  Plug 'tpope/vim-flatfoot' " Smarter mappings for the {f,F,t,T} motions using CTRL.
  Plug 'tpope/vim-fugitive' " Git integration
  Plug 'tpope/vim-haml' " Provides support for HAML and SASS
  Plug 'tpope/vim-jdaddy' " JSON text objects
  Plug 'tpope/vim-obsession' " Automatic session management via :Obsession
  Plug 'tpope/vim-projectionist' " Scaffolding in Vim
  Plug 'tpope/vim-repeat' " Makes repeat even more powerful
  Plug 'tpope/vim-rhubarb' " Tools for interacting with the social aspect of GitHub
  Plug 'tpope/vim-sensible' " Somewhat sensible defaults for modernizing Vim a bit by default.
  Plug 'tpope/vim-sleuth' " Automatic exploration of related files to set up indentation settings
  Plug 'tpope/vim-speeddating' " Manages dates more easily by adding support for them to CTRL-A/CTRL-X
  Plug 'tpope/vim-surround' " Automates insertion of surrounding characters (IE, } after {)
  Plug 'tpope/vim-tbone' " Basic integrations between tmux and Vim
  Plug 'tpope/vim-unimpaired' " Nice keybinds for toggling, enabling, navigating, etc. using [, ], and c.
  Plug 'tpope/vim-vinegar' " Manage file/directory navigation more easily while sticking with netrw.
  Plug 'tsukkee/unite-tag' " Search tagfiles via Unite
  Plug 'vim-scripts/TaskList.vim' " Provides lists of tasks (TODO, FIXME, etc) related to the current buffer
  Plug 'vim-scripts/closetag.vim' " Reduces redudant typing in XML-like file types
  Plug 'vim-scripts/openssl.vim' " Allows wrapping Vim's I/O around OpenSSL
  Plug 'voithos/vim-python-matchit' " Allows the % motion to work with Python keywords.
  Plug 'wellle/targets.vim' " Some smart generic text objects!

  " Language bundles
  Plug 'Glench/Vim-Jinja2-Syntax'
  Plug 'Quramy/tsuquyomi'
  Plug 'afshinm/npm.vim'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'chase/vim-ansible-yaml'
  Plug 'chrisbra/csv.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'davidhalter/jedi-vim'
  Plug 'davidoc/taskpaper.vim'
  Plug 'digitaltoad/vim-jade'
  Plug 'dleonard0/pony-vim-syntax'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'elzr/vim-json'
  Plug 'fatih/vim-go'
  Plug 'guns/vim-clojure-static'
  Plug 'https://github.com/pangloss/vim-javascript'
  Plug 'ivalkeen/vim-simpledb' 
  Plug 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
  Plug 'justinmk/vim-sneak'
  Plug 'kchmck/vim-coffee-script'
  Plug 'leafgarland/typescript-vim'
  Plug 'lunaru/vim-less'
  Plug 'mctenshi/vim-literate-coffeescript'
  Plug 'monokrome/vim-testdrive'
  Plug 'mpyatishev/vim-sqlformat'
  Plug 'mutewinter/nginx.vim'
  Plug 'mxw/vim-jsx'
  Plug 'othree/html5.vim'
  Plug 'plasticboy/vim-markdown'
  Plug 'raichoo/haskell-vim'
  Plug 'rust-lang/rust.vim'
  Plug 'sbdchd/neoformat'
  Plug 't9md/vim-chef'
  Plug 'ternjs/tern_for_vim'
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-liquid'
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
  Plug 'vim-scripts/JavaScript-Indent'
  Plug 'wavded/vim-stylus'
  Plug 'zchee/deoplete-go'

  " Framework-specific bundles
  Plug 'jmcomets/vim-pony' " Wraps Django commands into Vim commands
  Plug 'moll/vim-node' " Helpers for working in NodeJS
  Plug 'smerrill/vagrant-vim' " Automatically set `ruby` filetype on Vagrantfile
  Plug 'vim-scripts/django.vim' " Syntax highlighting for Django templates

  " Mark dependencies as having all been listed
  call plug#end()
endif
