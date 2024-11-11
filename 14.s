.global linear_search
.type linear_search, %function

linear_search:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    // x2 = valor a buscar
    mov x3, #0          // Índice inicial
    
search_loop:
    cmp x3, x1          // Comparar con tamaño
    bge not_found       // Si terminamos, no se encontró
    
    ldr x4, [x0, x3, lsl #3]  // Cargar elemento
    cmp x4, x2          // Comparar con valor buscado
    beq found           // Si es igual, encontrado
    
    add x3, x3, #1      // Incrementar índice
    b search_loop
    
found:
    mov x0, x3          // Retornar índice
    ret
    
not_found:
    mov x0, #-1         // Retornar -1
    ret
