#Rodriguez Gomez Bryan Alejandro 22210345
~~
.global is_palindrome
.type is_palindrome, %function

is_palindrome:
    // x0 contiene la dirección de la cadena
    mov x2, x0              // Guardar dirección inicial
    mov x3, #0             // Contador para longitud

    // Encontrar longitud de la cadena
length_loop:
    ldrb w4, [x2, x3]     // Cargar byte
    cbz w4, length_done   // Si es 0, terminar
    add x3, x3, #1       // Incrementar contador
    b length_loop

length_done:
    sub x3, x3, #1       // Ajustar longitud (excluir null)
    mov x1, #0           // Índice inicial
    
compare_loop:
    cmp x1, x3          // Comparar índices
    bge is_palindrome_true  // Si se cruzaron, es palíndromo
    
    ldrb w4, [x0, x1]   // Cargar byte del inicio
    ldrb w5, [x0, x3]   // Cargar byte del final
    
    cmp w4, w5          // Comparar caracteres
    bne is_palindrome_false
    
    add x1, x1, #1      // Incrementar índice inicial
    sub x3, x3, #1      // Decrementar índice final
    b compare_loop

is_palindrome_true:
    mov x0, #1
    ret

is_palindrome_false:
    mov x0, #0
    ret
