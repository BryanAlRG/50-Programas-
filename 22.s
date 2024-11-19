# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Conversión de ASCII a entero
#Python
def ascii_to_int(s):
    # Verificar si el número es negativo
    negative = False
    if s[0] == '-':
        negative = True
        s = s[1:]  # Eliminar el signo negativo

    # Convertir la cadena a un número
    result = 0
    for char in s:
        result = result * 10 + (ord(char) - ord('0'))

    # Aplicar signo negativo si es necesario
    if negative:
        result = -result

    return result

if __name__ == "__main__":
    # Ejemplo de uso
    ascii_string = "-12345"  # Puedes cambiar este valor para probar
    print(f"El número es: {ascii_to_int(ascii_string)}")

#Arm 64
.global ascii_to_int
.type ascii_to_int, %function

ascii_to_int:
    // x0 = dirección de la cadena ASCII
    mov x1, #0              // Resultado
    mov x2, #0              // Índice
    mov x3, #10             // Base 10
    
    // Verificar signo
    ldrb w4, [x0]
    cmp w4, #'-'
    bne convert_loop
    add x0, x0, #1         // Saltar el signo negativo
    mov x5, #1             // Flag para número negativo
    
convert_loop:
    ldrb w4, [x0, x2]      // Cargar siguiente dígito
    cbz w4, done           // Si es 0, terminamos
    
    sub w4, w4, #'0'       // Convertir ASCII a número
    
    // Multiplicar resultado actual por 10
    mul x1, x1, x3
    add x1, x1, x4         // Añadir nuevo dígito
    
    add x2, x2, #1         // Siguiente posición
    b convert_loop
    
done:
    // Aplicar signo si es necesario
    cbz x5, positive
    neg x1, x1
    
positive:
    mov x0, x1             // Retornar resultado
    ret
#Asciinema 
https://asciinema.org/a/L6R1Z5VQFuTbnYZLuBfbDvMLl
