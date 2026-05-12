; Everything that comes after a semicolon (;) is a comment

; Assembler-time constants may be defined using 'equ'
COOK_TIME equ 40

section .text

; You should implement functions in the .text section

; the global directive makes a function visible to the test files
global expected_minutes_in_oven
expected_minutes_in_oven:
    mov rax, COOK_TIME
    ret

global remaining_minutes_in_oven
remaining_minutes_in_oven:
    call expected_minutes_in_oven ; obtain the overall cook time
    sub rax, rdi ; deduct the time our lasagna has been in the oven
    ret

global preparation_time_in_minutes
preparation_time_in_minutes:
    SHL rdi, 1 ; A left-shift by 1 is the equivalent of a multiplication by 2, and is more computationally efficient.
    mov rax, rdi ; Assign the new value to the return register
    ret

global elapsed_time_in_minutes
elapsed_time_in_minutes:
    call preparation_time_in_minutes ; Retrieve the preparation time, reuising the layers argument "rdi"
    add rax, rsi ; Add the time our lasanga has been in the oven 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
