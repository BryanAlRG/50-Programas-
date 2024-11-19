# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Desplazamientos a la izquierda y derecha	
#Python
def bit_shifts(number: int, positions: int):
    # Realizar desplazamientos de bits
    left_shift = number << positions       # Desplazamiento izquierdo
    right_shift_logical = number >> positions  # Desplazamiento derecho lógico
    right_shift_arithmetic = (number & 0xFFFFFFFFFFFFFFFF) >> positions  # Desplazamiento derecho aritmético
    
    return left_shift, right_shift_logical, right_shift_arithmetic

# Ejemplo de uso:
number = 5          # Binario: 101
positions = 2
left_shift, right_shift_logical, right_shift_arithmetic = bit_shifts(number, positions)

print(f"Left Shift: {left_shift}, Right Shift Logical: {right_shift_logical}, Right Shift Arithmetic: {right_shift_arithmetic}")

#Arm 
.global bit_shifts
.type bit_shifts, %function

bit_shifts:
    // x0 = número a desplazar
    // x1 = cantidad de posiciones
    // Retorna: x0 = desplazamiento izquierdo, x1 = derecho lógico, x2 = derecho aritmético
    mov x3, x0             // Guardar número original
    
    // Realizar desplazamientos
    lsl x0, x3, x1         // Desplazamiento izquierdo
    lsr x1, x3, x1         // Desplazamiento derecho lógico
    asr x2, x3, x1         // Desplazamiento derecho aritmético
    
    ret

#Asciinema 
https://asciinema.org/a/IOgshZ3sGFMK4pp7QPDG1MvMa
