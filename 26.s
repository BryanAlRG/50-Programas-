# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Operaciones AND, OR, XOR a nivel de bits
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

#Arm
.global bit_operations
.type bit_operations, %function

bit_operations:
    // x0 = primer número
    // x1 = segundo número
    // Retorna: x0 = AND, x1 = OR, x2 = XOR
    mov x3, x0             // Guardar primer número
    mov x4, x1             // Guardar segundo número
    
    // Realizar operaciones
    and x0, x3, x4         // AND
    orr x1, x3, x4         // OR
    eor x2, x3, x4         // XOR
    
    ret

#Asciinema 
https://asciinema.org/a/Ubb3vJhpXKU8kH6IDA18tvUMP
