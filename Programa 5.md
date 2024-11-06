

~~~~
.data
    prompt1:    .string "Ingrese dividendo: "
    prompt2:    .string "Ingrese divisor: "
    resultado:  .string "La división es: %d\n"
    error_div:  .string "Error: División por cero\n"
    formato:    .string "%d"

.text
.global main
.align 4

main:
    // Guardar registros
    stp     x29, x30, [sp, #-16]!

    // Mostrar primer prompt
    adrp    x0, prompt1
    add     x0, x0, :lo12:prompt1
    bl      printf

    // Leer primer número
    sub     sp, sp, #16
    mov     x1, sp
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf
    ldr     w19, [sp]           // Guardar dividendo en w19

    // Mostrar segundo prompt
    adrp    x0, prompt2
    add     x0, x0, :lo12:prompt2
    bl      printf

    // Leer segundo número
    mov     x1, sp
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf
    ldr     w20, [sp]           // Guardar divisor en w20

    // Verificar división por cero
    cmp     w20, #0
    b.eq    division_cero

    // Realizar división
    sdiv    w1, w19, w20        // w1 = w19 / w20

    // Mostrar resultado
    adrp    x0, resultado
    add     x0, x0, :lo12:resultado
    bl      printf
    b       fin

division_cero:
    // Mostrar mensaje de error
    adrp    x0, error_div
    add     x0, x0, :lo12:error_div
    bl      printf

fin:
    // Limpiar y salir
    add     sp, sp, #16
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret
~~~
