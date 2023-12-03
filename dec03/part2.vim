#!/bin/vim -u

:set hidden
:enew
:b1
:enew
:b1
:enew
:b1

" We want motions that can fail without stopping the macro
:nmap _j :execute ":silent! normal j"
:nmap _h :execute ":silent! normal h"
:nmap _k :execute ":silent! normal k"
:nmap _l :execute ":silent! normal l"

:execute "let @j='/\\d\<CR>ma_h_kml`a_hemr_l_j\<C-V>`ly`av`rr.:b3\<CR>:silent! :norm pJJJ\<CR>o\<ESC>:b2\<CR>gg'"
:execute "let @d=':b3\<CR>:v/*/d\<CR>:%s/[^0-9]//g\<CR>gg:silent! :norm JJJJJ\<CR>dd:b4\<CR>p'"
:execute "let @c=':b3\<CR>ggdG:b2\<CR>ggdG:b1\<CR>'"
:execute "let @h='/*\<CR>ma_h_h_h_kml`a_l_l_l_j\<C-v>`ly`ar.:b2\<CR>pjlllma:%s/*/./g\<CR>`ar*:silent! :%s/^\\d[^0-9]/../\<CR>ggO.......\<Esc>gg'"
:execute "let @a='@h:silent! :norm 10@j\<CR>@d@c@a'"

:norm @a
:e!
:b4
:v/\d\+ \d\+/d
:execute "let @m='\"qyew\"wye0D:let @e=@q*@w\<CR>\"ep'"
:%norm @m

:execute "let @s='/\\%>1l^[^0]\\d\\d\\d\\d\\d\\d\<CR>1000000\<C-x>gg1000000\<C-a>@s'"
:norm @s
:execute "let @s='/\\%>1l^[^0]\\d\\d\\d\\d\\d\<CR>100000\<C-x>gg100000\<C-a>@s'"
:norm @s
:execute "let @s='/\\%>1l^[^0]\\d\\d\\d\\d\<CR>10000\<C-x>gg10000\<C-a>@s'"
:norm @s
:execute "let @s='/\\%>1l^[^0]\\d\\d\\d\<CR>1000\<C-x>gg1000\<C-a>@s'"
:norm @s
:execute "let @s='/\\%>1l^[^0]\\d\\d\<CR>100\<C-x>gg100\<C-a>@s'"
:norm @s
:execute "let @s='/\\%>1l^[^0]\\d\<CR>10\<C-x>gg10\<C-a>@s'"
:norm @s
:execute "let @s='/\\%>1l^[^0]\<CR>\<C-x>gg\<C-a>@s'"
:norm @s
:2,$d
:w! result_part2.txt
:qa!
