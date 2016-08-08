Installation
============

```
sudo apt-get install exuberant-ctags vim vim-gui-common the-silver-searcher
git clone https://github.com/Seb-C/vim-config.git ~/.vim
```

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
