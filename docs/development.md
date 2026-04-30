# Guía para Desarrolladores

## Introducción

Esta guía está diseñada para ayudar a desarrolladores que quieran contribuir o extender el proyecto "Tom y Jerry". Aquí encontrarás información sobre el flujo de trabajo, convenciones de código y mejores prácticas.

## Configuración del Entorno de Desarrollo

### Requisitos
- Visual Studio Code con extensión de Wollok
- Wollok 4.2.3+
- Git

### Configuración Inicial
```bash
# Clonar el repositorio
git clone <url-del-repositorio>
cd tom-y-jerry

# Abrir en VS Code
code .
```

Ver [setup.md](setup.md) para instrucciones detalladas.

## Flujo de Trabajo

### 1. Antes de Empezar

1. **Actualiza tu rama local:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Crea una nueva rama:**
   ```bash
   git checkout -b feature/nombre-descriptivo
   # o
   git checkout -b fix/nombre-del-bug
   ```

### 2. Durante el Desarrollo

1. **Escribe tests primero (TDD):**
   ```wollok
   describe "Tom | Nueva funcionalidad" {
       test "Given: contexto | When: acción | Then: resultado esperado" {
           // Test que falla
           assert.equals(valorEsperado, tom.nuevoMetodo())
       }
   }
   ```

2. **Implementa la funcionalidad:**
   ```wollok
   object tom {
       method nuevoMetodo() {
           // Implementación mínima para pasar el test
       }
   }
   ```

3. **Ejecuta los tests frecuentemente:**
   - Después de cada cambio significativo
   - Antes de hacer commit

4. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde
   - Elimina duplicación
   - Mejora nombres de variables/métodos

### 3. Antes de Hacer Commit

1. **Ejecuta TODOS los tests:**
   - Desde VS Code: Ctrl+Shift+P → "Wollok: Run All Tests"
   - Verifica que todos pasen (26 tests en verde)

2. **Verifica que no haya errores de compilación:**
   - Revisa el panel "Problems" en VS Code (Ctrl+Shift+M)

3. **Revisa tus cambios:**
   ```bash
   git status
   git diff
   ```

### 4. Hacer Commit

```bash
# Agrega los archivos modificados
git add src/archivo.wlk tests/archivo.wtest

# Commit con mensaje descriptivo
git commit -m "Agrega nuevo ratón Speedy

- Implementa objeto Speedy con peso dinámico
- Agrega tests para verificar el comportamiento
- Actualiza documentación
- Fixes #123"
```

### 5. Push y Pull Request

```bash
# Push a tu rama
git push origin feature/nombre-descriptivo

# Crea un Pull Request en GitHub/GitLab
# Describe los cambios y referencia issues relacionados
```

## Convenciones de Código

### Nomenclatura

#### Objetos
```wollok
// Objetos singleton: camelCase
object tom { }
object jerry { }
object nibbles { }
object mickey { }
```

#### Métodos
```wollok
// Métodos: camelCase
method correr(distancia) { }
method comer(raton) { }
method puedeCazarA(distancia) { }
method energiaConsumidaPorCorrer(distancia) { }
```

#### Variables
```wollok
// Variables: camelCase
var energia = 50
var edad = 2
const factorConsumoDeCombustible = 30
```

### Estilo de Código

#### Indentación
- Usa **4 espacios** (no tabs)
- VS Code con la extensión de Wollok lo configura automáticamente

#### Llaves
```wollok
// ✓ Bueno: llave de apertura en la misma línea
method correr(distancia) {
    // código
}

// ✗ Malo: llave de apertura en nueva línea
method correr(distancia)
{
    // código
}
```

#### Espacios
```wollok
// ✓ Bueno: espacios alrededor de operadores
energia = 0.max(energia - self.energiaConsumidaPorCorrer(distancia))

// ✗ Malo: sin espacios
energia=0.max(energia-self.energiaConsumidaPorCorrer(distancia))

// ✓ Bueno: espacio después de comas
method cazar(raton, distancia)

// ✗ Malo: sin espacios
method cazar(raton,distancia)
```

#### Líneas en Blanco
```wollok
object tom {
    // Una línea en blanco entre métodos
    method correr(distancia) {
        // código
    }
    
    method comer(raton) {
        // código
    }
}
```

### Comentarios

