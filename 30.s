# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Máximo Común Divisor (MCD)

#Python
def gcd(a, b):
    while b != 0:
        a, b = b, a % b  # Intercambia a y b, y calcula el resto
    return a

# Ejemplo de uso
a = 56
b = 98
result = gcd(a, b)
print(f"El GCD de {a} y {b} es: {result}")

#Arm 
.global gcd
.type gcd, %function

gcd:
    // x0 = primer número
    // x1 = segundo número
    // Implementación del algoritmo de Euclides
    cbz x1, done           // Si b es 0, retornar a
    
    udiv x2, x0, x1        // a / b
    msub x2, x1, x2, x0    // a % b = a - (a/b)*b
    
    mov x0, x1             // a = b
    mov x1, x2             // b = a % b
    b gcd                  // Llamada recursiva
    
done:
    ret

#Asciinema 
https://asciinema.org/a/su9JZ56P3rpAcrMQ1Z57qjvfg
