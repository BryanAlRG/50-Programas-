# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Suma de elementos en un arreglo
#Python 
# Función para sumar los elementos de un arreglo
def sum_elements(arr):
    return sum(arr)  # Utiliza la función sum() para obtener la suma de los elementos

# Función para ingresar los datos y mostrar el resultado
def main():
    # Solicitar al usuario que ingrese los elementos del arreglo
    arr = list(map(int, input("Ingresa los elementos del arreglo separados por espacio: ").split()))
    
    # Calcular la suma
    result = sum_elements(arr)
    
    # Mostrar el resultado
    print(f"La suma de los elementos del arreglo es: {result}")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Arm
.global array_sum
.type array_sum, %function

array_sum:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    mov x2, #0              // Suma
    mov x3, #0              // Índice
    
sum_loop:
    cmp x3, x1
    bge done
    
    ldr x4, [x0, x3, lsl #3]  // Cargar elemento
    add x2, x2, x4            // Añadir a suma
    
    add x3, x3, #1
    b sum_loop
    
done:
    mov x0, x2                // Retornar suma
    ret
#Asciinema 
https://asciinema.org/a/rW0jRAwjZfiZts0f9MUBMgOwC
