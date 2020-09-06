    .data
woord:    .asciz "Hello World"

    .cpu cortex-m0
    .text
    .align 2
    .global print_asciz
    .global application

application: 
    push { lr }
    ldr r0, =woord
    bl print_asciz
    pop { pc }

print_asciz:
    push { r5, lr }
    mov r5, r0
loop:
    ldrb r0, [r5]
    add r0, r0, #0
    beq done 
    bl uart_put_char
    add r5, r5, #1
    b loop
done: 
    pop { r5, pc }


