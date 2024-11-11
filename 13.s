.global find_min
.type find_min, %function

find_min:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    ldr x2, [x0]        // Primer elemento como mínimo
    mov x3, #1          // Índice inicial
    
min_loop:
    cmp x3, x1          // Comparar con tamaño
    bge min_done        // Si terminamos, salir
    
    ldr x4, [x0, x3, lsl #3]  // Cargar siguiente elemento
    cmp x4, x2          // Comparar con mínimo actual
    csel x2, x4, x2, lt // Actualizar mínimo si es menor
    
    add x3, x3, #1      // Incrementar índice
    b min_loop
    
min_done:
    mov x0, x2          // Retornar mínimo
    ret
