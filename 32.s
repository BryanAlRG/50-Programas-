# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Potencia (x^n)
#Python 
# Función para calcular la potencia
def power(x, n):
    return x ** n  # Calcula x elevado a la potencia n

# Función para ingresar los datos y mostrar el resultado
def main():
    # Solicitar al usuario que ingrese la base y el exponente
    x = float(input("Ingresa la base (x): "))
    n = int(input("Ingresa el exponente (n): "))
    
    # Calcular la potencia
    result = power(x, n)
    
    # Mostrar el resultado
    print(f"El resultado de {x}^{n} es: {result}")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Arm
.global power
.type power, %function

power:
    // x0 = base (x)
    // x1 = exponente (n)
    mov x2, #1              // Resultado
    cbz x1, done           // Si exponente es 0, retornar 1
    
power_loop:
    tst x1, #1             // Verificar si exponente es impar
    beq even_exp
    mul x2, x2, x0         // Multiplicar resultado por base
    
even_exp:
    mul x0, x0, x0         // Cuadrar la base
    lsr x1, x1, #1         // Dividir exponente por 2
    cbnz x1, power_loop    // Si exponente no es 0, continuar
    
done:
    mov x0, x2             // Retornar resultado
    ret

#Asciinema 
https://asciinema.org/a/kuuNQadmiDkbWxHTR1prm0k9f
