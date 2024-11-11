#RODRIGUEZ GOMEZ BRYAN ALEJANDRO

~~~
.data
    prompt:     .string "Ingrese una cadena (máx 100 caracteres): "
    resultado:  .string "Cadena invertida: %s\n"
    buffer:     .skip 101       // 100 caracteres + null terminator
    formato:    .string "%100s"

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

    // Leer cadena
    adrp    x1, buffer
    add     x1, x1, :lo12:buffer
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf

    // Calcular longitud de la cadena
    adrp    x0, buffer
    add     x0, x0, :lo12:buffer
    bl      strlen              // resultado en x0
    mov     x19, x0             // guardar longitud en x19

    // Preparar punteros para invertir
    adrp    x20, buffer
    add     x20, x20, :lo12:buffer    // inicio de la cadena
    sub     x21, x19, #1             // índice final (longitud - 1)
    add     x21, x20, x21            // puntero al último carácter

invertir_loop:
    cmp     x20, x21
    b.ge    mostrar_resultado    // Si inicio >= final, terminar

    // Intercambiar caracteres
    ldrb    w22, [x20]          // cargar carácter del inicio
    ldrb    w23, [x21]          // cargar carácter del final
    strb    w23, [x20]          // guardar carácter del final al inicio
    strb    w22, [x21]          // guardar carácter del inicio al final

    // Mover punteros
    add     x20, x20, #1        // inicio++
    sub     x21, x21, #1        // final--
    b       invertir_loop

mostrar_resultado:
    adrp    x1, buffer
    add     x1, x1, :lo12:buffer
    adrp    x0, resultado
    add     x0, x0, :lo12:resultado
    bl      printf

    // Limpiar y salir
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret
