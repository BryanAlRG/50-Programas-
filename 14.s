# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Búsqueda lineal

def linear_search(arr, target):
    """
    Realiza una búsqueda lineal para encontrar un valor en un arreglo.
    
    Args:
        arr (list): Lista en la que buscar
        target: Valor a buscar
        
    Returns:
        int: Índice del elemento si se encuentra, -1 si no se encuentra
    """
    # Iterar a través del arreglo
    for i in range(len(arr)):
        if arr[i] == target:
            return i  # Elemento encontrado, retornar índice
    
    return -1  # Elemento no encontrado

# Versión alternativa usando funciones incorporadas de Python
def linear_search_built_in(arr, target):
    """
    Realiza una búsqueda lineal usando funciones incorporadas de Python.
    
    Args:
        arr (list): Lista en la que buscar
        target: Valor a buscar
        
    Returns:
        int: Índice del elemento si se encuentra, -1 si no se encuentra
    """
    try:
        return arr.index(target)
    except ValueError:
        return -1

# Programa principal de demostración
if __name__ == "__main__":
    # Crear un arreglo de prueba
    array = [45, 23, 67, 12, 89, 34, 90, 5]
    
    # Pruebas con diferentes casos
    print("Arreglo:", array)
    
    # Caso 1: Buscar un número que existe
    target = 67
    resultado = linear_search(array, target)
    print(f"\nBuscando {target}:")
    if resultado != -1:
        print(f"Elemento encontrado en el índice {resultado}")
    else:
        print("Elemento no encontrado")
        
    # Caso 2: Buscar un número que no existe
    target = 100
    resultado = linear_search(array, target)
    print(f"\nBuscando {target}:")
    if resultado != -1:
        print(f"Elemento encontrado en el índice {resultado}")
    else:
        print("Elemento no encontrado")
        
    # Caso 3: Buscar en un arreglo vacío
    empty_array = []
    target = 5
    resultado = linear_search(empty_array, target)
    print(f"\nBuscando {target} en arreglo vacío:")
    if resultado != -1:
        print(f"Elemento encontrado en el índice {resultado}")
    else:
        print("Elemento no encontrado")
        
    # Caso 4: Buscar el primer elemento
    target = 45
    resultado = linear_search(array, target)
    print(f"\nBuscando {target} (primer elemento):")
    if resultado != -1:
        print(f"Elemento encontrado en el índice {resultado}")
    else:
        print("Elemento no encontrado")
        
    # Caso 5: Buscar el último elemento
    target = 5
    resultado = linear_search(array, target)
    print(f"\nBuscando {target} (último elemento):")
    if resultado != -1:
        print(f"Elemento encontrado en el índice {resultado}")
    else:
        print("Elemento no encontrado")
        
    # Comparar con la implementación usando función incorporada
    print("\nComparación con implementación usando función incorporada:")
    for target in [67, 100]:
        resultado1 = linear_search(array, target)
        resultado2 = linear_search_built_in(array, target)
        print(f"Buscando {target}:")
        print(f"Implementación manual: {resultado1}")
        print(f"Función incorporada: {resultado2}")

.global linear_search
.type linear_search, %function

linear_search:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    // x2 = valor a buscar
    mov x3, #0          // Índice inicial
    
search_loop:
    cmp x3, x1          // Comparar con tamaño
    bge not_found       // Si terminamos, no se encontró
    
    ldr x4, [x0, x3, lsl #3]  // Cargar elemento
    cmp x4, x2          // Comparar con valor buscado
    beq found           // Si es igual, encontrado
    
    add x3, x3, #1      // Incrementar índice
    b search_loop
    
found:
    mov x0, x3          // Retornar índice
    ret
    
not_found:
    mov x0, #-1         // Retornar -1
    ret

    #Asciinema
    https://asciinema.org/a/PFPuLHeB8KJzbBxKZNk9dkK2D
