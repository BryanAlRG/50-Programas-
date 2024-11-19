#Instituto Tecnológico de Tijuana
#Departamento de Sistemas y computación
#Materia: Lenguajes de interfaz
#Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
#No. control 22210345
#Nombre del programa: Convertir temperatura de Celsius a Fahrenheit
#Descripcion de la actividad: programa que convierte celsius a Fahrenheit
#Alto nivel 
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

-------------------------------------------------------------------------------------------------------------------------------
#ARM64
.data
prompt_celsius: .asciz "Ingrese la temperatura en Celsius (o 'q' para salir): "
prompt_error:   .asciz "Error: Entrada no válida. Por favor ingrese un número.\n"
prompt_exit:    .asciz "¡Gracias por usar el convertidor!\n"
result_msg:     .asciz "\n%.2f°C es igual a %.2f°F\n"
freezing_point: .asciz "(Punto de congelación del agua)\n"
boiling_point:  .asciz "(Punto de ebullición del agua)\n"

.bss
input_buffer: .space 64  // Buffer para la entrada del usuario

.text
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

    // Guardar valor en registro flotante
    fmov s0, w1

    // Convertir Celsius a Fahrenheit: (C * 9/5) + 32
    ldr w2, =9          // Cargar 9 en un registro general
    scvtf s1, w2        // Convertir 9 a flotante
    ldr w2, =5          // Cargar 5 en un registro general
    scvtf s2, w2        // Convertir 5 a flotante
    fdiv s1, s1, s2     // s1 = 9 / 5
    fmul s0, s0, s1     // s0 = C * (9 / 5)
    ldr w2, =32         // Cargar 32 en un registro general
    scvtf s1, w2        // Convertir 32 a flotante
    fadd s0, s0, s1     // s0 = (C * (9 / 5)) + 32

    // Imprimir resultado
    ldr x0, =result_msg
    fmov w1, s0
    bl printf_float

    // Verificar puntos de congelación y ebullición
    ldr w2, =0          // Cargar 0
    scvtf s1, w2        // Convertir 0 a flotante
    fcmp s0, s1         // Comparar con 0
    b.eq freezing_msg

    ldr w2, =100        // Cargar 100
    scvtf s1, w2        // Convertir 100 a flotante
    fcmp s0, s1         // Comparar con 100
    b.eq boiling_msg

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
    mov x8, #64  // syscall_write
    mov x1, x0   // Dirección de la cadena
    mov x2, #64  // Tamaño arbitrario (la cadena termina en '\0')
    svc #0
    ret

read_input:
    mov x8, #63  // syscall_read
    mov x0, #0   // stdin
    svc #0
    ret

check_exit:
    ldrb w1, [x0]    // Leer primer carácter
    cmp w1, #'q'
    cset w0, eq      // Retornar 1 si es 'q', de lo contrario 0
    ret

string_to_float:
    mov w0, #0       // No implementado en detalle
    ret

printf_float:
    ret


--------------------------------------------------------------------------------------------------------------------
#Aciinema


