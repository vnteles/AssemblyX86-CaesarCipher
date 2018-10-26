segment .rodata
    help db 0xa,'USAGE:', 0xa, './caesar "[ MESSAGE ]" [ ROT_NUMBER ]', 0xa
    lhelp equ $ - help

    break db 0xa
    lbreak equ $ - break

segment .bss
    cript resb 0x400
    rot_value resb 0x04

section .text

    global _start:
_start:
    cmp byte [esp], 0x01
    je _usage
    
    ; get size of the string
    mov eax, [esp+0x12]
    ;sub eax, '0'
    mov [rot_value], eax

    mov eax, [esp+0x08]     ; get the string
    ;mov edx, [esp+0x12]     ; get the rot value


    ;mov eax, edx

    call _getsize

    ;encript msg
    mov esi, ebx        ; mov to esi the len of the string
    xor ebx, ebx        ; clear ebx
    call _encript

    jmp end


_getsize:
    cmp byte [eax+ebx], 0x00
    jne _lgs
    ret

    _lgs:
        inc ebx
        jmp _getsize

_encript:
    cmp ebx, esi
    jne _lenc
    inc ebx
    mov byte[cript+ebx], 0x00

    push esi
    push cript

    call _print

    push lbreak
    push break
    call _print

    jmp end

    _lenc:
        mov cl, [eax+ebx]
        ;sub edx, '0'
        add cl, [rot_value]
        mov [cript+ebx], ecx
        inc ebx
        jmp _encript



_usage:
    push lhelp
    push help

    call _print

    jmp end


_print:
    mov edx, [esp+0x08]
    mov ecx, [esp+0x04]
    mov ebx, 0x01
    mov eax, 0x04

    int 0x80

    ret


end:
    mov eax, 0x01
    xor ebx, ebx
    int 0x80