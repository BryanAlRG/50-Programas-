# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Implementar una pila usando un arreglo
#Python 
class Cola:
    def __init__(self):
        # Inicializar la cola como una lista vacía
        self.cola = []

    def esta_vacia(self):
        # Verificar si la cola está vacía
        return len(self.cola) == 0

    def encolar(self, valor):
        # Agregar un elemento al final de la cola
        self.cola.append(valor)

    def desencolar(self):
        # Eliminar y retornar el primer elemento de la cola
        if not self.esta_vacia():
            return self.cola.pop(0)
        else:
            print("La cola está vacía. No se puede desencolar.")
            return None

    def frente(self):
        # Retornar el primer elemento de la cola sin eliminarlo
        if not self.esta_vacia():
            return self.cola[0]
        else:
            print("La cola está vacía.")
            return None

    def tamaño(self):
        # Retornar el número de elementos en la cola
        return len(self.cola)

    def mostrar(self):
        # Mostrar todos los elementos de la cola
        return self.cola

# Función principal para interactuar con la cola
def main():
    cola = Cola()

    while True:
        print("\nOperaciones disponibles:")
        print("1. Encolar")
        print("2. Desencolar")
        print("3. Ver el frente")
        print("4. Ver tamaño de la cola")
        print("5. Ver cola completa")
        print("6. Salir")

        opcion = input("Selecciona una opción (1-6): ")

        if opcion == '1':
            valor = int(input("Ingresa el valor a encolar: "))
            cola.encolar(valor)
            print(f"El valor {valor} ha sido encolado.")

        elif opcion == '2':
            valor = cola.desencolar()
            if valor is not None:
                print(f"El valor {valor} ha sido desencolado.")

        elif opcion == '3':
            frente = cola.frente()
            if frente is not None:
                print(f"El frente de la cola es: {frente}")

        elif opcion == '4':
            print(f"El tamaño de la cola es: {cola.tamaño()}")

        elif opcion == '5':
            print(f"Contenido de la cola: {cola.mostrar()}")

        elif opcion == '6':
            print("Saliendo...")
            break

        else:
            print("Opción no válida. Intenta de nuevo.")

# Llamar a la función principal
if __name__ == "__main__":
    main()

#Ensamblador 
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
#Asciinema 
https://asciinema.org/a/BrlezBydq4VGWPYghcXF5LBa8
