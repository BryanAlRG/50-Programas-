.global merge_sort
.type merge_sort, %function

merge_sort:
    // x0 = dirección del arreglo
    // x1 = inicio
    // x2 = fin
    stp x29, x30, [sp, #-16]!   // Guardar registros
    mov x29, sp
    
    sub x3, x2, x1              // Calcular longitud
    cmp x3, #1                  // Si longitud <= 1, retornar
    ble merge_sort_done
    
    // Calcular punto medio
    add x3, x1, x2
    lsr x3, x3, #1              // mid = (start + end) / 2
    
    // Guardar registros para llamada recursiva
    stp x0, x1, [sp, #-16]!
    stp x2, x3, [sp, #-16]!
    
    // Llamada recursiva para primera mitad
    mov x2, x3
    bl merge_sort
    
    // Restaurar registros y preparar segunda llamada
    ldp x2, x3, [sp], #16
    ldp x0, x1, [sp], #16
    
    // Segunda llamada recursiva
    add x1, x3, #1
    bl merge_sort
    
    // Merge
    bl merge

merge_sort_done:
    ldp x29, x30, [sp], #16
    ret

// Subrutina merge
merge:
    // Implementación del merge...
    // (Por brevedad, esta parte está simplificada)
    ret
