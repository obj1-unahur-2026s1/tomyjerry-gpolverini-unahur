# Guía de Testing

## Estrategia de Testing

El proyecto utiliza el framework de testing de Wollok para garantizar la correctitud del código. Los tests están organizados por módulo y cubren el 100% del código con 26 tests que verifican casos normales, casos límite y escenarios de integración.

## Estructura de Tests

```
tests/
├── gatos.wtest    # Tests de Tom (~20 tests)
└── ratones.wtest  # Tests de ratones (~8 tests)
```

## Ejecutar Tests

### Todos los tests
```bash
# Desde VS Code: Abre la paleta de comandos
# Ctrl+Shift+P (Windows/Linux) o Cmd+Shift+P (Mac)
# Busca: "Wollok: Run All Tests"
# Resultado esperado: 26 tests en verde ✓

# O desde la terminal con Wollok CLI (si está instalado):
wollok test
```

### Test individual
```bash
# Desde VS Code: 
# - Abre el archivo .wtest
# - Click en el ícono "Run Test" que aparece sobre cada test
# - O click derecho en el archivo → "Run Wollok File"

# Desde la terminal:
wollok test tests/gatos.wtest
```

### Tests por archivo
```bash
# Tests de Tom (~20 tests)
wollok test tests/gatos.wtest

# Tests de ratones (6 tests)
wollok test tests/ratones.wtest
```

## Cobertura de Tests (100%)

### Gatos (~20 tests)
- ✅ Energía inicial (1 test)
- ✅ Energía consumida por correr (3 tests: 0, normal, grande)
- ✅ Velocidad máxima (6 tests: diferentes escenarios)
- ✅ Correr (4 tests: normal, límite, exceso, caso 0)
- ✅ Comer (4 tests: Jerry, Nibbles, Mickey, acumulación)
- ✅ Puede cazar (5 tests: casos true/false, límites)
- ✅ Cazar (5 tests: éxito, fallo, distancia 0, sin energía)

### Ratones (~6 tests)
- ✅ Jerry: edad inicial (1 test)
- ✅ Jerry: peso (2 tests: inicial, después de cumpleaños)
- ✅ Jerry: cumpleaños (1 test)
- ✅ Nibbles: peso (1 test)
- ✅ Mickey: peso (1 test)

## Formato de Tests (BDD)

El proyecto sigue el formato **Given-When-Then** para los nombres de tests:

```wollok
describe "Objeto | Descripción del comportamiento" {
    test "Given: [contexto inicial] | When: [acción] | Then: [resultado esperado]" {
        // Arrange (preparación)
        // Act (acción)
        // Assert (verificación)
    }
}
```

### Ejemplo Real:
```wollok
describe "Tom | Verificar correr" {
    test "Given: Tom al inicio | When: corre 20 mts | Then: su energía debería ser 40" {
        tom.correr(20)
        assert.equals(40, tom.energia())
    }
}
```

## Buenas Prácticas de Testing

### 1. Un Solo Assert por Test
Cada test debe tener exactamente un assert (o `assert.that` con condiciones relacionadas):

✓ **Bueno:**
```wollok
test "Given: Tom al inicio | When: consultamos energia() | Then: debería retornar 50" {
    assert.equals(50, tom.energia())
}
```

✗ **Malo:**
```wollok
test "Tom al inicio" {
    assert.equals(50, tom.energia())  // ❌ Primer assert
    assert.equals(10, tom.velocidadMaxima())  // ❌ Segundo assert
}
```

### 2. Nombres Descriptivos
Los nombres deben describir claramente el escenario:

✓ **Bueno:**
```wollok
test "Given: Tom al inicio | When: corre 20 mts | Then: su energía debería ser 40" {
    tom.correr(20)
    assert.equals(40, tom.energia())
}
```

✗ **Malo:**
```wollok
test "test1" {
    assert.equals(40, tom.energia())
}
```

### 3. Arrange-Act-Assert (AAA)
Organiza tus tests en tres secciones:

```wollok
test "Given: Tom come a Jerry | When: consultamos velocidadMaxima() | Then: debería retornar 15.2" {
    // Arrange (preparar)
    // (Tom ya está en estado inicial)
    
    // Act (actuar)
    tom.comer(jerry)
    
    // Assert (verificar)
    assert.equals(15.2, tom.velocidadMaxima())
}
```

### 4. Tests Independientes
Cada test debe ser independiente y resetear el estado si es necesario:

```wollok
test "Given: Tom al inicio | When: corre 20 mts | Then: su energía debería ser 40" {
    tom.correr(20)
    assert.equals(40, tom.energia())
}
```

**Nota:** En Wollok, los objetos singleton se resetean automáticamente entre tests.

### 5. Casos Límite
Siempre prueba casos límite:

```wollok
test "Given: Tom al inicio | When: corre 100 mts | Then: su energía debería ser 0" {
    tom.correr(100)
    assert.equals(0, tom.energia())
}

test "Given: Tom al inicio | When: corre 120 mts | Then: su energía debería ser 0 (no puede ser negativa)" {
    tom.correr(120)
    assert.equals(0, tom.energia())
}

test "Given: Tom al inicio | When: consultamos puedeCazarA(101) | Then: debería retornar false" {
    assert.that(!tom.puedeCazarA(101))
}
```

## Debugging de Tests

### Test Falla Inesperadamente

1. **Lee el mensaje de error:**
   ```
   Expected: 92
   But was: 62
   ```

2. **Verifica el estado:**
   ```wollok
   test "debug: verificar caza" {
       console.println("Energía inicial: " + tom.energia())
       console.println("Peso de Jerry: " + jerry.peso())
       tom.cazar(jerry, 20)
       console.println("Energía final: " + tom.energia())
       assert.equals(92, tom.energia())
   }
   ```

3. **Simplifica el test:**
   - Reduce el test al mínimo necesario
   - Verifica una cosa a la vez

### Test Pasa Pero No Debería

- Verifica que estás usando `assert.equals()` o `assert.that()` correctamente
- Asegúrate de que el test realmente ejecuta la lógica esperada
- Revisa que no haya typos en los nombres de métodos

## Agregar Nuevos Tests

Cuando agregues nueva funcionalidad, sigue estos pasos:

1. **Escribe el test primero (TDD):**
   ```wollok
   test "Given: Tom descansa | When: consultamos energia() | Then: debería aumentar en 10" {
       var energiaInicial = tom.energia()
       tom.descansar()
       assert.equals(energiaInicial + 10, tom.energia())
   }
   ```

2. **Implementa la funcionalidad mínima:**
   - Haz que el test pase

3. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde

4. **Agrega más tests:**
   - Casos límite
   - Casos de error
   - Diferentes escenarios

## Ejemplos de Tests por Módulo

### Tests de Gatos

```wollok
describe "Tom | Verificar energía inicial" {
    test "Given: Tom al inicio | When: consultamos energia() | Then: debería retornar 50" {
        assert.equals(50, tom.energia())
    }
}

describe "Tom | Verificar correr" {
    test "Given: Tom al inicio | When: corre 20 mts | Then: su energía debería ser 40" {
        tom.correr(20)
        assert.equals(40, tom.energia())
    }
    
    test "Given: Tom al inicio | When: corre 120 mts | Then: su energía debería ser 0 (no puede ser negativa)" {
        tom.correr(120)
        assert.equals(0, tom.energia())
    }
}

describe "Tom | Verificar cazar" {
    test "Given: Tom al inicio | When: caza a Jerry a 20 mts | Then: su energía debería ser 92" {
        tom.cazar(jerry, 20)
        assert.equals(92, tom.energia())
    }
    
    test "Given: Tom al inicio | When: intenta cazar a Jerry a 120 mts | Then: su energía debería seguir siendo 50 (no puede cazar)" {
        tom.cazar(jerry, 120)
        assert.equals(50, tom.energia())
    }
}
```

