# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Multiplica 2 numeros 
# Descripcion de la actividad: Multiplicacion de 2 numeros en ensamblador ARM 64

.data
    prompt1:    .string "Ingrese primer número: "
    prompt2:    .string "Ingrese segundo número: "
    resultado:  .string "La multiplicación es: %d\n"
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
    ldr     w19, [sp]           // Guardar primer número en w19

    // Mostrar segundo prompt
    adrp    x0, prompt2
    add     x0, x0, :lo12:prompt2
    bl      printf

    // Leer segundo número
    mov     x1, sp
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf
    ldr     w20, [sp]           // Guardar segundo número en w20

    // Realizar multiplicación
    mul     w1, w19, w20        // w1 = w19 * w20

    // Mostrar resultado
    adrp    x0, resultado
    add     x0, x0, :lo12:resultado
    bl      printf

    // Limpiar y salir
    add     sp, sp, #16
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Asciinema 
https://asciinema.org/a/tGgpgBQxIuYe7PjhLzZM7gpbt

------------------------------------------------------------------------------------------------------------------------------------------
def main():
    # Solicitar el primer número
    num1 = int(input("Ingrese primer número: "))

    # Solicitar el segundo número
    num2 = int(input("Ingrese segundo número: "))

    # Realizar la multiplicación
    multiplicacion = num1 * num2

    # Mostrar el resultado
    print(f"La multiplicación es: {multiplicacion}")

# Ejecutar el programa
if __name__ == "__main__":
    main()
