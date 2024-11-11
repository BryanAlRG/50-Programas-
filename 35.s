.global array_rotate
.type array_rotate, %function

array_rotate:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    // x2 = posiciones a rotar (positivo = derecha, negativo = izquierda)
    stp x29, x30, [sp, #-16]!
    
    // Normalizar rotación
    cmp x2, #0
    bge normalize_right
    
    // Rotación izquierda
    neg x2, x2             // Hacer positivo
    b normalize_done
    
normalize_right:
    // Rotación derecha
    sub x2, x1, x2         // Convertir a rotación izquierda equivalente
    
normalize_done:
    // Asegurar que rotación esté en rango
    udiv x3, x2, x1
    msub x2, x3, x1, x2    // x2 = x2 % tamaño
    
    // Realizar rotación
    // 1. Revertir todo el arreglo
    mov x3, #0             // inicio
    sub x4, x1, #1         // fin
    bl reverse_section
    
    // 2. Revertir primera parte
    mov x3, #0
    sub x4, x2, #1
    bl reverse_section
    
    // 3. Revertir segunda parte
    mov x3, x2
    sub x4, x1, #1
    bl reverse_section
    
    ldp x29, x30, [sp], #16
    ret

// Función auxiliar para revertir sección
reverse_section:
    cmp x3, x4
    bge rev_done
    
    ldr x5, [x0, x3, lsl #3]
    ldr x6, [x0, x4, lsl #3]
    str x6, [x0, x3, lsl #3]
    str x5, [x0, x4, lsl #3]
    
    add x3, x3, #1
    sub x4, x4, #1
    b reverse_section
    
rev_done:
    ret
