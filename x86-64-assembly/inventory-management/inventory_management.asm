section .rodata
WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

; You should implement functions in the .text section
; A skeleton is provided for the first function

; the global directive makes a function visible to the test files
global get_box_weight
get_box_weight:
    ; This function takes the following parameters:
    ; - The number of items for the first product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the first product, in grams, as a 16-bit non-negative integer
    ; - The number of items for the second product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the second product, in grams, as a 16-bit non-negative integer
    ; The function must return the total weight of a box, in grams, as a 32-bit non-negative integer
    movzx eax, di
    movzx esi, si
    imul eax, esi
    movzx edx, dx
    movzx ecx, cx
    imul ecx, edx
    add rax, rcx
    add rax, WEIGHT_OF_EMPTY_BOX
    mov eax, eax 

    ret

global max_number_of_boxes
max_number_of_boxes:
    ; TODO: define the 'max_number_of_boxes' function
    ; this function takes the following parameter:
    ; - the height of the box, in centimeters, as a 8-bit non-negative integer
    ; the function must return how many boxes can be stacked vertically, as a 8-bit non-negative integer
    xor rax, rax
    cmp dil, 0
    je .end
    mov rax, TRUCK_HEIGHT
    movzx ecx, dil
    div cl
.end:
    movzx eax, al
    ret

global items_to_be_moved
items_to_be_moved:
    ; TODO: define the 'items_to_be_moved' function
    ; This function takes the following parameters:
    ; - The number of items still unaccounted for a product, as a 32-bit non-negative integer
    ; - The number of items for the product in a box, as a 32-bit non-negative integer
    ; The function must return how many items remain to be moved, after counting those in the box, as a 32-bit integer
    mov eax, edi
    mov esi, esi
    sub rax, rsi
    ret

global calculate_payment
calculate_payment:
    ; TODO: define the 'calculate_payment' function
    ; This function takes the following parameters:
    ; - The upfront payment, as a 64-bit non-negative integer (rdi)
    ; - The total number of boxes moved, as a 32-bit non-negative integer (rsi)
    ; - The number of truck trips made, as a 32-bit non-negative integer (rdx)
    ; - The number of lost items, as a 32-bit non-negative integer (rcx)
    ; - The value of each lost item, as a 64-bit non-negative integer (r8)
    ; - The number of other workers to split the payment/debt with you, as a 8-bit positive integer (r9)
    ; The function must return how much you should be paid, or pay, at the end, as a 64-bit integer (possibly negative)
    ; Remember that you get your share and also the remainder of the division
    xor rax, rax ; Zero RAX
    sub rax, rdi ; Substact upfront payment (forcing RAX to account for front-loaded payment)
    mov esi, esi ; Sanitize the upper 32 bits of RSI
    imul rsi, PAY_PER_BOX ; Calculate rate for box quantity
    add rax, rsi ; Add total shipping cost for parcels to payment
    mov edx, edx ; Sanitize the upper 32 bits of RDX
    imul rdx, PAY_PER_TRUCK_TRIP ; Calculate per
    add rax, rdx ; Add trips payment to total
    mov ecx, ecx ; Sanitize the upper 32 bits of rcx
    imul rcx, r8 ; Multiply the cost of lost items by the number of lost items
    sub rax, rcx
    movzx r9w, r9b ; Sanitize the upper 56 bits of r9
    sub rdx, rdx
    inc r9 ; Account for me.
    cqo
    idiv r9 ; Calculate my share of payment
    add rax, rdx ; Add the remainder to my payment.
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
