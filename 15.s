.global binary_search
.type binary_search, %function

binary_search:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    // x2 = valor a buscar
    mov x3, #0          // Inicio
    sub x4, x1, #1      // Fin
    
search_loop:
    cmp x3, x4          // Comparar inicio y fin
    bgt not_found       // Si inicio > fin, no encontrado
    
    // Calcular punto medio: mid = (left + right) / 2
    add x5, x3, x4      // Suma de índices
    lsr x5, x5, #1      // División por 2
    
    // Cargar elemento del medio
    ldr x6, [x0, x5, lsl #3]
    
    // Comparar con valor buscado
    cmp x6, x2
    beq found           // Si es igual, encontrado
    blt greater         // Si es menor, buscar en mitad superior
    
    // Si es mayor, buscar en mitad inferior
    sub x4, x5, #1      // right = mid - 1
    b search_loop
    
greater:
    add x3, x5, #1      // left = mid + 1
    b search_loop
    
found:
    mov x0, x5          // Retornar índice
    ret
    
not_found:
    mov x0, #-1         // Retornar -1
    ret
