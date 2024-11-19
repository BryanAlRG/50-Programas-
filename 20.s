# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Multiplicación de matrices	
#Python 
def matrix_multiply(A, B):
    # Verificar dimensiones de las matrices
    rows_A = len(A)
    cols_A = len(A[0])
    rows_B = len(B)
    cols_B = len(B[0])

    if cols_A != rows_B:
        raise ValueError("El número de columnas de A debe ser igual al número de filas de B")

    # Inicializar la matriz resultado con ceros
    result = [[0] * cols_B for _ in range(rows_A)]

    # Multiplicación de matrices
    for i in range(rows_A):  # Filas de A
        for j in range(cols_B):  # Columnas de B
            for k in range(cols_A):  # Columnas de A / Filas de B
                result[i][j] += A[i][k] * B[k][j]

    return result

if __name__ == "__main__":
    # Matrices de entrada (puedes cambiarlas)
    A = [
        [1, 2, 3],
        [4, 5, 6]
    ]
    B = [
        [7, 8],
        [9, 10],
        [11, 12]
    ]

    print("Matriz A:")
    for row in A:
        print(row)

    print("\nMatriz B:")
    for row in B:
        print(row)

    # Multiplicar matrices
    try:
        result = matrix_multiply(A, B)
        print("\nResultado (A * B):")
        for row in result:
            print(row)
    except ValueError as e:
        print(e)


.global matrix_multiply
.type matrix_multiply, %function

matrix_multiply:
    // x0 = matriz A
    // x1 = matriz B
    // x2 = matriz resultado
    // x3 = filas A
    // x4 = columnas A/filas B
    // x5 = columnas B
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x6, #0              // i (filas)
outer_loop:
    cmp x6, x3
    bge mult_done
    
    mov x7, #0              // j (columnas)
middle_loop:
    cmp x7, x5
    bge next_i
    
    mov x8, #0              // k (suma)
    mov x9, #0              // acumulador
    
inner_loop:
    cmp x8, x4
    bge store_result
    
    // Calcular índices
    mul x10, x6, x4         // i * colsA
    add x10, x10, x8        // + k
    lsl x10, x10, #3        // * 8 (bytes)
    ldr x11, [x0, x10]      // A[i][k]
    
    mul x10, x8, x5         // k * colsB
    add x10, x10, x7        // + j
    lsl x10, x10, #3        // * 8 (bytes)
    ldr x12, [x1, x10]      // B[k][j]
    
    mul x13, x11, x12       // A[i][k] * B[k][j]
    add x9, x9, x13         // Acumular
    
    add x8, x8, #1
    b inner_loop
    
store_result:
    mul x10, x6, x5         // i * colsB
    add x10, x10, x7        // + j
    lsl x10, x10, #3        // * 8 (bytes)
    str x9, [x2, x10]       // C[i][j] = acumulador
    
    add x7, x7, #1
    b middle_loop
    
next_i:
    add x6, x6, #1
    b outer_loop
    
mult_done:
    ldp x29, x30, [sp], #16
    ret

#Asciinema 
https://asciinema.org/a/WlXe1ehqNpzv6mZ0wYLnkj2bs
