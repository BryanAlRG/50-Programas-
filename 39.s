.global decimal_to_binary
.type decimal_to_binary, %function

decimal_to_binary:
    // x0 = número decimal
    // x1 = dirección buffer resultado
    mov x2, x0              // Copiar número
    mov x3, #0              // Contador de bits
    mov x4, #63             // Posición en buffer (empezar del final)
    
convert_loop:
    and x5, x2, #1          // Obtener último bit
    add x5, x5, #'0'        // Convertir a ASCII
    strb w5, [x1, x4]       // Guardar en buffer
    
    lsr x2, x2, #1          // Desplazar número
    sub x4, x4, #1          // Mover posición
    add x3, x3, #1          // Incrementar contador
    
    cbnz x2, convert_loop   // Si quedan bits, continuar
    
    // Mover resultado al inicio del buffer
    add x4, x4, #1          // Ajustar posición
    mov x5, #0              // Índice destino
    
move_loop:
    ldrb w6, [x1, x4]       // Cargar bit
    strb w6, [x1, x5]       // Mover al inicio
    
    add x4, x4, #1
    add x5, x5, #1
    cmp x3, x5
    bne move_loop
    
    // Añadir null terminator
    mov x6, #0
    strb w6, [x1, x5]
    
    mov x0, x3              // Retornar longitud
    ret
