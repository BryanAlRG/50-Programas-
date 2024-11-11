.global array_sum
.type array_sum, %function

array_sum:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    mov x2, #0              // Suma
    mov x3, #0              // Índice
    
sum_loop:
    cmp x3, x1
    bge done
    
    ldr x4, [x0, x3, lsl #3]  // Cargar elemento
    add x2, x2, x4            // Añadir a suma
    
    add x3, x3, #1
    b sum_loop
    
done:
    mov x0, x2                // Retornar suma
    ret
