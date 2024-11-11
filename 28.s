.global bit_manipulation
.type bit_manipulation, %function

bit_manipulation:
    // x0 = número original
    // x1 = posición del bit
    // Retorna: x0 = bit establecido, x1 = bit borrado, x2 = bit alternado
    mov x3, x0             // Guardar número original
    mov x4, #1             // Máscara base
    lsl x4, x4, x1         // Desplazar máscara a posición
    
    // Establecer bit
    orr x0, x3, x4
    
    // Borrar bit
    mvn x5, x4             // Invertir máscara
    and x1, x3, x5
    
    // Alternar bit
    eor x2, x3, x4
    
    ret
