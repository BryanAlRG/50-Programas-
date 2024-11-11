.global power
.type power, %function

power:
    // x0 = base (x)
    // x1 = exponente (n)
    mov x2, #1              // Resultado
    cbz x1, done           // Si exponente es 0, retornar 1
    
power_loop:
    tst x1, #1             // Verificar si exponente es impar
    beq even_exp
    mul x2, x2, x0         // Multiplicar resultado por base
    
even_exp:
    mul x0, x0, x0         // Cuadrar la base
    lsr x1, x1, #1         // Dividir exponente por 2
    cbnz x1, power_loop    // Si exponente no es 0, continuar
    
done:
    mov x0, x2             // Retornar resultado
    ret
