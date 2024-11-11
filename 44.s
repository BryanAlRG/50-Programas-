.global _start
.section .text

_start:
    // Usar timestamp como semilla inicial
    mrs x0, CNTPCT_EL0  // Leer contador de tiempo
    bl random_generator
    mov x8, #93         // Syscall exit
    svc #0

random_generator:
    // Implementación del algoritmo linear congruential generator (LCG)
    // Fórmula: next = (a * seed + c) mod m
    // Usando valores comunes: a = 1664525, c = 1013904223, m = 2^32
    
    // Guardar semilla inicial
    mov x1, #1664525        // multiplicador (a)
    mov x2, #1013904223     // incremento (c)
    
    // Calcular siguiente número
    mul x0, x0, x1          // x0 = seed * a
    add x0, x0, x2          // x0 = (seed * a) + c
    
    // No necesitamos hacer mod 2^32 explícitamente ya que
    // los registros de 32 bits hacen esto automáticamente
    
    ret

.section .data
    seed: .quad 0
    result: .quad 0
