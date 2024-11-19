# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Invertir los elementos de un arreglo
#Python 
# Función para invertir los elementos de un arreglo
def invert_array(arr):
    return arr[::-1]  # Utiliza el slicing para invertir la lista

# Función para ingresar los datos y mostrar el resultado
def main():
    # Solicitar al usuario que ingrese los elementos del arreglo
    arr = list(map(int, input("Ingresa los elementos del arreglo separados por espacio: ").split()))
    
    # Invertir el arreglo
    inverted_arr = invert_array(arr)
    
    # Mostrar el resultado
    print(f"El arreglo invertido es: {inverted_arr}")

# Llamar a la función principal
if __name__ == "__main__":
    main()
#Asciinema 
https://asciinema.org/a/acpGrdSlo7ZurPmHQFKNXx5dD
#Ensamblador 
.global array_reverse
.type array_reverse, %function

array_reverse:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    mov x2, #0              // Índice inicial
    sub x3, x1, #1         // Índice final
    
reverse_loop:
    cmp x2, x3
    bge done
    
    // Cargar elementos
    ldr x4, [x0, x2, lsl #3]
    ldr x5, [x0, x3, lsl #3]
    
    // Intercambiar
    str x5, [x0, x2, lsl #3]
    str x4, [x0, x3, lsl #3]
    
    add x2, x2, #1
    sub x3, x3, #1
    b reverse_loop
    
done:
    ret
