# Guía de Instalación y Configuración

## Requisitos Previos

- **Visual Studio Code** con la extensión de Wollok instalada
- **Wollok** versión 4.2.3 o superior
- **Git** (opcional, para clonar el repositorio)

## Instalación

### 1. Instalar Visual Studio Code y Wollok

1. **Descarga e instala Visual Studio Code:**
   - [https://code.visualstudio.com/](https://code.visualstudio.com/)

2. **Instala la extensión de Wollok:**
   - Abre VS Code
   - Ve a Extensions (Ctrl+Shift+X o Cmd+Shift+X)
   - Busca "Wollok"
   - Instala la extensión oficial de Wollok

### 2. Clonar o Descargar el Proyecto

**Opción A: Con Git**
```bash
git clone <url-del-repositorio>
cd tom-y-jerry
```

**Opción B: Descarga directa**
- Descarga el archivo ZIP del proyecto
- Extrae el contenido en tu carpeta de trabajo

### 3. Abrir en VS Code

1. Abre Visual Studio Code
2. Ve a `File` → `Open Folder...`
3. Selecciona la carpeta del proyecto "tom-y-jerry"
4. VS Code detectará automáticamente los archivos de Wollok

## Estructura del Proyecto

```
tom-y-jerry/
├── src/                    # Código fuente
│   ├── gatos.wlk          # Definición de Tom
│   └── ratones.wlk        # Ratones (Jerry, Nibbles, Mickey)
├── tests/                  # Tests unitarios (100% cobertura)
│   ├── gatos.wtest        # Tests de Tom (20 tests)
│   └── ratones.wtest      # Tests de ratones (6 tests)
├── docs/                   # Documentación
│   ├── index.md           # Índice de documentación
│   ├── setup.md           # Esta guía
│   ├── architecture.md    # Arquitectura del sistema
│   ├── development.md     # Guía de desarrollo
│   └── testing.md         # Guía de testing
├── log/                    # Archivos de log (ignorados)
├── README.md              # Especificación del ejercicio
├── CONTRIBUTING.md        # Guía de contribución
├── CODE_OF_CONDUCT.md     # Código de conducta
├── LICENSE                # Licencia del proyecto
├── CHANGELOG.md           # Registro de cambios
└── package.json           # Configuración del proyecto
```

## Ejecutar el Proyecto

### Ejecutar Tests Individuales

1. Abre cualquier archivo `.wtest` en el editor
2. Haz clic en el ícono "Run Test" que aparece sobre cada test
3. O click derecho en el archivo → "Run Wollok File"

### Ejecutar Todos los Tests

**Desde VS Code:**
- Abre la paleta de comandos (Ctrl+Shift+P o Cmd+Shift+P)
- Busca "Wollok: Run All Tests"
- Ejecuta el comando

**Desde la terminal (si tienes Wollok CLI instalado):**
```bash
wollok test
```

## Verificar la Instalación

Para verificar que todo está correctamente instalado:

1. Abre `tests/gatos.wtest`
2. Ejecuta los tests
3. Deberías ver todos los tests en verde ✓ (~20 tests)

O ejecuta todos los tests:
- Deberías ver 26 tests en verde ✓

## Explorar el Proyecto

### 1. Entender la Especificación
Lee el [README.md](../README.md) para entender:
- Tom y su energía
- Los ratones (Jerry, Nibbles, Mickey)
- Velocidad máxima de Tom
- Cómo Tom corre y come
- Cómo Tom caza ratones

### 2. Revisar el Código Fuente

**Gatos (`src/gatos.wlk`):**
```wollok
object tom {
    var energia = 50
    
    method energia() = energia
    method energiaConsumidaPorCorrer(distancia) = distancia / 2
    method velocidadMaxima() = 5 + energia / 10
    method correr(distancia) { ... }
    method comer(raton) { ... }
    method puedeCazarA(distancia) { ... }
    method cazar(raton, distancia) { ... }
}
```

**Ratones (`src/ratones.wlk`):**
- Jerry: edad variable, peso = edad × 20, puede cumplir años
- Nibbles: peso constante 35
- Mickey: peso constante 10

### 3. Ejecutar Tests

Ejecuta los tests para ver el sistema en acción:

```bash
# Tests de Tom
tests/gatos.wtest

# Tests de ratones
tests/ratones.wtest
```

### 4. Experimentar en la Consola REPL

1. Abre la paleta de comandos (Ctrl+Shift+P)
2. Busca "Wollok: Start REPL"
3. Experimenta con el código:

```wollok
>>> tom.energia()
50
>>> tom.correr(20)
>>> tom.energia()
40
>>> tom.comer(jerry)
>>> tom.energia()
92
>>> tom.velocidadMaxima()
14.2
>>> jerry.cumpleaños()
>>> jerry.peso()
60
```

## Troubleshooting

### Error: "Project not found" o "Cannot resolve dependencies"

**Solución:**
1. Asegúrate de tener la extensión de Wollok instalada en VS Code
2. Recarga la ventana de VS Code (Ctrl+Shift+P → "Reload Window")
3. Verifica que el archivo `package.json` esté presente
4. Intenta ejecutar los tests nuevamente

### Los tests no se ejecutan

**Solución:**
1. Verifica que los archivos `.wtest` estén en la carpeta `tests/`
2. Asegúrate de que la extensión de Wollok esté activa
3. Revisa la consola de salida de VS Code para ver errores
4. Recarga la ventana de VS Code

### Errores de sintaxis o compilación

**Solución:**
- Revisa que todos los archivos `.wlk` estén en la carpeta `src/`
- Verifica que no haya errores de sintaxis en el código
- Asegúrate de que las importaciones sean correctas:
  ```wollok
  import src.gatos.*
  import src.ratones.*
  ```
- Revisa el panel "Problems" de VS Code (Ctrl+Shift+M)

### Error: "Cannot find object"

**Solución:**
- Verifica que los imports estén correctos
- Asegúrate de que el objeto esté definido en el archivo correcto
- Ejemplo correcto:
  ```wollok
  // En tests/gatos.wtest
  import src.gatos.*
  import src.ratones.*
  ```

### Tests fallan inesperadamente

**Solución:**
1. Lee el mensaje de error cuidadosamente
2. Verifica el estado inicial de los objetos
3. Asegúrate de que los tests sean independientes
4. Revisa la [Guía de Testing](testing.md)

## Próximos Pasos

Una vez que tengas el proyecto funcionando:

1. **Lee la documentación:**
   - [README.md](../README.md) - Especificación del ejercicio
   - [architecture.md](architecture.md) - Arquitectura del sistema
   - [development.md](development.md) - Guía para desarrolladores
   - [testing.md](testing.md) - Guía de testing

2. **Explora el código:**
   - Revisa cada archivo en `src/`
   - Entiende cómo interactúan Tom y los ratones
   - Identifica los patrones de diseño utilizados

3. **Ejecuta y modifica tests:**
   - Ejecuta todos los tests (26 tests)
   - Modifica algunos tests para experimentar
   - Crea nuevos tests

4. **Experimenta con el sistema:**
   - Agrega un nuevo ratón
   - Modifica comportamientos existentes
   - Prueba casos borde

5. **Contribuye:**
   - Lee [CONTRIBUTING.md](../CONTRIBUTING.md)
   - Reporta bugs o sugiere mejoras
   - Crea pull requests

## Recursos Adicionales

- [Documentación oficial de Wollok](https://www.wollok.org/)
- [Tour de Wollok](https://www.wollok.org/tour/)
- [Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Wollok REPL](https://www.wollok.org/documentacion/repl/)

## Ayuda

Si necesitas ayuda:
- Revisa la sección de [Troubleshooting](#troubleshooting)
- Consulta los [Errores Comunes](development.md#errores-comunes)
- Crea un issue con la etiqueta "question"
- Lee el [Código de Conducta](../CODE_OF_CONDUCT.md)

## Licencia

Este proyecto está licenciado bajo la Licencia ISC. Ver el archivo [LICENSE](../LICENSE) para más detalles.
