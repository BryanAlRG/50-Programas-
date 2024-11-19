# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Mínimo Común Múltiplo (MCM)
#Python 
# Función para calcular el GCD (Máximo Común Divisor)
def gcd(a, b):
    while b != 0:
        a, b = b, a % b  # Intercambia a y b, y calcula el resto
    return a

# Función para calcular el MCM (Mínimo Común Múltiplo)
def lcm(a, b):
    return abs(a * b) // gcd(a, b)

# Función para ingresar datos y mostrar el resultado
def main():
    # Solicitar al usuario que ingrese dos números
    a = int(input("Ingresa el primer número: "))
    b = int(input("Ingresa el segundo número: "))
    
    # Calcular el MCM
    result = lcm(a, b)
    
    # Mostrar el resultado
    print(f"El Mínimo Común Múltiplo de {a} y {b} es: {result}")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Arm 
.global lcm
.type lcm, %function

lcm:
    // x0 = primer número (a)
    // x1 = segundo número (b)
    stp x29, x30, [sp, #-16]!   // Guardar registros
    stp x0, x1, [sp, #-16]!     // Guardar números originales
    
    // Primero calculamos el GCD
    bl gcd                      // Llamar a función GCD
    
    // Restaurar números originales
    ldp x2, x3, [sp], #16
    
    // LCM = (a * b) / GCD
    mul x1, x2, x3              // a * b
    udiv x0, x1, x0             // (a * b) / GCD
    
    ldp x29, x30, [sp], #16     // Restaurar registros
    ret

// Función auxiliar GCD (necesaria para LCM)
gcd:
    cbz x1, gcd_done
    udiv x2, x0, x1
    msub x2, x1, x2, x0
    mov x0, x1
    mov x1, x2
    b gcd
gcd_done:
    ret
#Asciinema 
https://asciinema.org/a/PlS8CTiulbEsB7T0MI1oFEx6e
