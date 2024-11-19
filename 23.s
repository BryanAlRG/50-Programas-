# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Conversión de entero a ASCII	
#Python
def int_to_ascii(num):
    # Manejar el caso de número negativo
    if num < 0:
        return '-' + str(abs(num))
    return str(num)

if __name__ == "__main__":
    # Ejemplo de uso
    number = -12345  # Puedes cambiar este valor para probar
    print(f"El número es: {int_to_ascii(number)}")

#Ensamblador
.global int_to_ascii
.type int_to_ascii, %function

int_to_ascii:
    // x0 = número entero
    // x1 = dirección del buffer de salida

    mov x2, #10             // Base 10
    mov x3, x1              // Dirección de buffer
    add x3, x3, #32         // Reservar espacio para 32 caracteres (tamaño del buffer)
    mov x4, #0              // Contador de dígitos
    mov x5, x0              // Copiar número para procesarlo

    // Verificar si el número es cero
    cmp x5, #0
    beq store_zero

reverse_loop:
    udiv x6, x5, x2         // División: x6 = x5 / 10
    mul x7, x6, x2          // x7 = x6 * 10
    sub x8, x5, x7          // x8 = x5 - x7 (el dígito actual)
    add x8, x8, #'0'        // Convertir a ASCII

    strb w8, [x3, x4]       // Guardar el dígito en el buffer
    add x4, x4, #1          // Incrementar el índice del buffer
    mov x5, x6              // Actualizar el número
    cmp x5, #0              // Verificar si el número es cero
    bne reverse_loop

store_zero:
    // Al finalizar, debemos invertir los dígitos (si es necesario) y agregar el terminador nulo.
    mov x6, x4
    sub x6, x6, #1
    strb wzr, [x3, x6]      // Agregar terminador nulo
    ret

#Asciinema 
https://asciinema.org/a/gAhEulWG0QOFPTIs3IHR1CFZb
