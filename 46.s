# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y computación
# Materia: Lenguajes de interfaz
# Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
# No. control 22210345
# Nombre del programa: Encontrar prefijo común más largo en cadenas
----------------------------------------------------------------------------------------------------------------------------------------
#Python 
def prefijo_comun_1(lista_cadenas):
    """
    Método 1: Usando min() y max() con comparación de caracteres
    """
    if not lista_cadenas:
        return ""
    
    # Encuentra el prefijo comparando el primer y último string ordenados lexicográficamente
    min_str = min(lista_cadenas)
    max_str = max(lista_cadenas)
    
    # Compara caracteres hasta donde difieran
    for i, char in enumerate(min_str):
        if char != max_str[i]:
            return min_str[:i]
    
    return min_str

def prefijo_comun_2(lista_cadenas):
    """
    Método 2: Usando zip() y comparación por caracteres
    """
    if not lista_cadenas:
        return ""
    
    # Encuentra el prefijo comparando caracteres en la misma posición
    prefijo = []
    for chars in zip(*lista_cadenas):
        if len(set(chars)) == 1:
            prefijo.append(chars[0])
        else:
            break
    
    return ''.join(prefijo)

def prefijo_comun_3(lista_cadenas):
    """
    Método 3: Usando programación funcional con reduce()
    """
    from functools import reduce
    
    if not lista_cadenas:
        return ""
    
    def encontrar_prefijo(s1, s2):
        # Encuentra el prefijo común entre dos cadenas
        i = 0
        while i < min(len(s1), len(s2)) and s1[i] == s2[i]:
            i += 1
        return s1[:i]
    
    return reduce(encontrar_prefijo, lista_cadenas)

# Ejemplos de uso
def probar_prefijo_comun():
    # Casos de prueba
    casos_prueba = [
        ["flor", "florista", "florero"],
        ["perro", "perrera", "perruno"],
        ["casa", "carro", "camión"],
        ["python", "pyth", "py"],
        ["hola", "mundo"],
        []
    ]
    
    print("Probando métodos de prefijo común:")
    for i, caso in enumerate(casos_prueba, 1):
        print(f"\nCaso {i}: {caso}")
        print("Método 1:", prefijo_comun_1(caso))
        print("Método 2:", prefijo_comun_2(caso))
        print("Método 3:", prefijo_comun_3(caso))

# Ejecutar pruebas
probar_prefijo_comun()

# Función específica para prefijo de una línea
def prefijo_comun_inline(lista_cadenas):
    return min(lista_cadenas, key=len) if lista_cadenas else ""

# Ejemplo de uso en una línea
print("\nPrefijo inline:", prefijo_comun_inline(["flor", "florista", "florero"]))
----------------------------------------------------------------------------------------------------------------------------------------
.global _start
.section .text

_start:
    // Ejemplo con dos cadenas
    adr x0, string1
    adr x1, string2
    bl find_prefix
    mov x8, #93
    svc #0

find_prefix:
    // x0, x1 contienen direcciones de las cadenas
    mov x2, #0          // Índice actual
    
compare_loop:
    ldrb w3, [x0, x2]   // Cargar byte de primera cadena
    ldrb w4, [x1, x2]   // Cargar byte de segunda cadena
    
    // Verificar fin de cadena o diferencia
    cbz w3, end_prefix
    cbz w4, end_prefix
    cmp w3, w4
    bne end_prefix
    
    add x2, x2, #1      // Incrementar índice
    b compare_loop
    
end_prefix:
    mov x0, x2          // Retornar longitud del prefijo
    ret

.section .data
    string1: .asciz "flower"
    string2: .asciz "flow"
    result: .quad 0
https://asciinema.org/a/WhMp6DbCGxd5FxsRi6UpPpqEQ
