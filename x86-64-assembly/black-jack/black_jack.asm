; Everything that comes after a semicolon (;) is a comment

C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

FACE_CARD equ 10

TRUE equ 1
FALSE equ 0

section .text

; You should implement functions in the .text section

; the global directive makes a function visible to the test files
global value_of_card
value_of_card:
    cmp rdi, CA ; Organize conditionals to minimize jmps, check for ace.
    je  .ace
    
    cmp rdi, C10 ; Any card not a base card, or an ace, is a face card
    jg .face_card ; Jump to face card condition

    mov rax, rdi ; All base cards have face value
    ret
.ace:
    mov rax, 1 ; Ace returns 1
    ret
.face_card:
    mov rax, FACE_CARD ; All face cards have value 10
    ret

global higher_card
higher_card:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return which card has the higher value
    ; If both have the same value, both should be returned
    ; If one is higher, the second one should be 0
    push rdi
    push rsi
    sub rsp, 8
    call value_of_card
    mov r12, rax
    mov rdi, rsi
    call value_of_card
    add rsp, 8
    cmp r12, rax
    pop rsi
    pop rdi
    je .cards_are_equal
    jl .second_card_higher
    mov rdx, 0
    mov rax, rdi
    ret
.cards_are_equal:
    mov rax, rdi
    mov rdx, rsi
    ret
.second_card_higher:
    mov rdx, 0
    mov rax, rsi
    ret

global value_of_ace
value_of_ace:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return the value of an upcoming ace
    push rbx
    cmp rdi, CA
    je .return_low

    cmp rsi, CA
    je .return_low

    push rsi
    mov rax, rdi
    sub rsp, 8
    call value_of_card
    add rsp, 8
    mov rbx, rax
    pop rdi
    call value_of_card
    add rax, rbx
    cmp rax, 10
    jg .return_low

    pop rbx
    mov rax, 11
    ret
.return_low:
    pop rbx
    mov rax, 1
    ret

global is_blackjack
is_blackjack:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a blackjack, and FALSE otherwise
    push rdi
    push rsi
    mov rax, rdi
    mov rdx, rsi
    sub rsp, 8
    call higher_card
    add rsp, 8
    cmp rdx, 0
    pop rsi
    pop rdi
    jne .not_blackjack
    cmp rdi, C10
    jl .not_blackjack
    cmp rsi, C10
    jl .not_blackjack
    cmp rdi, CA
    je .blackjack
    sub rsp, 8
    call value_of_card
    add rsp, 8
    cmp rax, FACE_CARD
    je .blackjack
.not_blackjack:
    mov rax, FALSE
    ret
.blackjack:
    mov rax, TRUE
    ret

global can_split_pairs
can_split_pairs:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards can be split into two pairs, and FALSE otherwise
    sub rsp, 8
    call higher_card
    add rsp, 8
    cmp rdx, 0
    setnz al
    movzx rax, al
    ret


global can_double_down
can_double_down:
    ; this function takes as parameters two numbers each representing a card
    ; the function should return true if the two cards form a hand that can be doubled down, and false otherwise
    push rsi
    call value_of_card
    pop rdi
    push rbx
    mov rbx, rax
    call value_of_card
    add rbx, rax
    cmp rbx, 9
    setge al
    cmp rbx, 11
    setle cl
    and al, cl
    movzx rax, al
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
