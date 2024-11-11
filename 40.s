// Conversión de Binario a Decimal en ARM64
.global _start
.section .text

_start:
    // Ejemplo: convertir 1101 (13 en decimal)
    mov x0, #13         // Número binario a convertir
    bl binary_to_decimal
    mov x8, #93         // Syscall exit
    svc #0

binary_to_decimal:
    // x0 contiene el número binario de entrada
    // x1 contendrá el resultado decimal
    mov x1, #0          // Inicializar resultado
    mov x2, #1          // Inicializar multiplicador (potencia de 2)
    
convert_loop:
    and x3, x0, #1      // Obtener el bit menos significativo
    mul x3, x3, x2      // Multiplicar por la potencia de 2 correspondiente
    add x1, x1, x3      // Añadir al resultado
    lsr x0, x0, #1      // Desplazar el número binario a la derecha
    lsl x2, x2, #1      // Multiplicar la potencia por 2
    cbnz x0, convert_loop  // Continuar si quedan bits

    mov x0, x1          // Mover resultado a x0 para retorno
    ret

.section .data
    result: .quad 0
