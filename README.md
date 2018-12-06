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
