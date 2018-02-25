This project is a collection of the vim bundles that I like to use. It is meant
to be used after pathogen is installed, and cloned directly into ~/.vim with
the name 'bundle'. On UNIX-like operating systems (OS X, Linux, BSD, AMIGA,
etc) you can do this with the following commands:

```bash
cd ~ && git clone https://github.com/monokrome/vim-config .vim
```

If you are on Windows, then you should clone the repository to the directory
`vimfiles` directory instead. In the command-line `git` client, this can be
done like so:

```bash
cd ~ && git clone https://github.com/monokrome/vim-config vimfiles
```

**NOTE:** If you use Windows, do not have gitslave, or do not want to install
it then see the [NeoBundle QuickStart][nb] for manual installation
instructions. [Git Slave][gs] is does *NOT* directly support Windows.

After the project has been cloned with git, make sure that you have installed a
piece of software called [git slave][gs].  Git slave *is not* part of git
itself.

You can easily install git slave in OS X if you have homebrew:

```bash
brew install gitslave
```

Now, you can have git slave populate the bundles:

```bash
cd ~/.vim && gits populate
```


[nb]: https://github.com/Shougo/neobundle.vim/blob/master/README.md#quick-start "NeoBundle QuickStart"
[gs]: http://gitslave.sourceforge.net/ "Git Slave"
