.global ascii_to_int
.type ascii_to_int, %function

ascii_to_int:
    // x0 = dirección de la cadena ASCII
    mov x1, #0              // Resultado
    mov x2, #0              // Índice
    mov x3, #10             // Base 10
    
    // Verificar signo
    ldrb w4, [x0]
    cmp w4, #'-'
    bne convert_loop
    add x0, x0, #1         // Saltar el signo negativo
    mov x5, #1             // Flag para número negativo
    
convert_loop:
    ldrb w4, [x0, x2]      // Cargar siguiente dígito
    cbz w4, done           // Si es 0, terminamos
    
    sub w4, w4, #'0'       // Convertir ASCII a número
    
    // Multiplicar resultado actual por 10
    mul x1, x1, x3
    add x1, x1, x4         // Añadir nuevo dígito
    
    add x2, x2, #1         // Siguiente posición
    b convert_loop
    
done:
    // Aplicar signo si es necesario
    cbz x5, positive
    neg x1, x1
    
positive:
    mov x0, x1             // Retornar resultado
    ret
