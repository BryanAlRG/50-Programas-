.data
    queue_array: .skip 800    // Espacio para 100 elementos
    queue_front: .quad 0      // Frente de la cola
    queue_rear: .quad -1      // Final de la cola
    queue_size: .quad 0       // Tamaño actual

.text
// Enqueue
.global queue_enqueue
.type queue_enqueue, %function
queue_enqueue:
    // x0 = valor a insertar
    adr x1, queue_size
    ldr x2, [x1]              // Cargar tamaño actual
    
    cmp x2, #99               // Verificar overflow
    bgt enq_error
    
    adr x3, queue_rear
    ldr x4, [x3]              // Cargar posición final
    
    add x4, x4, #1            // Incrementar rear
    cmp x4, #99               // Verificar wrap-around
    ble no_wrap
    mov x4, #0                // Volver al inicio
    
no_wrap:
    str x4, [x3]              // Actualizar rear
    
    adr x3, queue_array
    str x0, [x3, x4, lsl #3]  // Guardar valor
    
    add x2, x2, #1            // Incrementar tamaño
    str x2, [x1]              // Actualizar tamaño
    
    mov x0, #1                // Éxito
    ret
    
enq_error:
    mov x0, #0                // Error
    ret

// Dequeue
.global queue_dequeue
.type queue_dequeue, %function
queue_dequeue:
    adr x1, queue_size
    ldr x2, [x1]              // Cargar tamaño actual
    
    cmp x2, #0                // Verificar underflow
    ble deq_error
    
    adr x3, queue_front
    ldr x4, [x3]              // Cargar frente
    
    adr x5, queue_array
    ldr x0, [x5, x4, lsl #3]  // Obtener valor
    
    add x4, x4, #1            // Incrementar front
    cmp x4, #99               // Verificar wrap-around
    ble no_wrap_deq
    mov x4, #0                // Volver al inicio
    
no_wrap_deq:
    str x4, [x3]              // Actualizar front
    
    sub x2, x2, #1            // Decrementar tamaño
    str x2, [x1]              // Actualizar tamaño
    ret
    
deq_error:
    mov x0, #-1               // Error
    ret