### Tests de Ratones

```wollok
describe "Jerry | Verificar edad inicial" {
    test "Given: Jerry al inicio | When: consultamos edad() | Then: debería retornar 2" {
        assert.equals(2, jerry.edad())
    }
}

describe "Jerry | Verificar peso" {
    test "Given: Jerry al inicio | When: consultamos peso() | Then: debería retornar 40" {
        assert.equals(40, jerry.peso())
    }
    
    test "Given: Jerry cumple años | When: consultamos peso() | Then: debería retornar 60" {
        jerry.cumpleaños()
        assert.equals(60, jerry.peso())
    }
}

describe "Nibbles | Verificar peso" {
    test "Given: Nibbles | When: consultamos peso() | Then: debería retornar 35" {
        assert.equals(35, nibbles.peso())
    }
}
```

## Casos de Prueba Importantes

### Energía Nunca Negativa

```wollok
tom.correr(100)  // Energía: 50 - 50 = 0
tom.correr(20)   // Energía: 0.max(0 - 10) = 0 (no negativa)
```

### Cazar sin Energía Suficiente

```wollok
tom.correr(100)  // Energía: 0
tom.cazar(jerry, 40)  // No puede cazar (necesita 20, tiene 0)
tom.energia()  // 0 (no cambió)
```

### Cazar con Energía Justa

```wollok
tom.correr(60)  // Energía: 50 - 30 = 20
tom.cazar(jerry, 40)  // Puede cazar (necesita 20, tiene 20)
// Corre: 20 - 20 = 0
// Come: 0 + 52 = 52
tom.energia()  // 52
```

### Jerry Cumple Años

```wollok
jerry.peso()  // 40 (edad 2 × 20)
jerry.cumpleaños()
jerry.peso()  // 60 (edad 3 × 20)
```

### Polimorfismo de Ratones

```wollok
// Todos los ratones pueden ser comidos por Tom
tom.comer(jerry)    // Usa jerry.peso() = 40
tom.comer(nibbles)  // Usa nibbles.peso() = 35
tom.comer(mickey)   // Usa mickey.peso() = 10
```

## Verificación de Polimorfismo

Los tests verifican que el polimorfismo funciona correctamente:

```wollok
// Todos los ratones responden a la misma interfaz
jerry.peso()    // 40
nibbles.peso()  // 35
mickey.peso()   // 10

// Tom puede comer cualquier ratón
tom.comer(jerry)
tom.comer(nibbles)
tom.comer(mickey)
```

## Escenarios de Integración

Los tests de integración verifican flujos completos:

```wollok
test "Given: Tom come a Jerry, corre 24 mts, come a Nibbles | When: consultamos velocidadMaxima() | Then: debería retornar 18.7" {
    tom.comer(jerry)
    tom.correr(24)
    tom.comer(nibbles)
    assert.equals(18.7, tom.velocidadMaxima())
}
```

## Valores de Referencia

### Energía Inicial
- Tom: 50

### Pesos de Ratones
- Jerry (edad 2): 40
- Jerry (edad 3): 60
- Nibbles: 35
- Mickey: 10

### Consumo de Energía
- Correr 0 mts: 0
- Correr 20 mts: 10
- Correr 40 mts: 20
- Correr 100 mts: 50

### Velocidad Máxima
- Con 0 de energía: 5
- Con 50 de energía: 10
- Con 100 de energía: 15
- Con 102 de energía: 15.2

### Energía Ganada al Comer
- Jerry (edad 2): 12 + 40 = 52
- Jerry (edad 3): 12 + 60 = 72
- Nibbles: 12 + 35 = 47
- Mickey: 12 + 10 = 22

## Recursos Adicionales

- [Documentación oficial de Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Guía de TDD](https://www.wollok.org/documentacion/tdd/)
- Ver [architecture.md](architecture.md) para entender la estructura del código
- Ver [setup.md](setup.md) para instrucciones de instalación
- Ver [development.md](development.md) para guía de desarrollo
