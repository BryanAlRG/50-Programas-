.global gcd
.type gcd, %function

gcd:
    // x0 = primer número
    // x1 = segundo número
    // Implementación del algoritmo de Euclides
    cbz x1, done           // Si b es 0, retornar a
    
    udiv x2, x0, x1        // a / b
    msub x2, x1, x2, x0    // a % b = a - (a/b)*b
    
    mov x0, x1             // a = b
    mov x1, x2             // b = a % b
    b gcd                  // Llamada recursiva
    
done:
    ret
