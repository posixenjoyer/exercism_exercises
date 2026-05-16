; Everything that comes after a semicolon (;) is a comment

; Define the constants 'RED', 'GREEN' and 'BLUE'
; They must be accessible from other source files

; Define the variable 'base_color' with the default value of 0xFFFFFF00
; It must be accessible from other source files

section .rodata

global RED
RED dd 0xFF000000
global GREEN
GREEN dd 0x00FF0000
global BLUE
BLUE dd 0x0000FF00
extern combining_function ; dependencies. dependencies. dependencies. dependencies.

section .data

global base_color
base_color dd 0xFFFFFF00 ; Whitey McWhiteface

section .text

; You should implement functions in the .text section

; the global directive makes a function visible to the test files
global get_color_value
get_color_value:
    mov rax, qword [rdi]  ; If this needs a comment, pick 1) up a book 2) a new hobby
    ret

global add_base_color
add_base_color:
    mov eax, dword [ rdi ]            ; Argument one is the new base color's address, move the color value to the lower half of rax. 
    mov dword [ rel base_color ], eax ; Move the *value* of the new base color to base_color's address
    ret

global make_color_combination
make_color_combination:
    push rdi                            ; Argument one is the end location of the new color.  Save rsi, combining_function can clobber it.
    mov edi, dword [ rel base_color ]   ; Retrieve the value of base_color
    mov esi, dword [ rsi ]              ; Argument two of the original function is the address of the color to combine.
    call combining_function
    pop rdi                             ; Restore destination address
    mov dword [ rdi ], eax              ; Store the resulting combined color in the provided address.
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
