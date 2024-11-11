.global bubble_sort
.type bubble_sort, %function

bubble_sort:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    sub x1, x1, #1      // n-1 para el límite exterior
    mov x2, x1          // Contador exterior
    
outer_loop:
    cbz x2, done        // Si contador exterior es 0, terminamos
    mov x3, #0          // Índice para loop interno
    
inner_loop:
    cmp x3, x2          // Comparar con límite
    bge outer_done      // Si terminamos loop interno
    
    // Cargar elementos adyacentes
    ldr x4, [x0, x3, lsl #3]
    add x5, x3, #1
    ldr x6, [x0, x5, lsl #3]
    
    // Comparar y swap si necesario
    cmp x4, x6
    ble no_swap
    
    // Swap
    str x6, [x0, x3, lsl #3]
    str x4, [x0, x5, lsl #3]
    
no_swap:
    add x3, x3, #1      // Siguiente índice
    b inner_loop
    
outer_done:
    sub x2, x2, #1      // Decrementar contador exterior
    b outer_loop
    
done:
    ret
