.global _start
.section .text

_start:
    // Ejemplo con dos cadenas
    adr x0, string1
    adr x1, string2
    bl find_prefix
    mov x8, #93
    svc #0

find_prefix:
    // x0, x1 contienen direcciones de las cadenas
    mov x2, #0          // Índice actual
    
compare_loop:
    ldrb w3, [x0, x2]   // Cargar byte de primera cadena
    ldrb w4, [x1, x2]   // Cargar byte de segunda cadena
    
    // Verificar fin de cadena o diferencia
    cbz w3, end_prefix
    cbz w4, end_prefix
    cmp w3, w4
    bne end_prefix
    
    add x2, x2, #1      // Incrementar índice
    b compare_loop
    
end_prefix:
    mov x0, x2          // Retornar longitud del prefijo
    ret

.section .data
    string1: .asciz "flower"
    string2: .asciz "flow"
    result: .quad 0
