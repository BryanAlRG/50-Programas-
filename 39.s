# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Convertir decimal a binario
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
#Arm 64
.global decimal_to_binary
.type decimal_to_binary, %function

decimal_to_binary:
    // x0 = número decimal
    // x1 = dirección buffer resultado
    mov x2, x0              // Copiar número
    mov x3, #0              // Contador de bits
    mov x4, #63             // Posición en buffer (empezar del final)
    
convert_loop:
    and x5, x2, #1          // Obtener último bit
    add x5, x5, #'0'        // Convertir a ASCII
    strb w5, [x1, x4]       // Guardar en buffer
    
    lsr x2, x2, #1          // Desplazar número
    sub x4, x4, #1          // Mover posición
    add x3, x3, #1          // Incrementar contador
    
    cbnz x2, convert_loop   // Si quedan bits, continuar
    
    // Mover resultado al inicio del buffer
    add x4, x4, #1          // Ajustar posición
    mov x5, #0              // Índice destino
    
move_loop:
    ldrb w6, [x1, x4]       // Cargar bit
    strb w6, [x1, x5]       // Mover al inicio
    
    add x4, x4, #1
    add x5, x5, #1
    cmp x3, x5
    bne move_loop
    
    // Añadir null terminator
    mov x6, #0
    strb w6, [x1, x5]
    
    mov x0, x3              // Retornar longitud
    ret

#Asciinema 
https://asciinema.org/a/IjEOIaVp1qBGRGoDZPcQOmJcR
