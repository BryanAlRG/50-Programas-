.global array_reverse
.type array_reverse, %function

array_reverse:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    mov x2, #0              // Índice inicial
    sub x3, x1, #1         // Índice final
    
reverse_loop:
    cmp x2, x3
    bge done
    
    // Cargar elementos
    ldr x4, [x0, x2, lsl #3]
    ldr x5, [x0, x3, lsl #3]
    
    // Intercambiar
    str x5, [x0, x2, lsl #3]
    str x4, [x0, x3, lsl #3]
    
    add x2, x2, #1
    sub x3, x3, #1
    b reverse_loop
    
done:
    ret
