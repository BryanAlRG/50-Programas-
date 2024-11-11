.global _start
.section .text

_start:
    bl measure_time
    mov x8, #93
    svc #0

measure_time:
    // Guardar tiempo inicial
    mrs x0, CNTPCT_EL0      // Leer contador de tiempo inicial
    str x0, [x3]            // Guardar en memoria
    
    // Ejecutar función a medir
    bl function_to_measure
    
    // Guardar tiempo final
    mrs x1, CNTPCT_EL0      // Leer contador de tiempo final
    
    // Calcular diferencia
    ldr x0, [x3]            // Cargar tiempo inicial
    sub x0, x1, x0          // Calcular diferencia
    
    ret

function_to_measure:
    // Función ejemplo para medir
    mov x0, #0
    mov x1, #1000
loop:
    add x0, x0, #1
    cmp x0, x1
    bne loop
    ret

.section .data
    start_time: .quad 0
    end_time: .quad 0
    elapsed_time: .quad 0
