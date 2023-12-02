#!/bin/sed -nf

s/[^0-9]//g
s/^./&&/
s/^\(.\).*\(.\)$/\1\2/

1h
1d

: decrement
s/0\(_*\)$/_\1/; t decrement

s/1\(_*\)$/0\1/; t carry_down
s/2\(_*\)$/1\1/; t carry_down
s/3\(_*\)$/2\1/; t carry_down
s/4\(_*\)$/3\1/; t carry_down
s/5\(_*\)$/4\1/; t carry_down
s/6\(_*\)$/5\1/; t carry_down
s/7\(_*\)$/6\1/; t carry_down
s/8\(_*\)$/7\1/; t carry_down
s/9\(_*\)$/8\1/; t carry_down

b done

: carry_down
y/_/9/

x

: increment
s/9\(_*\)$/_\1/; t increment

s/^\(_*\)$/0\1/

s/0\(_*\)$/1\1/; t carry_up
s/1\(_*\)$/2\1/; t carry_up
s/2\(_*\)$/3\1/; t carry_up
s/3\(_*\)$/4\1/; t carry_up
s/4\(_*\)$/5\1/; t carry_up
s/5\(_*\)$/6\1/; t carry_up
s/6\(_*\)$/7\1/; t carry_up
s/7\(_*\)$/8\1/; t carry_up
s/8\(_*\)$/9\1/; t carry_up

: carry_up

y/_/0/

x

b decrement

: done
x
$p
x
