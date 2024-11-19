# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Suma de los primeros N numeros
~~~
.data
    prompt:     .string "Ingrese N: "
    resultado:  .string "La suma de los primeros %d números es: %d\n"
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

    // Leer N
    sub     sp, sp, #16
    mov     x1, sp
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf
    ldr     w19, [sp]           // Guardar N en w19

    // Inicializar suma y contador
    mov     w20, #0             // suma = 0
    mov     w21, #1             // i = 1

loop:
    // Sumar número actual
    add     w20, w20, w21       // suma += i
    add     w21, w21, #1        // i++
    cmp     w21, w19            // comparar i con N
    b.le    loop               // si i <= N, continuar loop

    // Mostrar resultado
    mov     w1, w19             // primer argumento para printf (N)
    mov     w2, w20             // segundo argumento para printf (suma)
    adrp    x0, resultado
    add     x0, x0, :lo12:resultado
    bl      printf

    // Limpiar y salir
    add     sp, sp, #16
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Asciinema 
https://asciinema.org/a/43b6sy3O9gUc8HodOVH3wMlgq 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#python
def main():
    # Solicitar el valor de N
    N = int(input("Ingrese N: "))

    # Inicializar suma y contador
    suma = 0
    i = 1

    # Bucle para calcular la suma de los primeros N números
    while i <= N:
        suma += i
        i += 1

    # Mostrar el resultado
    print(f"La suma de los primeros {N} números es: {suma}")

# Ejecutar el programa
if __name__ == "__main__":
    main()
