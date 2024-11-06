
~~~~
.data
    prompt:     .string "Ingrese un número para verificar si es primo: "
    es_primo:   .string "El número %d es primo\n"
    no_primo:   .string "El número %d no es primo\n"
    error:      .string "Error: El número debe ser mayor que 1\n"
    formato:    .string "%d"

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

    // Leer número
    sub     sp, sp, #16
    mov     x1, sp
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf
    ldr     w19, [sp]           // Guardar número en w19

    // Verificar si es menor o igual a 1
    cmp     w19, #1
    b.le    error_numero

    // Inicializar divisor
    mov     w20, #2             // divisor = 2

verificar_loop:
    // Si divisor * divisor > número, es primo
    mul     w21, w20, w20       // w21 = divisor * divisor
    cmp     w21, w19
    b.gt    es_numero_primo

    // Verificar si es divisible
    sdiv    w21, w19, w20       // w21 = número / divisor
    mul     w21, w21, w20       // w21 = (número / divisor) * divisor
    cmp     w21, w19            // Comparar con número original
    b.eq    no_es_primo        // Si son iguales, encontramos un divisor

    add     w20, w20, #1        // divisor++
    b       verificar_loop

es_numero_primo:
    mov     w1, w19
    adrp    x0, es_primo
    add     x0, x0, :lo12:es_primo
    bl      printf
    b       fin

no_es_primo:
    mov     w1, w19
    adrp    x0, no_primo
    add     x0, x0, :lo12:no_primo
    bl      printf
    b       fin

error_numero:
    adrp    x0, error
    add     x0, x0, :lo12:error
    bl      printf

fin:
    // Limpiar y salir
    add     sp, sp, #16
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret
