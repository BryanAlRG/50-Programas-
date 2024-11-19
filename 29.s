# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Contar los bits activados en un número

#Python
def count_set_bits(number):
    count = 0
    while number > 0:
        count += number & 1  # Incrementar el contador si el último bit es 1
        number >>= 1          # Desplazar a la derecha
    return count

# Ejemplo de uso
number = 0b10101010  # Número binario (170 en decimal)

set_bits = count_set_bits(number)
print(f"Número de bits establecidos en {bin(number)}: {set_bits}")

#Ensamblador 
.global count_set_bits
.type count_set_bits, %function

count_set_bits:
    // x0 = número a analizar
    mov x1, #0              // Contador de bits
    
count_loop:
    cbz x0, done           // Si no quedan bits, terminar
    
    // Verificar último bit
    and x2, x0, #1
    add x1, x1, x2         // Incrementar contador si es 1
    
    lsr x0, x0, #1         // Desplazar a la derecha
    b count_loop
    
done:
    mov x0, x1             // Retornar cantidad de bits
    ret
#Asciinema 
https://asciinema.org/a/ULap2NlRwweex2UZ6XjiJXRcs