#### Cuándo Comentar
```wollok
// ✓ Bueno: comentar lógica compleja o no obvia
// Asegura que la energía nunca sea negativa
energia = 0.max(energia - consumo)

// ✗ Malo: comentar lo obvio
method comer(raton) {
    energia += (12 + raton.peso())  // suma al energia
}
```

#### Comentarios TODO
```wollok
// TODO: Implementar validación de distancia negativa
// FIXME: Este método no maneja el caso de ratón null
// HACK: Solución temporal hasta refactorizar
```

## Mejores Prácticas

### 1. Principio de Responsabilidad Única
Cada objeto debe tener una sola responsabilidad:

```wollok
// ✓ Bueno: cada objeto tiene una responsabilidad clara
object tom {
    // Responsabilidad: gestionar energía, movimiento y alimentación
}

object jerry {
    // Responsabilidad: proveer peso según edad
}

// ✗ Malo: objeto con múltiples responsabilidades
object sistema {
    // Gestiona tom, ratones, y otras cosas
}
```

### 2. Encapsulamiento
No expongas detalles de implementación:

```wollok
// ✓ Bueno: encapsula el estado interno
object tom {
    var energia = 50  // privado
    
    method energia() = energia  // acceso controlado
}

// ✗ Malo: expone todo con property
object tom {
    var property energia = 50  // No debería ser público
}
```

### 3. Polimorfismo
Aprovecha el polimorfismo de Wollok:

```wollok
// ✓ Bueno: todos los ratones responden a la misma interfaz
tom.comer(jerry)    // Usa jerry.peso()
tom.comer(nibbles)  // Usa nibbles.peso()
tom.comer(mickey)   // Usa mickey.peso()

// ✗ Malo: usar condicionales para tipos
method comer(raton) {
    if (raton == jerry) {
        // lógica específica
    } else if (raton == nibbles) {
        // otra lógica
    }
}
```

### 4. Inmutabilidad Cuando Sea Posible
```wollok
// ✓ Bueno: usa const para valores que no cambian
object nibbles {
    const peso = 35
    method peso() = peso
}

// ✗ Malo: usar var innecesariamente
object nibbles {
    var peso = 35  // ¿realmente necesita cambiar?
}
```

### 5. Nombres Descriptivos
```wollok
// ✓ Bueno: nombres que expresan intención
method energiaConsumidaPorCorrer(distancia) = distancia / 2

// ✗ Malo: nombres crípticos
method calc(d) = d / 2
```

## Patrones Comunes

### Pattern: Métodos de Consulta
```wollok
// Métodos que retornan información sin cambiar estado
method energia() = energia
method velocidadMaxima() = 5 + energia / 10
method peso() = edad * 20
method puedeCazarA(distancia) = self.energiaConsumidaPorCorrer(distancia) <= energia
```

### Pattern: Métodos de Acción
```wollok
// Métodos que cambian el estado del objeto
method correr(distancia) { 
    energia = 0.max(energia - self.energiaConsumidaPorCorrer(distancia))
}

method comer(raton) { 
    energia += (12 + raton.peso())
}

method cumpleaños() { 
    edad += 1 
}
```

### Pattern: Métodos Compuestos
```wollok
// Métodos que combinan otros métodos
method cazar(raton, distancia) {
    if(self.puedeCazarA(distancia)) {
        self.correr(distancia)
        self.comer(raton)
    }
}
```

### Pattern: Cálculos Delegados
```wollok
// Delegar cálculos a métodos auxiliares
method cazar(raton, distancia) {
    if(self.puedeCazarA(distancia)) {  // Delega la verificación
        self.correr(distancia)
        self.comer(raton)
    }
}

method puedeCazarA(distancia) = 
    self.energiaConsumidaPorCorrer(distancia) <= energia
```

## Flujo del Sistema

El flujo típico del sistema es:

1. **Estado inicial:**
   - Tom tiene 50 de energía
   - Jerry tiene 2 años (peso 40)
   - Nibbles tiene peso 35
   - Mickey tiene peso 10

2. **Tom corre:**
   - Se invoca `correr(distancia)`
   - Se calcula energía consumida: distancia / 2
   - Se reduce la energía (mínimo 0)

3. **Tom come:**
   - Se invoca `comer(raton)`
   - Se obtiene el peso del ratón
   - Se aumenta energía: 12 + peso

