# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Factorial de un número

~~~
.data
    prompt:     .string "Ingrese un número para calcular su factorial: "
    resultado:  .string "El factorial de %d es: %d\n"
    error:      .string "Error: El número debe ser positivo\n"
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

    // Verificar si es negativo
    cmp     w19, #0
    b.lt    error_negativo

    // Inicializar factorial
    mov     w20, #1             // resultado = 1
    mov     w21, #1             // contador = 1

factorial_loop:
    cmp     w21, w19
    b.gt    mostrar_resultado   // Si contador > n, terminar
    mul     w20, w20, w21       // resultado *= contador
    add     w21, w21, #1        // contador++
    b       factorial_loop

mostrar_resultado:
    mov     w1, w19             // primer argumento (n)
    mov     w2, w20             // segundo argumento (factorial)
    adrp    x0, resultado
    add     x0, x0, :lo12:resultado
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
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Asciinema 
https://asciinema.org/a/gKaAsc4MNguYqYDJh2ZoRQqq6 
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #python 
    def main():
    # Solicitar el número
    n = int(input("Ingrese un número para calcular su factorial: "))

    # Verificar si el número es negativo
    if n < 0:
        print("Error: El número debe ser positivo")
    else:
        # Calcular el factorial
        factorial = 1
        contador = 1

        while contador <= n:
            factorial *= contador
            contador += 1

        # Mostrar el resultado
        print(f"El factorial de {n} es: {factorial}")

# Ejecutar el programa
if __name__ == "__main__":
    main()

