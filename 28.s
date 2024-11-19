# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Establecer, borrar y alternar bits
#Python
def bit_manipulation(number, position):
    # Establecer el bit en la posición indicada
    set_bit = number | (1 << position)
    
    # Borrar el bit en la posición indicada
    clear_bit = number & ~(1 << position)
    
    # Alternar el bit en la posición indicada
    toggle_bit = number ^ (1 << position)
    
    return set_bit, clear_bit, toggle_bit

# Ejemplo de uso
number = 0b10101010  # Número original (170 en decimal)
position = 3         # Posición del bit (0-indexed)

set_bit, clear_bit, toggle_bit = bit_manipulation(number, position)

print(f"Original: {bin(number)}")
print(f"Bit Establecido: {bin(set_bit)}")
print(f"Bit Borrado: {bin(clear_bit)}")
print(f"Bit Alternado: {bin(toggle_bit)}")

#Ensamblador 
.global bit_manipulation
.type bit_manipulation, %function

bit_manipulation:
    // x0 = número original
    // x1 = posición del bit
    // Retorna: x0 = bit establecido, x1 = bit borrado, x2 = bit alternado
    mov x3, x0             // Guardar número original
    mov x4, #1             // Máscara base
    lsl x4, x4, x1         // Desplazar máscara a posición
    
    // Establecer bit
    orr x0, x3, x4
    
    // Borrar bit
    mvn x5, x4             // Invertir máscara
    and x1, x3, x5
    
    // Alternar bit
    eor x2, x3, x4
    
    ret
#Asciinema 
https://asciinema.org/a/QIif7LeSwGlVnZTbi6v6GiWBz
