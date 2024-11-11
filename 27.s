.global bit_shifts
.type bit_shifts, %function

bit_shifts:
    // x0 = número a desplazar
    // x1 = cantidad de posiciones
    // Retorna: x0 = desplazamiento izquierdo, x1 = derecho lógico, x2 = derecho aritmético
    mov x3, x0             // Guardar número original
    
    // Realizar desplazamientos
    lsl x0, x3, x1         // Desplazamiento izquierdo
    lsr x1, x3, x1         // Desplazamiento derecho lógico
    asr x2, x3, x1         // Desplazamiento derecho aritmético
    
    ret
