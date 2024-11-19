# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: CCalculadora simple (Suma, Resta, Multiplicación, División)
#Python 
def suma(a, b):
    return a + b

def resta(a, b):
    return a - b

def multiplicacion(a, b):
    return a * b

def division(a, b):
    if b != 0:
        return a / b
    else:
        return "Error: División por cero"

def calculadora():
    print("Operaciones disponibles:")
    print("1. Suma")
    print("2. Resta")
    print("3. Multiplicación")
    print("4. División")
    
    # Leer la operación deseada
    operacion = input("Elige la operación (1/2/3/4): ")

    # Leer los dos números
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))

    if operacion == '1':
        print(f"{num1} + {num2} = {suma(num1, num2)}")
    elif operacion == '2':
        print(f"{num1} - {num2} = {resta(num1, num2)}")
    elif operacion == '3':
        print(f"{num1} * {num2} = {multiplicacion(num1, num2)}")
    elif operacion == '4':
        print(f"{num1} / {num2} = {division(num1, num2)}")
    else:
        print("Operación no válida")

# Ejecutar la calculadora
calculadora()

#Arm
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
#Asciinema 
https://asciinema.org/a/e32CJuDnbiGFJZ1AXubAgxh8I
