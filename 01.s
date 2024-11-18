#Instituto Tecnológico de Tijuana
#Departamento de Sistemas y computación
#Materia: Lenguajes de interfaz
#Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
#No. control 22210345
#Nombre del programa: Convertir temperatura de Celsius a Fahrenheit
#Descripcion de la actividad: programa que convierte celsius a Fahrenheit

.section .data
prompt_celsius: .asciz "Ingrese la temperatura en Celsius (o 'q' para salir): "
prompt_error:   .asciz "Error: Entrada no válida. Por favor ingrese un número.\n"
prompt_exit:    .asciz "¡Gracias por usar el convertidor!\n"
result_msg:     .asciz "\n%f°C es igual a %f°F\n"
freezing_point: .asciz "(Punto de congelación del agua)\n"
boiling_point:  .asciz "(Punto de ebullición del agua)\n"

.section .bss
input_buffer: .space 64  // Buffer para la entrada del usuario

.section .text
.global _start

_start:
    // Imprimir el prompt de entrada
loop_prompt:
    ldr x0, =prompt_celsius
    bl print_string

    // Leer entrada del usuario
    ldr x1, =input_buffer
    mov x2, #64
    bl read_input

    // Verificar si el usuario quiere salir ('q')
    ldr x0, =input_buffer
    bl check_exit
    cbz w0, exit_program

    // Convertir entrada a número (flotante)
    ldr x0, =input_buffer
    bl string_to_float
    cbz w0, handle_error  // Si retorna 0, manejar error

    // Guardar valor en registro
    fmov s0, w1

    // Convertir Celsius a Fahrenheit: (C * 9/5) + 32
    fmov s1, #9.0
    fdiv s1, s1, #5.0
    fmul s0, s0, s1
    fadd s0, s0, #32.0

    // Imprimir resultado
    ldr x0, =result_msg
    fmov x1, s0
    bl printf_float

    // Verificar puntos de congelación y ebullición
    fmov s1, #0.0
    fcmp s0, s1
    beq freezing_msg

    fmov s1, #100.0
    fcmp s0, s1
    beq boiling_msg

    b loop_prompt

freezing_msg:
    ldr x0, =freezing_point
    bl print_string
    b loop_prompt

boiling_msg:
    ldr x0, =boiling_point
    bl print_string
    b loop_prompt

handle_error:
    ldr x0, =prompt_error
    bl print_string
    b loop_prompt

exit_program:
    ldr x0, =prompt_exit
    bl print_string
    mov x8, #60  // syscall_exit
    mov x0, #0   // Exit code 0
    svc #0

// --- Subrutinas auxiliares ---
print_string:
    // x0 = dirección de cadena
    mov x8, #64  // syscall_write
    mov x1, x0   // Cadena
    mov x2, #64  // Tamaño arbitrario (cadena termina en '\0')
    svc #0
    ret

read_input:
    // x1 = buffer, x2 = tamaño
    mov x8, #63  // syscall_read
    mov x0, #0   // stdin
    svc #0
    ret

check_exit:
    // x0 = dirección de entrada
    ldrb w1, [x0]    // Leer primer carácter
    cmp w1, #'q'
    cset w0, eq      // Retornar 1 si es 'q', de lo contrario 0
    ret

string_to_float:
    // Conversión de cadena a flotante (simplificado)
    // Aquí podrías implementar un analizador manual o delegar a una librería
    // Para este ejemplo, retornar 0 para indicar error
    mov w0, #0
    ret

printf_float:
    // Implementar impresión de flotante con formato
    // (Podría delegarse a una biblioteca externa si es necesario)
    ret

--------------------------------------------------------------------------------------------------------------------

def celsius_a_fahrenheit(celsius):
    """
    Convierte una temperatura de Celsius a Fahrenheit.
    
    Args:
        celsius (float): Temperatura en grados Celsius
        
    Returns:
        float: Temperatura en grados Fahrenheit
    """
    return (celsius * 9/5) + 32

def validar_temperatura(input_str):
    """
    Valida que la entrada sea un número válido.
    
    Args:
        input_str (str): String a validar
        
    Returns:
        float: Número convertido si es válido
        
    Raises:
        ValueError: Si la entrada no es un número válido
    """
    try:
        temp = float(input_str)
        return temp
    except ValueError:
        raise ValueError("Por favor ingrese un número válido")

def main():
    """Función principal del programa"""
    while True:
        try:
            # Solicitar entrada al usuario
            print("\n=== Convertidor de Temperatura ===")
            celsius = input("Ingrese la temperatura en Celsius (o 'q' para salir): ")
            
            # Verificar si el usuario quiere salir
            if celsius.lower() == 'q':
                print("¡Gracias por usar el convertidor!")
                break
            
            # Validar y convertir la temperatura
            temp_celsius = validar_temperatura(celsius)
            temp_fahrenheit = celsius_a_fahrenheit(temp_celsius)
            
            # Mostrar resultado con formato
            print(f"\n{temp_celsius}°C es igual a {temp_fahrenheit:.2f}°F")
            
            # Agregar información adicional sobre el punto de congelación/ebullición
            if temp_celsius == 0:
                print("(Punto de congelación del agua)")
            elif temp_celsius == 100:
                print("(Punto de ebullición del agua)")
                
        except ValueError as e:
            print(f"Error: {e}")
        except KeyboardInterrupt:
            print("\n\nPrograma interrumpido por el usuario")
            break

if __name__ == "__main__":
    main()
