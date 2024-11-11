.global matrix_add
.type matrix_add, %function

matrix_add:
    // x0 = matriz A
    // x1 = matriz B
    // x2 = matriz resultado
    // x3 = filas
    // x4 = columnas
    mov x5, #0              // Contador de filas
    mul x6, x3, x4         // Total de elementos
    
loop:
    cmp x5, x6             // Comparar con total
    bge done               // Si terminamos, salir
    
    // Cargar elementos
    ldr x7, [x0, x5, lsl #3]
    ldr x8, [x1, x5, lsl #3]
    
    // Sumar y guardar
    add x9, x7, x8
    str x9, [x2, x5, lsl #3]
    
    add x5, x5, #1         // Siguiente elemento
    b loop
    
done:
    ret
