# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Contar vocales y consonantes	
#Python
def count_vowels_consonants(s: str):
    vowels = "aeiou"
    consonants = "bcdfghjklmnpqrstvwxyz"
    
    vowel_count = 0
    consonant_count = 0
    
    for char in s:
        # Convertir a minúscula para simplificar la comparación
        char = char.lower()
        
        # Verificar si es vocal
        if char in vowels:
            vowel_count += 1
        # Verificar si es consonante
        elif char in consonants:
            consonant_count += 1
    
    return vowel_count, consonant_count

# Ejemplo de uso:
cadena = "Hello World"
vowels, consonants = count_vowels_consonants(cadena)
print(f"Vocales: {vowels}, Consonantes: {consonants}")

#Arm64
.global count_vowels_consonants
.type count_vowels_consonants, %function

count_vowels_consonants:
    // x0 = dirección de la cadena
    // Retorna: x0 = número de vocales, x1 = número de consonantes
    mov x2, x0              // Copiar dirección
    mov x3, #0              // Contador de vocales
    mov x4, #0              // Contador de consonantes
    
loop:
    ldrb w5, [x2], #1      // Cargar carácter y avanzar
    cbz w5, done           // Si es null, terminar
    
    // Convertir a minúscula si es necesario
    cmp w5, #'A'
    blt next
    cmp w5, #'Z'
    bgt check_vowel
    add w5, w5, #32        // Convertir a minúscula
    
check_vowel:
    cmp w5, #'a'
    beq is_vowel
    cmp w5, #'e'
    beq is_vowel
    cmp w5, #'i'
    beq is_vowel
    cmp w5, #'o'
    beq is_vowel
    cmp w5, #'u'
    beq is_vowel
    
    // Verificar si es consonante
    cmp w5, #'a'
    blt next
    cmp w5, #'z'
    bgt next
    add x4, x4, #1         // Incrementar consonantes
    b next
    
is_vowel:
    add x3, x3, #1         // Incrementar vocales
    
next:
    b loop
    
done:
    mov x0, x3             // Retornar número de vocales
    mov x1, x4             // Retornar número de consonantes
    ret
#Asciinema 
https://asciinema.org/a/E5qG99HYT8aSWk5OHD1delEfb
