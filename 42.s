# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Conversión de hexadecimal a decimal
#Python 
def decimal_a_hexadecimal(decimal):
    if decimal == 0:
        return "0"
    
    hex_digits = "0123456789ABCDEF"
    hex_result = ""
    
    while decimal > 0:
        remainder = decimal % 16
        hex_result = hex_digits[remainder] + hex_result
        decimal //= 16
    
    return hex_result

# Ejemplo de uso
numero_decimal = int(input("Ingresa un número decimal: "))
print(f"El número decimal {numero_decimal} en hexadecimal es: {decimal_a_hexadecimal(numero_decimal)}")

#Arm
.global _start
.section .text

_start:
    // Ejemplo: convertir 0xFF a decimal (255)
    mov x0, #0xFF       // Número hexadecimal a convertir
    bl hex_to_decimal
    mov x8, #93         // Syscall exit
    svc #0

hex_to_decimal:
    // x0 contiene el número hexadecimal
    // x1 contendrá el resultado decimal
    mov x1, #0          // Inicializar resultado
    mov x2, #16         // Base 16
    mov x4, #0          // Contador de dígitos
    
convert_loop:
    and x3, x0, #0xF    // Obtener último dígito hex
    
    // Multiplicar resultado actual por 16 y añadir nuevo dígito
    mul x1, x1, x2      // x1 = x1 * 16
    add x1, x1, x3      // Añadir nuevo dígito
    
    lsr x0, x0, #4      // Preparar siguiente dígito
    add x4, x4, #1      // Incrementar contador
    
    cbnz x0, convert_loop  // Continuar si quedan dígitos

    mov x0, x1          // Mover resultado a x0
    ret

.section .data
    result: .quad 0

#Asciinema 
https://asciinema.org/a/aob9CFN3ala1bBBoyYRYUdUDq