4. **Tom caza:**
   - Se invoca `cazar(raton, distancia)`
   - Se verifica si puede cazar
   - Si puede: corre y luego come
   - Si no puede: no hace nada

5. **Jerry cumple años:**
   - Se invoca `cumpleaños()`
   - Se incrementa la edad
   - El peso cambia automáticamente (edad × 20)

## Testing

### Test-Driven Development (TDD)

1. **Red:** Escribe un test que falle
2. **Green:** Implementa lo mínimo para que pase
3. **Refactor:** Mejora el código

```wollok
// 1. RED: Test que falla
describe "Tom | Nueva funcionalidad" {
    test "Given: contexto | When: acción | Then: resultado" {
        assert.equals(valorEsperado, tom.nuevoMetodo())
    }
}

// 2. GREEN: Implementación mínima
object tom {
    method nuevoMetodo() = valorEsperado
}

// 3. REFACTOR: (si es necesario)
```

Ver [testing.md](testing.md) para más detalles.

## Debugging

### Técnicas de Debugging

#### 1. Console.println()
```wollok
method cazar(raton, distancia) {
    console.println("Energía inicial: " + energia)
    console.println("Puede cazar: " + self.puedeCazarA(distancia))
    if(self.puedeCazarA(distancia)) {
        self.correr(distancia)
        console.println("Energía después de correr: " + energia)
        self.comer(raton)
        console.println("Energía después de comer: " + energia)
    }
}
```

#### 2. Breakpoints
- Click en el margen izquierdo del editor en VS Code
- Ejecuta en modo Debug (F5)
- Inspecciona variables en el panel de Debug

#### 3. Tests Específicos
```wollok
test "debug: verificar caza" {
    console.println("Energía inicial: " + tom.energia())
    tom.cazar(jerry, 20)
    console.println("Energía final: " + tom.energia())
    assert.equals(92, tom.energia())
}
```

## Errores Comunes

### 1. Olvidar implementar todos los métodos polimórficos
```wollok
// ✗ Malo: falta método peso()
object nuevoRaton {
    // Falta: method peso() { }
}

// ✓ Bueno: implementa todos los métodos
object nuevoRaton {
    method peso() = 25
}
```

### 2. No Inicializar Variables
```wollok
// ✗ Malo
object tom {
    var energia  // Error: no inicializada
}

// ✓ Bueno
object tom {
    var energia = 50
}
```

### 3. Permitir Energía Negativa
```wollok
// ✗ Malo: energía puede ser negativa
method correr(distancia) {
    energia = energia - distancia / 2
}

// ✓ Bueno: energía nunca es negativa
method correr(distancia) {
    energia = 0.max(energia - distancia / 2)
}
```

### 4. No Verificar Antes de Cazar
```wollok
// ✗ Malo: siempre corre y come
method cazar(raton, distancia) {
    self.correr(distancia)
    self.comer(raton)
}

// ✓ Bueno: verifica primero
method cazar(raton, distancia) {
    if(self.puedeCazarA(distancia)) {
        self.correr(distancia)
        self.comer(raton)
    }
}
```

## Preguntas Frecuentes

### ¿Cómo agrego un nuevo ratón?

1. Crea un nuevo objeto en `src/ratones.wlk`
2. Implementa `peso()`
3. Agrega tests en `tests/ratones.wtest`
4. Úsalo con `tom.comer(nuevoRaton)`

Ejemplo:
```wollok
object speedy {
    method peso() = 15
}
```

### ¿Cómo agrego un nuevo gato?

1. Crea un nuevo objeto en `src/gatos.wlk`
2. Implementa los métodos necesarios
3. Agrega tests en `tests/gatos.wtest`

### ¿Puedo modificar el README.md?

No, el README.md contiene la especificación del ejercicio y no debe modificarse.

### ¿Dónde reporto bugs?

Crea un issue en el repositorio con:
- Descripción del bug
- Pasos para reproducir
- Comportamiento esperado vs actual
- Versión de Wollok

## Contacto

Si tienes preguntas o necesitas ayuda:
- Crea un issue con la etiqueta "question"
- Revisa la [Guía de Contribución](../CONTRIBUTING.md)
- Consulta el [Código de Conducta](../CODE_OF_CONDUCT.md)
