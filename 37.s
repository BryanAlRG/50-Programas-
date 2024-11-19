# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Implementar una pila usando un arreglo
#Python 
class Pila:
    def __init__(self):
        # Inicializar la pila como una lista vacía
        self.pila = []

    def esta_vacia(self):
        # Verificar si la pila está vacía
        return len(self.pila) == 0

    def apilar(self, valor):
        # Agregar un elemento al final de la pila
        self.pila.append(valor)

    def desapilar(self):
        # Eliminar y retornar el último elemento de la pila
        if not self.esta_vacia():
            return self.pila.pop()
        else:
            print("La pila está vacía. No se puede desapilar.")
            return None

    def cima(self):
        # Retornar el último elemento de la pila sin eliminarlo
        if not self.esta_vacia():
            return self.pila[-1]
        else:
            print("La pila está vacía.")
            return None

    def tamaño(self):
        # Retornar el número de elementos en la pila
        return len(self.pila)

    def mostrar(self):
        # Mostrar todos los elementos de la pila
        return self.pila

# Función principal para interactuar con la pila
def main():
    pila = Pila()

    while True:
        print("\nOperaciones disponibles:")
        print("1. Apilar")
        print("2. Desapilar")
        print("3. Ver la cima")
        print("4. Ver tamaño de la pila")
        print("5. Ver pila completa")
        print("6. Salir")

        opcion = input("Selecciona una opción (1-6): ")

        if opcion == '1':
            valor = int(input("Ingresa el valor a apilar: "))
            pila.apilar(valor)
            print(f"El valor {valor} ha sido apilado.")

        elif opcion == '2':
            valor = pila.desapilar()
            if valor is not None:
                print(f"El valor {valor} ha sido desapilado.")

        elif opcion == '3':
            cima = pila.cima()
            if cima is not None:
                print(f"La cima de la pila es: {cima}")

        elif opcion == '4':
            print(f"El tamaño de la pila es: {pila.tamaño()}")

        elif opcion == '5':
            print(f"Contenido de la pila: {pila.mostrar()}")

        elif opcion == '6':
            print("Saliendo...")
            break

        else:
            print("Opción no válida. Intenta de nuevo.")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Arm
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
#Asciinema 
https://asciinema.org/a/HDUYp2UGMYeKmymfkyGa9Ne6l
