#Instituto Tecnológico de Tijuana
#Departamento de Sistemas y computación
#Materia: Lenguajes de interfaz
#Nombre del alumno: Rodríguez Gomez Bryan Alejandro 
#No. control 22210345
#Nombre del programa: Convertir temperatura de Celsius a Fahrenheit
#Descripcion de la actividad: programa que convierte celsius a Fahrenheit

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
