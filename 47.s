.global _start
.section .text

_start:
    // Ejemplo: sumar dos números y detectar desbordamiento
    mov x0, #0x7FFFFFFFFFFFFFFF  // Máximo número positivo en 64 bits
    mov x1, #1                   // Sumar 1 causará desbordamiento
    bl add_with_overflow
    mov x8, #93
    svc #0

add_with_overflow:
    // x0, x1 contienen números a sumar
    // x0 contendrá resultado, x1 contendrá flag de desbordamiento
    
    adds x0, x0, x1     // Suma con actualización de flags
    cset x1, vs         // x1 = 1 si hubo desbordamiento, 0 si no
    ret

.section .data
    result: .quad 0
    overflow_flag: .byte 0
