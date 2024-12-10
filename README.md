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

To have `golangci-lint` integration:
```
go install github.com/nametake/golangci-lint-langserver@latest
```

To have rust working:
```
rustup component add rust-analyzer
rustup component add rust-src
```

Language server for json:
```
npm install -g vscode-json-languageserver
```
