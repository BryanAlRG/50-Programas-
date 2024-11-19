# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: 	Verificar si un número es primo
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

    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #Asciinema 
    https://asciinema.org/a/dOn4ZTqk2t9r2AF5euXCbbdVT
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    def es_primo(n):
    if n <= 1:
        print("Error: El número debe ser mayor que 1")
        return

    # Verificar si el número es primo
    for divisor in range(2, int(n**0.5) + 1):  # Solo verificamos hasta la raíz cuadrada de n
        if n % divisor == 0:
            print(f"El número {n} no es primo")
            return
    
    # Si no se encontró ningún divisor, es primo
    print(f"El número {n} es primo")

def main():
    # Solicitar al usuario que ingrese un número
    try:
        numero = int(input("Ingrese un número para verificar si es primo: "))
        es_primo(numero)
    except ValueError:
        print("Error: Ingrese un número válido")

if __name__ == "__main__":
    main()

