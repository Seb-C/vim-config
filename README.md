Installation
============

```
sudo apt-get install vim-gtk3 vim-gui-common silver-searcher-ag
git clone https://github.com/Seb-C/vim-config.git ~/.vim
```

To enable bash_aliases with `:!`, you must add this line on top of your `.bash_aliases`: 

```
shopt -s expand_aliases"
```

Coc extensions to install:
```
CocInstall coc-css coc-phpls coc-docker coc-eslint coc-git coc-go coc-html coc-json coc-sh coc-sql coc-xml coc-yaml coc-svg coc-tsserver coc-rust-analyzer
```

To have `golangci-lint` integration:
```
go install github.com/nametake/golangci-lint-langserver@latest
```
