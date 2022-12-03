section .data
    LF equ 10 ; line feed
    NULL equ 0 ; end of string
    TRUE equ 1
    FALSE equ 0
    EXIT_SUCCESS equ 0 ; success code
    STDIN equ 0 ; standard input
    STDOUT equ 1 ; standard output
    STDERR equ 2 ; standard error
    SYS_read equ 0 ; read
    SYS_write equ 1 ; write
    SYS_open equ 2 ; file open
    SYS_close equ 3 ; file close
    SYS_fork equ 57 ; fork
    SYS_exit equ 60 ; terminate
    SYS_creat equ 85 ; file open/create
    SYS_time equ 201 ; get time

section .bss
    chr resb 1
    cadena resb 52

section .text
    global _start

_start:
    ; bit flag para ver si cuando hay un salto de linea, el anterior lo era(cambio de elfo)
    xor r13, r13
    ; suma mayor
    xor r10, r10

leerelfo:
    ; suma de cada elfo
    xor r11, r11

leerlinea:
    ; guardar numero de cada linea
    xor r12, r12

leercaracter:
    ; leer caracter de STDIN en chr 
    mov rax, SYS_read
    mov rdi, STDIN
    mov rsi, chr
    mov rdx, 1
    push r11
    syscall
    pop r11
    
    ; la llamada read devuelve 0 en rax cuando es el final del archivo
    cmp rax, NULL
    je finalaux

    ; comparar chr con salto de linea
    xor rax, rax
    mov al, byte [chr]
    cmp al, LF
    je saltolinea
    xor r13, r13
    
    ; muliplicar 10xr12
    mov rax, r12
    mov rbx, 10
    mul rbx 
    mov r12, rax 

    ;pasar numero de ascii a numérico y sumar en r12
    xor rax, rax
    mov al, byte [chr]
    sub rax, 0x30
    add r12, rax

    jmp leercaracter

saltolinea:
    cmp r13, 0
    jne sumarcomprobar 
    mov r13, 1
    add r11, r12
    jmp leerlinea

sumarcomprobar:
    cmp r10, r11
    jae leerelfo
    mov r10, r11
    jmp leerelfo

finalaux:
    add r11, r12
    cmp r10, r11
    jae final
    mov r10, r11
    jmp final

final:
    mov byte[cadena+51], NULL
    mov byte[cadena+50], LF
    ; puntero cadena
    mov r11, 49
guardarcaracter:
    mov rax, r10
    cqo
    mov rbx, 10
    div rbx
    add rdx, 0x30
    mov byte[cadena+r11], dl

    cmp rax, 0
    je imprimir

    mov r10, rax
    dec r11
    jmp guardarcaracter

imprimir:
    mov rax, SYS_write ; system code for write()
    mov rdi, STDOUT ; standard out
    lea rsi, byte[cadena+r11] 
    inc r11
    push r11
    mov rdx, 1
    syscall
    pop r11

    cmp r11, 51
    jne imprimir

    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall

