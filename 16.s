# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa:	Ordenamiento burbuja	
#Python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n - 1):  # Ciclo exterior
        for j in range(n - i - 1):  # Ciclo interior
            if arr[j] > arr[j + 1]:  # Comparar elementos adyacentes
                # Intercambiar si están en el orden incorrecto
                arr[j], arr[j + 1] = arr[j + 1], arr[j]

if __name__ == "__main__":
    # Leer entrada del usuario
    arr = input("Introduce los números separados por espacios: ").split()
    # Convertir a enteros
    arr = [int(x) for x in arr]

    print("Arreglo original:", arr)
    bubble_sort(arr)
    print("Arreglo ordenado:", arr)

Python
.global bubble_sort
.type bubble_sort, %function

bubble_sort:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    sub x1, x1, #1      // n-1 para el límite exterior
    mov x2, x1          // Contador exterior
    
outer_loop:
    cbz x2, done        // Si contador exterior es 0, terminamos
    mov x3, #0          // Índice para loop interno
    
inner_loop:
    cmp x3, x2          // Comparar con límite
    bge outer_done      // Si terminamos loop interno
    
    // Cargar elementos adyacentes
    ldr x4, [x0, x3, lsl #3]
    add x5, x3, #1
    ldr x6, [x0, x5, lsl #3]
    
    // Comparar y swap si necesario
    cmp x4, x6
    ble no_swap
    
    // Swap
    str x6, [x0, x3, lsl #3]
    str x4, [x0, x5, lsl #3]
    
no_swap:
    add x3, x3, #1      // Siguiente índice
    b inner_loop
    
outer_done:
    sub x2, x2, #1      // Decrementar contador exterior
    b outer_loop
    
done:
    ret

#Asciinema 
    https://asciinema.org/a/5U0zZUmQJE2GIKaoYwG72rjfY
    https://asciinema.org/a/aNXwWJ8knHHPX9OXCIS4seAfs
