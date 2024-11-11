.global _start
.section .text

_start:
    // Abrir archivo
    adr x0, filename    // nombre del archivo
    mov x1, #0x41       // flags: O_WRONLY | O_CREAT
    mov x2, #0644       // permisos
    mov x8, #56         // syscall openat
    mov x3, #-100       // AT_FDCWD
    svc #0
    
    // Guardar file descriptor
    mov x19, x0
    
    // Escribir en archivo
    mov x0, x19         // file descriptor
    adr x1, message     // mensaje a escribir
    adr x2, msg_len     // longitud del mensaje
    ldr x2, [x2]
    mov x8, #64         // syscall write
    svc #0
    
    // Cerrar archivo
    mov x0, x19         // file descriptor
    mov x8, #57         // syscall close
    svc #0
    
    // Salir
    mov x8, #93
    svc #0

.section .data
    filename: .asciz "output.txt"
    message: .asciz "Mensaje de prueba\n"
    msg_len: .quad . - message
    .align 4
