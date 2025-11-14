.intel_syntax noprefix # allow mov rax, 1 syntax in GAS (GNU Assembly)
.global _start

# factorial
# - rdi as input number
# - rax as result
factorial:
    push rbp
    mov rbp, rsp

    cmp rdi, 1
    jle base_case      # if n <= 1 return 1

    push rdi           # save n
    dec rdi            # rdi = n-1
    call factorial     # rax = factorial(n-1)

    pop rdx            # rdx = original n
    imul rax, rdx      # rax = factorial(n-1) * n
    jmp done

base_case:
    mov rax, 1

done:
    mov rsp, rbp
    pop rbp
    ret

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

    add rsp, 16
    ret

_start:
    mov rdi, 5 # Use 5 for our example input
    mov rax, 1 # Set starting result to 1

    call factorial

    call print_rax_digit

    mov rax, 60 # syscall exit - 64 bit
    mov rdi, 0  # exit code
    syscall
