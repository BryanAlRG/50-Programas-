.global _start
.section .text

_start:
    // Ejemplo: 15 + 7
    mov x0, #15         // Primer operando
    mov x1, #7          // Segundo operando
    mov x2, #1          // Operación (1=suma, 2=resta, 3=mult, 4=div)
    bl calculator
    mov x8, #93         // Syscall exit
    svc #0

calculator:
    // x0, x1 contienen operandos
    // x2 contiene tipo de operación
    // x0 contendrá el resultado
    
    cmp x2, #1
    beq suma
    cmp x2, #2
    beq resta
    cmp x2, #3
    beq multiplicacion
    cmp x2, #4
    beq division
    b end

suma:
    add x0, x0, x1
    b end

resta:
    sub x0, x0, x1
    b end

multiplicacion:
    mul x0, x0, x1
    b end

division:
    // Verificar división por cero
    cmp x1, #0
    beq division_error
    udiv x0, x0, x1
    b end

division_error:
    mov x0, #-1         // Código de error

end:
    ret

.section .data
    result: .quad 0
