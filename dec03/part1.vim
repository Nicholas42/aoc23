#!/bin/vim -u

:set hidden
:enew
:b1

" We want motions that can fail without stopping the macro
:execute "nmap _j :silent! normal j\<CR>"
:execute "nmap _k :silent! normal k\<CR>"
:execute "nmap _h :silent! normal h\<CR>"
:execute "nmap _l :silent! normal l\<CR>"

:execute "let @h='/[^0-9]\\d\\+[^0-9]\<CR>ma_kml`ae_l_j\<C-v>`ly`aeme`alv`er.:b2\<CR>:silent! :norm pJJJ\<CR>o\<Esc>:b1\<CR>@h'"
:execute "let @g='/^\\d\<CR>ma_kml`ae_l_j\<C-v>`ly`aver.:b2\<CR>:silent! :norm pJJJ\<CR>o\<Esc>:b1\<CR>@g'"
:execute "let @j='/\\d\\+$\<CR>mah_kml`a$_j\<C-v>`ly`av$r.:b2\<CR>:silent! :norm pJJJ\<CR>o\<Esc>:b1\<CR>@j'"

:norm @h
:norm @g
:norm @j
:e!
:b2
:%v/[^0-9 .]/d
:%s/[^0-9]//g
:g/^$/d

:execute "let @u='/\\%>1l^[^0]\\d\\d\<CR>100\<C-x>gg100\<C-a>@u'"
:norm @u
:execute "let @t='/\\%>1l^[^0]\\d\<CR>10\<C-x>gg10\<C-a>@t'"
:norm @t
:execute "let @s='/\\%>1l^[^0]\<CR>\<C-x>gg\<C-a>@s'"
:norm @s
:2,$d
:w! result_part1.txt
:qa!
