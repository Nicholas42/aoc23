#!/bin/env -S vim -n -u

:set hidden
:enew
:b1
:enew
:b1
:enew
:b1

" We want motions that can fail without stopping the macro
:execute "nmap _j :silent! normal j\<CR>"
:execute "nmap _k :silent! normal k\<CR>"
:execute "nmap _h :silent! normal h\<CR>"
:execute "nmap _l :silent! normal l\<CR>"

:execute "let @j='/\\d\<CR>ma_h_kml`a_hemr_l_j\<C-V>`ly`av`rr.:b3\<CR>:silent! :norm pJJJ\<CR>o\<ESC>:b2\<CR>gg'"
:execute "let @d=':b3\<CR>:v/*/d\<CR>:%s/[^0-9]//g\<CR>gg:silent! :norm JJJJJ\<CR>dd:b4\<CR>p'"
:execute "let @c=':b3\<CR>ggdG:b2\<CR>ggdG:b1\<CR>'"
:execute "let @h='/*\<CR>ma_h_h_h_kml`a_l_l_l_j\<C-v>`ly`ar.:b2\<CR>pjlllma:%s/*/./g\<CR>`ar*:silent! :%s/^\\d[^0-9]/../\<CR>ggO.......\<Esc>gg'"
:execute "let @a='@h:silent! :norm 10@j\<CR>@d@c@a'"


:norm @a

:e!
:b4
:silent! :v/\d\+ \d\+/d
:execute "let @m='\"qyew\"wye0D:let @e=@q*@w\<CR>\"ep'"
:%norm @m

:execute "let @s='/\\%>1l[1-9]$\<CR>\<C-x>gg\<C-a>''''@s'"
:execute "let @t=':norm @s\<CR>:2,$s/0$//\<CR>ggf_hi_\<ESC>@t'"
:norm ggA_
:norm @t
:2,$d
:s/_//g
:w! result_part2.txt
:qa!
