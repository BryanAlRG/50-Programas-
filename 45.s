# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Verificar si un número es Armstrong
------------------------------------------------------------------------------------------------------------------------------------------
#Python 
def es_armstrong(numero):
    # Convertir el número a cadena para contar dígitos
    str_numero = str(numero)
    num_digitos = len(str_numero)
    
    # Calcular la suma de cada dígito elevado a la potencia del total de dígitos
    suma = sum(int(digito) ** num_digitos for digito in str_numero)
    
    # Comparar la suma con el número original
    return suma == numero

# Función para mostrar ejemplos
def mostrar_ejemplos_armstrong():
    # Ejemplos de números Armstrong
    numeros_probar = [153, 370, 371, 407, 1634, 8208, 9474]
    
    print("Verificación de Números Armstrong:")
    for num in numeros_probar:
        resultado = es_armstrong(num)
        print(f"{num} es Armstrong: {resultado}")

# Ejecución de ejemplos
mostrar_ejemplos_armstrong()

# Función para encontrar números Armstrong en un rango
def encontrar_armstrong_en_rango(inicio, fin):
    armstrong_encontrados = [
        num for num in range(inicio, fin + 1) 
        if es_armstrong(num)
    ]
    return armstrong_encontrados

# Ejemplo de búsqueda en un rango
print("\nNúmeros Armstrong entre 100 y 1000:")
print(encontrar_armstrong_en_rango(100, 1000))
------------------------------------------------------------------------------------------------------------------------------------------
#Ensamblador 
.global _start
.section .text

_start:
    // Ejemplo: verificar si 153 es número Armstrong
    mov x0, #153        // Número a verificar
    bl is_armstrong
    mov x8, #93         // Syscall exit
    svc #0

is_armstrong:
    // x0 contiene el número a verificar
    mov x1, x0          // Copia para procesar dígitos
    mov x2, x0          // Copia para contar dígitos
    mov x3, #0          // Contador de dígitos
    mov x4, #0          // Suma de potencias
    
    // Contar dígitos
count_digits:
    udiv x2, x2, #10
    add x3, x3, #1
    cbnz x2, count_digits
    
    // Procesar cada dígito
process_digits:
    udiv x2, x1, #10    // x2 = número / 10
    msub x5, x2, #10, x1 // x5 = dígito actual
    
    // Calcular potencia del dígito
    mov x6, #1          // Resultado de la potencia
    mov x7, x3          // Exponente (número de dígitos)
power_loop:
    mul x6, x6, x5
    sub x7, x7, #1
    cbnz x7, power_loop
    
    add x4, x4, x6      // Sumar potencia al resultado
    mov x1, x2          // Preparar siguiente dígito
    cbnz x1, process_digits
    
    // Verificar si es Armstrong
    cmp x0, x4
    cset x0, eq         // x0 = 1 si es Armstrong, 0 si no
    ret

.section .data
    result: .quad 0
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Asciinema 
https://asciinema.org/a/NiNXIVacC6izaPnHzOGQXpsun
