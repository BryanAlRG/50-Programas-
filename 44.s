# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Generación de números aleatorios (con semilla)
------------------------------------------------------------------------------------------------------------------------------------------
#Python 
import random

# 1. Generar un número aleatorio simple
numero_aleatorio = random.random()  # Flotante entre 0 y 1
print("Número aleatorio entre 0 y 1:", numero_aleatorio)

# 2. Generar un número entero aleatorio en un rango
numero_entero = random.randint(1, 10)  # Entero entre 1 y 10 (inclusive)
print("Número entero aleatorio:", numero_entero)

# 3. Usar una semilla para reproducibilidad
random.seed(42)  # Establece una semilla
print("Número con semilla 42:", random.random())

# Si usas la misma semilla, obtendrás el mismo número
random.seed(42)
print("Mismo número con la misma semilla:", random.random())

# 4. Generar una lista de números aleatorios
lista_aleatoria = [random.randint(1, 100) for _ in range(5)]
print("Lista de 5 números aleatorios:", lista_aleatoria)

# 5. Método más moderno: módulo random con secrets (más seguro)
import secrets
numero_seguro = secrets.randbelow(100)  # Número aleatorio entre 0 y 99
print("Número aleatorio seguro:", numero_seguro)

-----------------------------------------------------------------------------------------------------------------------------------------
#Ensamblador 
.global _start
.section .text

_start:
    // Usar timestamp como semilla inicial
    mrs x0, CNTPCT_EL0  // Leer contador de tiempo
    bl random_generator
    mov x8, #93         // Syscall exit
    svc #0

random_generator:
    // Implementación del algoritmo linear congruential generator (LCG)
    // Fórmula: next = (a * seed + c) mod m
    // Usando valores comunes: a = 1664525, c = 1013904223, m = 2^32
    
    // Guardar semilla inicial
    mov x1, #1664525        // multiplicador (a)
    mov x2, #1013904223     // incremento (c)
    
    // Calcular siguiente número
    mul x0, x0, x1          // x0 = seed * a
    add x0, x0, x2          // x0 = (seed * a) + c
    
    // No necesitamos hacer mod 2^32 explícitamente ya que
    // los registros de 32 bits hacen esto automáticamente
    
    ret

.section .data
    seed: .quad 0
    result: .quad 0

----------------------------------------------------------------------------------------------------------------------------------------
#Asciinema 
https://asciinema.org/a/Astxzlb7B0XkAUG325DOifpG6
