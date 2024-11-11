.data
    stack_array: .skip 800    // Espacio para 100 elementos
    stack_top: .quad -1       // Tope de la pila

.text
// Push
.global stack_push
.type stack_push, %function
stack_push:
    // x0 = valor a insertar
    adr x1, stack_top
    ldr x2, [x1]              // Cargar tope actual
    
    add x2, x2, #1            // Incrementar tope
    cmp x2, #99               // Verificar overflow
    bgt push_error
    
    str x2, [x1]              // Actualizar tope
    
    adr x1, stack_array
    str x0, [x1, x2, lsl #3]  // Guardar valor
    
    mov x0, #1                // Éxito
    ret
    
push_error:
    mov x0, #0                // Error
    ret

// Pop
.global stack_pop
.type stack_pop, %function
stack_pop:
    adr x1, stack_top
    ldr x2, [x1]              // Cargar tope actual
    
    cmp x2, #-1               // Verificar underflow
    ble pop_error
    
    adr x3, stack_array
    ldr x0, [x3, x2, lsl #3]  // Obtener valor
    
    sub x2, x2, #1            // Decrementar tope
    str x2, [x1]              // Actualizar tope
    ret
    
pop_error:
    mov x0, #-1               // Error
    ret
