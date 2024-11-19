# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Rotación de un arreglo (izquierda/derecha)
#Python 
# Función para rotar el arreglo a la izquierda
def rotate_left(arr, n):
    n = n % len(arr)  # Asegurarse de que n no sea mayor que el tamaño del arreglo
    return arr[n:] + arr[:n]

# Función para rotar el arreglo a la derecha
def rotate_right(arr, n):
    n = n % len(arr)  # Asegurarse de que n no sea mayor que el tamaño del arreglo
    return arr[-n:] + arr[:-n]

# Función principal para ingresar datos y mostrar el resultado
def main():
    # Solicitar al usuario que ingrese los elementos del arreglo
    arr = list(map(int, input("Ingresa los elementos del arreglo separados por espacio: ").split()))
    
    # Solicitar la dirección y número de posiciones para rotar
    direction = input("¿Quieres rotar a la izquierda o derecha? (izquierda/derecha): ").strip().lower()
    n = int(input("¿Cuántas posiciones deseas rotar? "))

    if direction == 'izquierda':
        rotated_arr = rotate_left(arr, n)
    elif direction == 'derecha':
        rotated_arr = rotate_right(arr, n)
    else:
        print("Dirección inválida. Usa 'izquierda' o 'derecha'.")
        return

    # Mostrar el arreglo rotado
    print(f"El arreglo rotado es: {rotated_arr}")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Ensamblador 
.global array_rotate
.type array_rotate, %function

array_rotate:
    // x0 = dirección del arreglo
    // x1 = tamaño del arreglo
    // x2 = posiciones a rotar (positivo = derecha, negativo = izquierda)
    stp x29, x30, [sp, #-16]!
    
    // Normalizar rotación
    cmp x2, #0
    bge normalize_right
    
    // Rotación izquierda
    neg x2, x2             // Hacer positivo
    b normalize_done
    
normalize_right:
    // Rotación derecha
    sub x2, x1, x2         // Convertir a rotación izquierda equivalente
    
normalize_done:
    // Asegurar que rotación esté en rango
    udiv x3, x2, x1
    msub x2, x3, x1, x2    // x2 = x2 % tamaño
    
    // Realizar rotación
    // 1. Revertir todo el arreglo
    mov x3, #0             // inicio
    sub x4, x1, #1         // fin
    bl reverse_section
    
    // 2. Revertir primera parte
    mov x3, #0
    sub x4, x2, #1
    bl reverse_section
    
    // 3. Revertir segunda parte
    mov x3, x2
    sub x4, x1, #1
    bl reverse_section
    
    ldp x29, x30, [sp], #16
    ret

// Función auxiliar para revertir sección
reverse_section:
    cmp x3, x4
    bge rev_done
    
    ldr x5, [x0, x3, lsl #3]
    ldr x6, [x0, x4, lsl #3]
    str x6, [x0, x3, lsl #3]
    str x5, [x0, x4, lsl #3]
    
    add x3, x3, #1
    sub x4, x4, #1
    b reverse_section
    
rev_done:
    ret
#Asciinema 
https://asciinema.org/a/5Aw3Us7Q8VmkXmNGDKIMKkqYU
