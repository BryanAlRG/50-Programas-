# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Conversión de decimal a hexadecimal
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
// Conversión de Decimal a Hexadecimal en ARM64
.global _start
.section .text

_start:
    // Ejemplo: convertir 255 a hexadecimal (resultado esperado: FF)
    mov x0, #255        // Número decimal a convertir
    bl decimal_to_hex
    mov x8, #93         // Syscall exit
    svc #0

decimal_to_hex:
    // x0 contiene el número decimal
    // x1 contendrá el resultado hexadecimal
    mov x1, #0          // Inicializar resultado
    mov x2, #16         // Base 16
    mov x4, #0          // Contador de dígitos
    
convert_loop:
    udiv x3, x0, x2     // División por 16
    msub x5, x3, x2, x0 // Obtener residuo (x5 = x0 - (x3 * x2))
    
    // Convertir dígito a ASCII si es necesario
    cmp x5, #9          // Comparar con 9
    add x5, x5, #48     // Convertir a ASCII para 0-9
    ble store_digit
    add x5, x5, #7      // Ajustar para A-F (55 = 'A'-10)

store_digit:
    // Almacenar dígito
    lsl x1, x1, #8      // Hacer espacio para nuevo dígito
    orr x1, x1, x5      // Añadir dígito
    add x4, x4, #1      // Incrementar contador
    
    mov x0, x3          // Preparar para siguiente iteración
    cbnz x0, convert_loop  // Continuar si quedan dígitos

    mov x0, x1          // Mover resultado a x0
    ret

.section .data
    result: .quad 0

#Asciinema 
https://asciinema.org/a/w0DTjQoNNu1nIs6DSTsq2j7pW
