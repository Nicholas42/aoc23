extern _exit, buffer, buffer_end, cur_dir, depth, end_round, find_next_triple, line_length, map_start, prepare, rl_len, write_number

section .bss
    current_words resq 10
    parallel_words resq 1

section .text
    global _start

_start:
    call prepare

    call find_start_triples
    call calc_depths

    call multiply_depths

    mov rdi, rax
    call write_number

    call _exit


calc_depths:
    xor rcx, rcx

calc_loop:
    mov rdi, [current_words + 8*rcx]
    push rcx
    call calc_depth
    pop rcx

    mov rdi, [depth]
    mov [current_words + 8*rcx], rdi

    push rcx
    call reset
    pop rcx

    inc rcx
    cmp rcx, [parallel_words]
    jl calc_loop

    ret


multiply_depths:
    xor rcx, rcx
    xor rdx, rdx
    mov rax, [rl_len]

multiply_loop:
    mov rdi, [current_words + 8*rcx]
    mul rdi

    mov rsi, [rl_len]
    div rsi

    inc rcx
    cmp rcx, [parallel_words]
    jl multiply_loop

    ret


; rdi contains pointer to starting triple
calc_depth:
    call find_next_triple
    mov rdi, rax
    push rdi
    call end_round
    pop rdi

    mov al, [rdi + 2]
    cmp al, 0x5a
    jne calc_depth

    ret


reset:
    mov qword [depth], 0

    ; Set cur_dir to start of directions
    lea rax, [buffer]
    mov [cur_dir], rax

    ret


find_start_triples:
    mov rsi, [map_start]
    xor rcx, rcx

find_start_triples_loop:
    mov al, [rsi + 2]
    cmp al, 0x41
    jne find_start_triples_continue

    mov [current_words + 8*rcx], rsi
    inc rcx

find_start_triples_continue:
    add rsi, [line_length]
    cmp rsi, [buffer_end]
    jl find_start_triples_loop

    mov [parallel_words], rcx

    ret
