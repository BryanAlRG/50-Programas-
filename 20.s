.global matrix_multiply
.type matrix_multiply, %function

matrix_multiply:
    // x0 = matriz A
    // x1 = matriz B
    // x2 = matriz resultado
    // x3 = filas A
    // x4 = columnas A/filas B
    // x5 = columnas B
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x6, #0              // i (filas)
outer_loop:
    cmp x6, x3
    bge mult_done
    
    mov x7, #0              // j (columnas)
middle_loop:
    cmp x7, x5
    bge next_i
    
    mov x8, #0              // k (suma)
    mov x9, #0              // acumulador
    
inner_loop:
    cmp x8, x4
    bge store_result
    
    // Calcular índices
    mul x10, x6, x4         // i * colsA
    add x10, x10, x8        // + k
    lsl x10, x10, #3        // * 8 (bytes)
    ldr x11, [x0, x10]      // A[i][k]
    
    mul x10, x8, x5         // k * colsB
    add x10, x10, x7        // + j
    lsl x10, x10, #3        // * 8 (bytes)
    ldr x12, [x1, x10]      // B[k][j]
    
    mul x13, x11, x12       // A[i][k] * B[k][j]
    add x9, x9, x13         // Acumular
    
    add x8, x8, #1
    b inner_loop
    
store_result:
    mul x10, x6, x5         // i * colsB
    add x10, x10, x7        // + j
    lsl x10, x10, #3        // * 8 (bytes)
    str x9, [x2, x10]       // C[i][j] = acumulador
    
    add x7, x7, #1
    b middle_loop
    
next_i:
    add x6, x6, #1
    b outer_loop
    
mult_done:
    ldp x29, x30, [sp], #16
    ret
