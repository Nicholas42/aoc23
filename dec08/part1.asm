extern _exit, cmp_triple, depth, end_round, find_next_triple, find_triple, prepare, write_number

section .data
    aaa_trip db 'AAA'
    zzz_trip db 'ZZZ'

section .text
    global _start

_start:
    call prepare

    call find_zzz

    mov rdi, [depth]
    call write_number

    call _exit

find_zzz:
    push r12

    lea rdi, [aaa_trip]
    call find_triple
    mov r12, rax

find_zzz_round:
    mov rdi, r12
    call find_next_triple
    mov r12, rax
    call end_round

    lea rsi, [zzz_trip]
    mov rdi, r12
    call cmp_triple
    cmp rax, 1

    jne find_zzz_round

    pop r12
    ret
