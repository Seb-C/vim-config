Installation
============

```
sudo apt-get install vim vim-gui-common the-silver-searcher
git clone https://github.com/Seb-C/vim-config.git ~/.vim
gem install mdn_query
```

Also build and install universal-ctags from https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
It will be called as `ctags` in your $PATH

To enable bash_aliases with `:!`, you must add this line on top of your `.bash_aliases`: 

```
shopt -s expand_aliases"
```

To stop the terminal from hanging on some keyboard commands (<C-s>):
```
stty -ixon
```

Xterm is better to be able to use vim without some keyboard commands intercepted by the terminal emulator
```
xterm -fa 'Monospace' -fs 9 -cr 'red'
```
