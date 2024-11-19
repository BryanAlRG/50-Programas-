# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa:	Búsqueda binaria
#Python 
def binary_search(arr, target):
    """
    Realiza una búsqueda binaria para encontrar un valor en un arreglo ordenado.
    
    Args:
        arr (list): Lista ordenada en la que buscar
        target: Valor a buscar
        
    Returns:
        int: Índice del elemento si se encuentra, -1 si no se encuentra
    """
    left = 0
    right = len(arr) - 1
    
    while left <= right:
        # Calcular punto medio
        mid = (left + right) // 2
        
        # Obtener el elemento del medio
        mid_value = arr[mid]
        
        # Comparar con el valor buscado
        if mid_value == target:
            return mid  # Elemento encontrado
        elif mid_value < target:
            left = mid + 1  # Buscar en la mitad derecha
        else:
            right = mid - 1  # Buscar en la mitad izquierda
    
    return -1  # Elemento no encontrado

# Versión recursiva de la búsqueda binaria
def binary_search_recursive(arr, target, left=None, right=None):
    """
    Implementación recursiva de la búsqueda binaria.
    
    Args:
        arr (list): Lista ordenada en la que buscar
        target: Valor a buscar
        left (int): Índice izquierdo del subarreglo actual
        right (int): Índice derecho del subarreglo actual
        
    Returns:
        int: Índice del elemento si se encuentra, -1 si no se encuentra
    """
    # Inicializar left y right en la primera llamada
    if left is None:
        left = 0
    if right is None:
        right = len(arr) - 1
        
    # Caso base: si left > right, el elemento no está en el arreglo
    if left > right:
        return -1
        
    # Calcular punto medio
    mid = (left + right) // 2
    mid_value = arr[mid]
    
    # Comparar con el valor buscado
    if mid_value == target:
        return mid
    elif mid_value < target:
        return binary_search_recursive(arr, target, mid + 1, right)
    else:
        return binary_search_recursive(arr, target, left, mid - 1)

# Programa principal de demostración
if __name__ == "__main__":
    # Crear un arreglo ordenado de prueba
    array = [5, 12, 23, 34, 45, 67, 89, 90]
    
    print("Arreglo ordenado:", array)
    
    # Pruebas con diferentes casos
    test_cases = [
        67,    # Elemento en el medio
        5,     # Primer elemento
        90,    # Último elemento
        50,    # Elemento que no existe
        100    # Elemento mayor que todos
    ]
    
    print("\nPruebas con búsqueda binaria iterativa:")
    for target in test_cases:
        result = binary_search(array, target)
        if result != -1:
            print(f"Elemento {target} encontrado en el índice {result}")
        else:
            print(f"Elemento {target} no encontrado")
            
    print("\nPruebas con búsqueda binaria recursiva:")
    for target in test_cases:
        result = binary_search_recursive(array, target)
        if result != -1:
            print(f"Elemento {target} encontrado en el índice {result}")
        else:
            print(f"Elemento {target} no encontrado")
            
    # Casos especiales
    print("\nCasos especiales:")
    
    # Arreglo vacío
    empty_array = []
    print(f"Búsqueda en arreglo vacío: {binary_search(empty_array, 5)}")
    
    # Arreglo con un solo elemento
    single_element = [42]
    print(f"Búsqueda de 42 en arreglo [42]: {binary_search(single_element, 42)}")
    print(f"Búsqueda de 43 en arreglo [42]: {binary_search(single_element, 43)}")
    
    # Verificar que ambas implementaciones dan los mismos resultados
    print("\nComparación de implementaciones:")
    test_array = [1, 3, 5, 7, 9, 11, 13, 15]
    for target in [7, 10]:
        iter_result = binary_search(test_array, target)
        rec_result = binary_search_recursive(test_array, target)
        print(f"Buscando {target}:")
        print(f"Implementación iterativa: {iter_result}")
        print(f"Implementación recursiva: {rec_result}")

#Arm 64
.global binary_search
.type binary_search, %function

binary_search:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    // x2 = valor a buscar
    mov x3, #0          // Inicio
    sub x4, x1, #1      // Fin
    
search_loop:
    cmp x3, x4          // Comparar inicio y fin
    bgt not_found       // Si inicio > fin, no encontrado
    
    // Calcular punto medio: mid = (left + right) / 2
    add x5, x3, x4      // Suma de índices
    lsr x5, x5, #1      // División por 2
    
    // Cargar elemento del medio
    ldr x6, [x0, x5, lsl #3]
    
    // Comparar con valor buscado
    cmp x6, x2
    beq found           // Si es igual, encontrado
    blt greater         // Si es menor, buscar en mitad superior
    
    // Si es mayor, buscar en mitad inferior
    sub x4, x5, #1      // right = mid - 1
    b search_loop
    
greater:
    add x3, x5, #1      // left = mid + 1
    b search_loop
    
found:
    mov x0, x5          // Retornar índice
    ret
    
not_found:
    mov x0, #-1         // Retornar -1
    ret
