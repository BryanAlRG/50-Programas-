.global count_set_bits
.type count_set_bits, %function

count_set_bits:
    // x0 = número a analizar
    mov x1, #0              // Contador de bits
    
count_loop:
    cbz x0, done           // Si no quedan bits, terminar
    
    // Verificar último bit
    and x2, x0, #1
    add x1, x1, x2         // Incrementar contador si es 1
    
    lsr x0, x0, #1         // Desplazar a la derecha
    b count_loop
    
done:
    mov x0, x1             // Retornar cantidad de bits
    ret
