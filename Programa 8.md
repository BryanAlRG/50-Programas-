

~~~
.data
    prompt:     .string "Ingrese cantidad de términos de Fibonacci: "
    formato:    .string "%d"
    numero:     .string "%d "    // Para imprimir cada número
    newline:    .string "\n"
    error:      .string "Error: El número debe ser positivo\n"

.text
.global main
.align 4

main:
    // Guardar registros
    stp     x29, x30, [sp, #-16]!

    // Mostrar prompt
    adrp    x0, prompt
    add     x0, x0, :lo12:prompt
    bl      printf

    // Leer cantidad
    sub     sp, sp, #16
    mov     x1, sp
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf
    ldr     w19, [sp]           // Guardar n en w19

    // Verificar si es positivo
    cmp     w19, #0
    b.le    error_negativo

    // Inicializar primeros números
    mov     w20, #0             // a = 0
    mov     w21, #1             // b = 1
    mov     w22, #0             // contador = 0

    // Imprimir primer número si n > 0
    cmp     w19, #0
    b.le    fin
    mov     w1, w20
    adrp    x0, numero
    add     x0, x0, :lo12:numero
    bl      printf
    add     w22, w22, #1        // contador++

    // Imprimir segundo número si n > 1
    cmp     w19, #1
    b.le    newline_print
    mov     w1, w21
    adrp    x0, numero
    add     x0, x0, :lo12:numero
    bl      printf
    add     w22, w22, #1        // contador++

fibonacci_loop:
    cmp     w22, w19
    b.ge    newline_print       // Si contador >= n, terminar
    
    // Calcular siguiente número
    add     w23, w20, w21       // temp = a + b
    mov     w20, w21            // a = b
    mov     w21, w23            // b = temp
    
    // Imprimir número
    mov     w1, w23
    adrp    x0, numero
    add     x0, x0, :lo12:numero
    bl      printf
    
    add     w22, w22, #1        // contador++
    b       fibonacci_loop

newline_print:
    adrp    x0, newline
    add     x0, x0, :lo12:newline
    bl      printf
    b       fin

error_negativo:
    adrp    x0, error
    add     x0, x0, :lo12:error
    bl      printf

fin:
    // Limpiar y salir
    add     sp, sp, #16
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret
