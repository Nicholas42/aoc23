
section .data
    file_name db 'input.txt', 0
    dir_r db 'R'
    dir_l db 'L'
    line_length dq 17
    offset_r dq 12
    offset_l dq 7
    newline db 0x0A
    zero_char db '0'

section .bss
    buffer resb 16384
    buffer_end resq 1
    map_start resq 1
    cur_dir resq 1
    depth resq 1
    stdout_buffer resb 64
    rl_len resq 1

section .text
    global _exit, buffer, buffer_end, cmp_triple, cur_dir, depth, end_round, find_next_triple, find_triple, line_length, map_start, prepare, rl_len, write_number

prepare:
    call read_file

    ; Set cur_dir to start of directions
    lea rax, [buffer]
    mov [cur_dir], rax

    ; find start of mappings
    call find_start

    ret

_exit:
    ; Exit the program
    mov rax, 60 ; sys_exit
    mov rdi, 0
    ; xor rdi, rdi ; exit code 0
    syscall

read_file:
    mov rax, 2 ; sys_open
    lea rdi, [file_name]
    mov rsi, 0 ; O_RDONLY
    xor rdx, rdx ; mode is not used for O_RDONLY
    syscall

    mov rdi, rax ; file descriptor, used in read and close

    mov rax, 0 ; sys_read
    lea rsi, [buffer]
    mov rdx, 16384
    syscall

    ; store pointer to end of read data
    lea rsi, [buffer]
    add rax, rsi
    mov [buffer_end], rax

    mov rax, 3 ; sys_close, rdi aleady set
    syscall

    ret

find_start:
    xor rsi, rsi
loop_find_start:
    inc rsi
    mov al, [buffer + rsi]
    cmp al, 0x0a
    jne loop_find_start

    mov [rl_len], rsi

    lea rdi, [buffer + rsi + 2]
    mov [map_start], rdi

    ret

; rdi and rsi are pointers to the triples to be compared
cmp_triple:
    mov al, [rsi]
    mov dl, [rdi]
    cmp al, dl
    jne cmp_triple_fail

    mov al, [rsi + 1]
    mov dl, [rdi + 1]
    cmp al, dl
    jne cmp_triple_fail

    mov al, [rsi + 2]
    mov dl, [rdi + 2]
    cmp al, dl
    jne cmp_triple_fail

    mov rax, 1
    jmp cmp_triple_end

cmp_triple_fail:
    mov rax, 0

cmp_triple_end:
    ret

end_round:
    call inc_cur_dir
    mov rax, [depth]
    add rax, 1
    mov [depth], rax

    ret

inc_cur_dir:
    mov rsi, [cur_dir]
    add rsi, 1
    mov [cur_dir], rsi

    ; If we reached the newline, jump back to start
    mov al, [rsi]
    cmp al, [newline]
    jne inc_cur_dir_end

    lea rsi, [buffer]
    mov [cur_dir], rsi

inc_cur_dir_end:
    ret


; rdi is a pointer to the triple searched
find_triple:
    mov rsi, [map_start]

find_triple_loop:
    call cmp_triple
    cmp rax, 1
    je find_triple_loop_success
    add rsi, [line_length]
    jmp find_triple_loop

find_triple_loop_success:
    mov rax, rsi
    ret


; rdi is offset of current line
find_next_triple:
    mov rsi, [cur_dir]
    mov al, [rsi]
    cmp al, [dir_l]
    jne find_next_triple_move_r

    add rdi, [offset_l]
    jmp find_next_triple_search

find_next_triple_move_r:
    add rdi, [offset_r]

find_next_triple_search:
    call find_triple
    ret

; Print number in rdi
write_number:
    mov rcx, 63
    mov al, [newline]
    mov [stdout_buffer + rcx], al
    mov rax, rdi
    mov rdi, 10

write_number_write_loop:
    sub rcx, 1
    xor rdx, rdx
    div rdi
    add rdx, [zero_char]
    mov [stdout_buffer + rcx], dl
    cmp rax, 0
    jg write_number_write_loop

    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    lea rsi, [stdout_buffer + rcx]
    mov rdx, 64
    sub rdx, rcx ; only print the number of chars used
    syscall

    ret

