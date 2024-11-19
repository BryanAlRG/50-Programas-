# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Encontrar el mínimo en un arreglo

#Python 
def find_min(arr):
    """
    Encuentra el valor mínimo en un arreglo.
    
    Args:
        arr (list): Lista de números
        
    Returns:
        number: El valor mínimo encontrado en el arreglo
    """
    if not arr:  # Si el arreglo está vacío
        raise ValueError("El arreglo no puede estar vacío")
        
    current_min = arr[0]  # Inicializar con el primer elemento
    
    # Iterar a través del arreglo comenzando desde el segundo elemento
    for i in range(1, len(arr)):
        if arr[i] < current_min:
            current_min = arr[i]
            
    return current_min

# Versión alternativa usando funciones incorporadas de Python
def find_min_built_in(arr):
    """
    Encuentra el valor mínimo usando la función min() de Python.
    
    Args:
        arr (list): Lista de números
        
    Returns:
        number: El valor mínimo encontrado en el arreglo
    """
    if not arr:
        raise ValueError("El arreglo no puede estar vacío")
    return min(arr)

# Programa principal de demostración
if __name__ == "__main__":
    # Usar el mismo arreglo que en la versión de ensamblador
    array = [45, 23, 67, 12, 89, 34, 90, 5]
    
    # Usando nuestra implementación
    resultado = find_min(array)
    print(f"El valor mínimo es: {resultado}")
    
    # Verificar que ambas implementaciones dan el mismo resultado
    resultado_built_in = find_min_built_in(array)
    print(f"El valor mínimo (usando min()): {resultado_built_in}")
    
    # Pruebas adicionales
    # Prueba con un solo elemento
    print(f"\nPrueba con un solo elemento:")
    print(find_min([42]))
    
    # Prueba con números negativos
    print(f"\nPrueba con números negativos:")
    print(find_min([-5, -3, -9, -1]))
    
    # Prueba con números decimales
    print(f"\nPrueba con números decimales:")
    print(find_min([3.14, 2.71, 1.414, 9.99]))
    
    try:
        # Prueba con arreglo vacío
        find_min([])
    except ValueError as e:
        print(f"\nManejo de error con arreglo vacío:")
        print(f"Error capturado: {e}")
#Arm 64
.data
    // Definir el arreglo de números
    array:  .quad   45, 23, 67, 12, 89, 34, 90, 5
    size:   .quad   8
    msg:    .string "El valor mínimo es: %ld\n"
    
.global _start
.text

// Función para encontrar el mínimo
.global find_min
.type find_min, %function
find_min:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    ldr x2, [x0]        // Primer elemento como mínimo
    mov x3, #1          // Índice inicial
    
min_loop:
    cmp x3, x1          // Comparar con tamaño
    bge min_done        // Si terminamos, salir
    
    ldr x4, [x0, x3, lsl #3]  // Cargar siguiente elemento
    cmp x4, x2          // Comparar con mínimo actual
    csel x2, x4, x2, lt // Actualizar mínimo si es menor
    
    add x3, x3, #1      // Incrementar índice
    b min_loop
    
min_done:
    mov x0, x2          // Retornar mínimo
    ret

// Programa principal
_start:
    // Preparar argumentos para find_min
    adrp x0, array      // Cargar dirección del arreglo
    add x0, x0, :lo12:array
    ldr x1, size        // Cargar tamaño del arreglo
    
    // Llamar a find_min
    bl find_min
    
    // Guardar el resultado para printf
    mov x1, x0          // Mover resultado a x1 para printf
    
    // Preparar printf
    adrp x0, msg        // Cargar dirección del mensaje
    add x0, x0, :lo12:msg
    bl printf
    
    // Salir del programa
    mov x0, #0          // Código de retorno 0
    mov x8, #93         // Syscall exit
    svc #0

    #Asciinema 
    https://asciinema.org/a/wSROz4fHEXe2WniCVT2gaVj4S
