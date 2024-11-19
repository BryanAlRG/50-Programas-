# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Transposición de una matriz	
#Python 

#Arm
.global matrix_transpose
.type matrix_transpose, %function

matrix_transpose:
    // x0 = matriz original
    // x1 = matriz resultado
    // x2 = filas
    // x3 = columnas
    mov x4, #0              // i (filas)
    
outer_loop:
    cmp x4, x2
    bge trans_done
    
    mov x5, #0              // j (columnas)
inner_loop:
    cmp x5, x3
    bge next_row
    
    // Calcular índices
    mul x6, x4, x3          // i * cols
    add x6, x6, x5          // + j
    lsl x6, x6, #3          // * 8 (bytes)
    ldr x7, [x0, x6]        // Cargar elemento
    
    mul x6, x5, x2          // j * rows
    add x6, x6, x4          // + i
    lsl x6, x6, #3          // * 8 (bytes)
    str x7, [x1, x6]        // Guardar elemento transpuesto
    
    add x5, x5, #1
    b inner_loop
    
next_row:
    add x4, x4, #1
    b outer_loop
    
trans_done:
    ret

#Asciinema 
https://asciinema.org/a/ZGkEXMsLedABHCMemZKMS9OrE
