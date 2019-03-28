" Some specific keys to make vim easier with an AZERTY keyboard
"if system("setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F'+' '{print $2}'") =~ "fr"
"  " Make digits usable without maintaining the shift key
"  noremap & 1
"  noremap é 2
"  noremap " 3
"  noremap ' 4
"  noremap ( 5
"  noremap - 6
"  noremap è 7
"  noremap _ 8
"  noremap ç 9
"  noremap à 0
"
"  " Non digits may be used with shift instead
"  noremap 1 &
"  noremap 2 é
"  noremap 3 "
"  noremap 4 '
"  noremap 5 (
"  noremap 6 -
"  noremap 7 è
"  noremap 8 _
"  noremap 9 ç
"  noremap 0 à
"endif
