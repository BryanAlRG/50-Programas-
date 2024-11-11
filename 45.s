.global _start
.section .text

_start:
    // Ejemplo: verificar si 153 es número Armstrong
    mov x0, #153        // Número a verificar
    bl is_armstrong
    mov x8, #93         // Syscall exit
    svc #0

is_armstrong:
    // x0 contiene el número a verificar
    mov x1, x0          // Copia para procesar dígitos
    mov x2, x0          // Copia para contar dígitos
    mov x3, #0          // Contador de dígitos
    mov x4, #0          // Suma de potencias
    
    // Contar dígitos
count_digits:
    udiv x2, x2, #10
    add x3, x3, #1
    cbnz x2, count_digits
    
    // Procesar cada dígito
process_digits:
    udiv x2, x1, #10    // x2 = número / 10
    msub x5, x2, #10, x1 // x5 = dígito actual
    
    // Calcular potencia del dígito
    mov x6, #1          // Resultado de la potencia
    mov x7, x3          // Exponente (número de dígitos)
power_loop:
    mul x6, x6, x5
    sub x7, x7, #1
    cbnz x7, power_loop
    
    add x4, x4, x6      // Sumar potencia al resultado
    mov x1, x2          // Preparar siguiente dígito
    cbnz x1, process_digits
    
    // Verificar si es Armstrong
    cmp x0, x4
    cset x0, eq         // x0 = 1 si es Armstrong, 0 si no
    ret

.section .data
    result: .quad 0
