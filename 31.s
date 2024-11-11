.global lcm
.type lcm, %function

lcm:
    // x0 = primer número (a)
    // x1 = segundo número (b)
    stp x29, x30, [sp, #-16]!   // Guardar registros
    stp x0, x1, [sp, #-16]!     // Guardar números originales
    
    // Primero calculamos el GCD
    bl gcd                      // Llamar a función GCD
    
    // Restaurar números originales
    ldp x2, x3, [sp], #16
    
    // LCM = (a * b) / GCD
    mul x1, x2, x3              // a * b
    udiv x0, x1, x0             // (a * b) / GCD
    
    ldp x29, x30, [sp], #16     // Restaurar registros
    ret

// Función auxiliar GCD (necesaria para LCM)
gcd:
    cbz x1, gcd_done
    udiv x2, x0, x1
    msub x2, x1, x2, x0
    mov x0, x1
    mov x1, x2
    b gcd
gcd_done:
    ret
