.global bit_operations
.type bit_operations, %function

bit_operations:
    // x0 = primer número
    // x1 = segundo número
    // Retorna: x0 = AND, x1 = OR, x2 = XOR
    mov x3, x0             // Guardar primer número
    mov x4, x1             // Guardar segundo número
    
    // Realizar operaciones
    and x0, x3, x4         // AND
    orr x1, x3, x4         // OR
    eor x2, x3, x4         // XOR
    
    ret
