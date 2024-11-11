.global _start
.section .text

_start:
    // Leer entrada del teclado
    mov x0, #0          // stdin
    adr x1, buffer      // buffer para entrada
    mov x2, #100        // tamaño máximo a leer
    mov x8, #63         // syscall read
    svc #0
    
    // Salir
    mov x8, #93
    svc #0

.section .data
    buffer: .skip 100   // Buffer para almacenar entrada
    .align 4
