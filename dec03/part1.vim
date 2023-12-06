#!/bin/env -S vim -n -u

:set hidden
:enew
:b1

" We want motions that can fail without stopping the macro
:execute "nmap _j :silent! normal j\<CR>"
:execute "nmap _k :silent! normal k\<CR>"
:execute "nmap _h :silent! normal h\<CR>"
:execute "nmap _l :silent! normal l\<CR>"

:execute "let @h='/[^0-9]\\d\<CR>ma_kml`ae_l_j\<C-v>`ly`aveolr.:b2\<CR>p`[v`]Jo\<Esc>:b1\<CR>@h'"
:execute "let @g='/^\\d\<CR>ma_kml`ae_l_j\<C-v>`ly`aver.:b2\<CR>p`[v`]Jo\<Esc>:b1\<CR>@g'"

:norm @h
:norm @g

:e!
:b2
:%v/[^0-9 .]/d
:%s/[^0-9]//g
:g/^$/d

:execute "let @s='/\\%>1l[1-9]$\<CR>\<C-x>gg\<C-a>''''@s'"
:execute "let @t=':norm @s\<CR>:2,$s/0$//\<CR>ggf_hi_\<ESC>@t'"
:norm ggA_
:norm @t
:2,$d
:s/_//g
:w! result_part1.txt
:qa!
