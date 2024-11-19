# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: 	Encontrar el máximo en un arreglo
------------------------------------------------------------------------------------------------
#Python 
def find_max(arr):
    """
    Encuentra el valor máximo en un arreglo.

    :param arr: Lista de números enteros o flotantes.
    :return: El valor máximo en la lista.
    """
    if not arr:  # Si el arreglo está vacío, devolver None
        return None

    max_val = arr[0]  # Primer elemento como máximo inicial

    for elem in arr[1:]:  # Iterar sobre los elementos restantes
        if elem > max_val:  # Comparar con el máximo actual
            max_val = elem  # Actualizar máximo si es mayor

    return max_val

# Ejemplo de uso
arr = [3, 5, 1, 8, 2, 10, 6]
print("El valor máximo es:", find_max(arr))
-----------------------------------------------------------------------------------
.global find_max
.type find_max, %function

find_max:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    ldr x2, [x0]        // Primer elemento como máximo
    mov x3, #1          // Índice inicial
    
max_loop:
    cmp x3, x1          // Comparar con tamaño
    bge max_done        // Si terminamos, salir
    
    ldr x4, [x0, x3, lsl #3]  // Cargar siguiente elemento
    cmp x4, x2          // Comparar con máximo actual
    csel x2, x4, x2, gt // Actualizar máximo si es mayor
    
    add x3, x3, #1      // Incrementar índice
    b max_loop
    
max_done:
    mov x0, x2          // Retornar máximo
    ret

    #    Asciinema 
    https://asciinema.org/a/UgZVR4AV2GvbtbqfmKai8CN7B
