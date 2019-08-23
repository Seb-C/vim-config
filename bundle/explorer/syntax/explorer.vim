" Concealing separately every directory level and the directory separator
syntax match explorerDirName /[^\/]\+/ conceal cchar=|
syntax match explorerDirSeparator /\// conceal cchar= 

" Separating the last part of the filename so that it is not concealed
syntax match explorerFileName /[^\/]\+\/\?$/

" Concealing everything which is not the filename
highlight! link Conceal explorerDirName
highlight! link Conceal explorerDirSeparator
