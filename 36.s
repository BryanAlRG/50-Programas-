.global second_largest
.type second_largest, %function

second_largest:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    cmp x1, #2
    blt no_second          // Si tamaño < 2, no hay segundo
    
    ldr x2, [x0]          // Primer elemento como máximo
    ldr x3, [x0, #8]      // Segundo elemento como segundo máximo
    
    // Ajustar máximo y segundo máximo iniciales
    cmp x2, x3
    bge max_ok
    
    // Intercambiar si están en orden incorrecto
    mov x4, x2
    mov x2, x3
    mov x3, x4
    
max_ok:
    mov x4, #2            // Índice inicial
    
find_loop:
    cmp x4, x1
    bge done
    
    ldr x5, [x0, x4, lsl #3]
    
    // Comparar con máximo actual
    cmp x5, x2
    bgt update_max
    cmp x5, x3
    bgt update_second
    b next
    
update_max:
    mov x3, x2            // Antiguo máximo pasa a segundo
    mov x2, x5            // Nuevo máximo
    b next
    
update_second:
    mov x3, x5            // Actualizar segundo máximo
    
next:
    add x4, x4, #1
    b find_loop
    
done:
    mov x0, x3            // Retornar segundo máximo
    ret
    
no_second:
    mov x0, #-1           // Indicar error
    ret
