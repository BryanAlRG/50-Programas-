.global strlen
.type strlen, %function

strlen:
    // x0 = dirección de la cadena
    mov x1, x0              // Copiar dirección inicial
    
count_loop:
    ldrb w2, [x1], #1      // Cargar byte y avanzar
    cbnz w2, count_loop    // Si no es 0, continuar
    
    sub x0, x1, x0         // Calcular diferencia
    sub x0, x0, #1         // Ajustar por null terminator
    ret
