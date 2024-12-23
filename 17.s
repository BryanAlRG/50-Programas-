# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa:	Ordenamiento por selección		
#Python 
def selection_sort(arr):
    n = len(arr)
    for i in range(n - 1):  # Ciclo exterior
        min_index = i
        for j in range(i + 1, n):  # Buscar el mínimo
            if arr[j] < arr[min_index]:
                min_index = j
        
        # Hacer el intercambio si es necesario
        if i != min_index:
            arr[i], arr[min_index] = arr[min_index], arr[i]

if __name__ == "__main__":
    # Leer entrada del usuario
    arr = input("Introduce los números separados por espacios: ").split()
    # Convertir a enteros
    arr = [int(x) for x in arr]

    print("Arreglo original:", arr)
    selection_sort(arr)
    print("Arreglo ordenado:", arr)

#Arm64
.global selection_sort
.type selection_sort, %function

selection_sort:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    sub x1, x1, #1      // n-1 para el límite
    mov x2, #0          // Índice exterior
    
outer_loop:
    cmp x2, x1          // Comparar con límite
    bge done            // Si terminamos, salir
    
    mov x3, x2          // Índice del mínimo
    add x4, x2, #1      // Índice para buscar
    
    // Buscar el mínimo
find_min:
    cmp x4, x1
    bgt swap_min
    
    ldr x5, [x0, x4, lsl #3]    // Elemento actual
    ldr x6, [x0, x3, lsl #3]    // Mínimo actual
    
    cmp x5, x6
    csel x3, x4, x3, lt         // Actualizar índice del mínimo
    
    add x4, x4, #1
    b find_min
    
swap_min:
    // Swap con la primera posición si es necesario
    cmp x2, x3
    beq next_outer
    
    ldr x5, [x0, x2, lsl #3]
    ldr x6, [x0, x3, lsl #3]
    str x6, [x0, x2, lsl #3]
    str x5, [x0, x3, lsl #3]
    
next_outer:
    add x2, x2, #1
    b outer_loop
    
done:
    ret

#Asciinema 
https://asciinema.org/a/4w6Ntm4LU3Ejq02L2Uridpwlj
