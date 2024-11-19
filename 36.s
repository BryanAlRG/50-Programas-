# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Encontrar el segundo elemento más grande
#Python 
def second_largest(arr):
    if len(arr) < 2:
        return None  # Si el arreglo tiene menos de 2 elementos, no hay un segundo más grande

    # Inicializar las dos variables con valores mínimos posibles
    first, second = float('-inf'), float('-inf')

    for num in arr:
        if num > first:
            second = first
            first = num
        elif num > second and num != first:
            second = num

    # Si no se encontró un segundo elemento único más grande
    if second == float('-inf'):
        return None

    return second

# Función principal para ingresar los datos y mostrar el resultado
def main():
    # Solicitar al usuario que ingrese los elementos del arreglo
    arr = list(map(int, input("Ingresa los elementos del arreglo separados por espacio: ").split()))

    result = second_largest(arr)

    if result is None:
        print("No se pudo encontrar el segundo elemento más grande.")
    else:
        print(f"El segundo elemento más grande es: {result}")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Ensamblador 
.global second_largest
.type second_largest, %function

second_largest:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    cmp x1, #2
    blt no_second          // Si tamaño < 2, no hay segundo
    
    ldr x2, [x0]          // Primer elemento como máximo
    ldr x3, [x0, #8]      // Segundo elemento como segundo máximo
    
    // Ajustar máximo y segundo máximo iniciales
    cmp x2, x3
    bge max_ok
    
    // Intercambiar si están en orden incorrecto
    mov x4, x2
    mov x2, x3
    mov x3, x4
    
max_ok:
    mov x4, #2            // Índice inicial
    
find_loop:
    cmp x4, x1
    bge done
    
    ldr x5, [x0, x4, lsl #3]
    
    // Comparar con máximo actual
    cmp x5, x2
    bgt update_max
    cmp x5, x3
    bgt update_second
    b next
    
update_max:
    mov x3, x2            // Antiguo máximo pasa a segundo
    mov x2, x5            // Nuevo máximo
    b next
    
update_second:
    mov x3, x5            // Actualizar segundo máximo
    
next:
    add x4, x4, #1
    b find_loop
    
done:
    mov x0, x3            // Retornar segundo máximo
    ret
    
no_second:
    mov x0, #-1           // Indicar error
    ret
#Asciinema
https://asciinema.org/a/JB3XfBx4lhitqP8g4oBlvtBX0
