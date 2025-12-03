# Since we use GNU Assembler, the AT&T Syntax is used
# to make it more familiar, we have added the following
# to allow the use of the Intel syntax
.intel_syntax noprefix # allow mov rax, 1 syntax in GAS (GNU Assembly)

.global _start # Define the entry point to the assembly, where to start executing

# factorial
# - rdi (n) as input number
# - rax (r) as result
factorial:
    cmp rdi, 1         # compare n to 1
    jle done           # if n <= 1 return (r = 1)

    push rdi           # save n
    dec rdi            # rdi = n - 1
    call factorial     # rax = factorial(n - 1)

    pop rdx            # rdx = original n
    imul rax, rdx      # rax = factorial(n - 1) * n
    jmp done

# done is used to return
# from the factorial
done:
    ret

# prints number as decimal
# from rax register
# just to demo, don't explain
print_rax_digit:
    sub rsp, 16
    mov rbx, 10

    # ones digit
    xor rdx, rdx
    mov rcx, rax
    div rbx
    add dl, '0'
    mov [rsp+2], dl

    # tens digit
    xor rdx, rdx
    mov rcx, rax
    div rbx
    add dl, '0'
    mov [rsp+1], dl

    # hundreds digit
    add al, '0'
    mov [rsp], al

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 3
    syscall

    # print newline
    mov rax, 1            # write syscall
    mov rdi, 1            # stdout
    lea rsi, [rip+nl]     # pointer to newline
    mov rdx, 1            # length = 1
    syscall

    add rsp, 16
    ret

# new line character
nl:
    .byte 0x0A            # '\n'

# where the program starts executing
_start:
    mov rdi, 5 # Use 5 for our example input
    mov rax, 1 # Set starting result to 1

    call factorial       # initial factorial call
    call print_rax_digit # print result to prove it works

    mov rax, 60 # syscall exit - 64 bit
    mov rdi, 0  # exit code
    syscall
