
    .data
woord:    .asciz "Hello world, the ANSWER is 42! @[]`{}~\n"

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
    bl toggle_case_asm
    bl uart_put_char
    add r5, r5, #1
    b loop
done: 
    pop { r5, pc }

toggle_case_asm:
    push {lr}
    ldr r1, =0x5f
    and r1, r0, r1
    cmp r1, #0x40
    ble end
    cmp r1, #0x5A
    bge end
    ldr r1, =0x20
    eor r0, r1
end:
    pop {pc}