# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: 	Verificar si una cadena es palíndromo
---------------------------------------------------------------------------------------------------------------------------------
.data
    prompt:     .string "Ingrese una cadena: "
    resultado_palindrome: .string "La cadena es un palíndromo.\n"
    resultado_no_palindrome: .string "La cadena no es un palíndromo.\n"
    buffer:     .skip 101           // 100 caracteres + null terminator
    formato:    .string "%100s"     // Formato para leer una cadena

.text
.global main
.global is_palindrome
.align 4

// Función is_palindrome
is_palindrome:
    // x0 contiene la dirección de la cadena
    mov x2, x0               // Guardar dirección inicial de la cadena
    mov x3, #0               // Contador para longitud de la cadena

    // Encontrar longitud de la cadena
length_loop:
    ldrb w4, [x2, x3]        // Cargar byte de la cadena
    cbz w4, length_done      // Si es 0 (null terminator), terminamos
    add x3, x3, #1           // Incrementar el contador
    b length_loop            // Volver al bucle

length_done:
    sub x3, x3, #1           // Ajustar longitud (excluir el null terminator)
    mov x1, #0               // Inicializar el índice de inicio (x1 = 0)
    
compare_loop:
    cmp x1, x3                // Comparar índice de inicio con el final
    bge is_palindrome_true    // Si x1 >= x3, es palíndromo

    ldrb w4, [x0, x1]         // Cargar byte del inicio
    ldrb w5, [x0, x3]         // Cargar byte del final
    cmp w4, w5                // Comparar los caracteres
    bne is_palindrome_false   // Si no son iguales, no es palíndromo

    add x1, x1, #1            // Incrementar índice de inicio
    sub x3, x3, #1            // Decrementar índice de fin
    b compare_loop            // Volver al bucle

is_palindrome_true:
    mov x0, #1                // Retornar 1 (es palíndromo)
    ret

is_palindrome_false:
    mov x0, #0                // Retornar 0 (no es palíndromo)
    ret

// Función principal (main)
main:
    // Guardar registros
    stp     x29, x30, [sp, #-16]!

    // Mostrar prompt
    adrp    x0, prompt
    add     x0, x0, :lo12:prompt
    bl      printf

    // Leer la cadena
    adrp    x1, buffer
    add     x1, x1, :lo12:buffer
    adrp    x0, formato
    add     x0, x0, :lo12:formato
    bl      scanf

    // Llamar a is_palindrome
    adrp    x0, buffer
    add     x0, x0, :lo12:buffer
    bl      is_palindrome

    // Verificar el resultado de is_palindrome
    cmp     x0, #1                // Si x0 == 1, es un palíndromo
    beq     palindrome_true

    // No es un palíndromo
    adrp    x0, resultado_no_palindrome
    add     x0, x0, :lo12:resultado_no_palindrome
    bl      printf
    b       fin

palindrome_true:
    // Es un palíndromo
    adrp    x0, resultado_palindrome
    add     x0, x0, :lo12:resultado_palindrome
    bl      printf

fin:
    // Limpiar y salir
    ldp     x29, x30, [sp], #16
    mov     w0, #0
    ret
-------------------------------------------------------------------------------
#Aciinema 
https://asciinema.org/a/qwtBIHus9dybe1DboYmKtk4YX
--------------------------------------------------------------------------------
#Python
def is_palindrome(cadena):
    # Eliminar los espacios y convertir a minúsculas para comparación insensible
    cadena = cadena.replace(" ", "").lower()
    
    # Comparar los caracteres desde ambos extremos
    inicio = 0
    final = len(cadena) - 1
    
    while inicio < final:
        if cadena[inicio] != cadena[final]:
            return False  # No es un palíndromo
        inicio += 1
        final -= 1
    
    return True  # Es un palíndromo

# Función principal para probar
def main():
    # Solicitar al usuario una cadena
    cadena = input("Ingrese una cadena: ")

    # Verificar si la cadena es un palíndromo
    if is_palindrome(cadena):
        print("La cadena es un palíndromo.")
    else:
        print("La cadena no es un palíndromo.")

if __name__ == "__main__":
    main()

