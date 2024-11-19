# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Calcular la longitud de una cadena
#Python
def strlen(s: str) -> int:
    length = 0
    for char in s:
        length += 1
    return length

# Ejemplo de uso:
cadena = "Hello"
longitud = strlen(cadena)
print("La longitud de la cadena es:", longitud)
#Arm
.global strlen
.type strlen, %function

strlen:
    // x0 = dirección de la cadena
    mov x1, x0              // Copiar dirección inicial
    
count_loop:
    ldrb w2, [x1], #1      // Cargar byte y avanzar
    cbnz w2, count_loop    // Si no es 0, continuar
    
    sub x0, x1, x0         // Calcular diferencia
    sub x0, x0, #1         // Ajustar por null terminator
    ret

#Asciinema 
https://asciinema.org/a/hubbiRXuOXaycjBIOjnJxkXjc
