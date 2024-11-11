.global find_max
.type find_max, %function

find_max:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    ldr x2, [x0]        // Primer elemento como máximo
    mov x3, #1          // Índice inicial
    
max_loop:
    cmp x3, x1          // Comparar con tamaño
    bge max_done        // Si terminamos, salir
    
    ldr x4, [x0, x3, lsl #3]  // Cargar siguiente elemento
    cmp x4, x2          // Comparar con máximo actual
    csel x2, x4, x2, gt // Actualizar máximo si es mayor
    
    add x3, x3, #1      // Incrementar índice
    b max_loop
    
max_done:
    mov x0, x2          // Retornar máximo
    ret
