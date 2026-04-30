# Arquitectura del Sistema

## Visión General

El proyecto "Tom y Jerry" es un sistema orientado a objetos que modela al gato Tom y su interacción con ratones (Jerry, Nibbles y Mickey). El sistema está diseñado siguiendo principios de programación orientada a objetos y el paradigma de Wollok, con foco en polimorfismo, encapsulamiento y manejo de estado.

## Diagrama de Componentes

```
┌────────────────────────────────────────────────┐
│                    GATOS                       │
│  ┌──────────────────────────────────────────┐  │
│  │              Tom                         │  │
│  │  - energia: 50                           │  │
│  │  - factorConsumoDeCombustible: 30        │  │
│  └──────────────────────────────────────────┘  │
└────────────────────────────────────────────────┘
         │
         │ come / caza
         ▼
┌──────────────────────┐
│      RATONES         │
│  - Jerry (edad: 2)   │
│  - Nibbles (peso: 35)│
│  - Mickey (peso: 10) │
└──────────────────────┘
```

## Módulos del Sistema

### 1. Gatos (`src/gatos.wlk`)

**Responsabilidad:** Modelar a Tom y gestionar su energía, movimiento y alimentación.

#### Tom
**Propiedades:**
- `energia = 50` - Energía actual de Tom

**Métodos:**
- `energia()` - Retorna la energía actual
- `energiaConsumidaPorCorrer(distancia)` - Calcula energía consumida: distancia / 2
- `velocidadMaxima()` - Calcula velocidad: 5 + energia / 10
- `correr(distancia)` - Reduce energía (mínimo 0)
- `comer(raton)` - Aumenta energía: 12 + peso del ratón
- `puedeCazarA(distancia)` - Verifica si tiene energía suficiente
- `cazar(raton, distancia)` - Corre y come si puede cazar

**Comportamiento:**
- La energía nunca puede ser negativa (usa `0.max()`)
- Cazar implica correr primero y luego comer
- Solo caza si tiene energía suficiente

### 2. Ratones (`src/ratones.wlk`)

**Responsabilidad:** Modelar ratones con diferentes características de peso.

#### Jerry
- **Edad inicial:** 2 años
- **Peso:** edad × 20 (dinámico)
- **Método especial:** `cumpleaños()` - incrementa edad en 1

#### Nibbles
- **Peso:** 35 (constante)

#### Mickey
- **Peso:** 10 (constante)

## Patrones de Diseño

### 1. Singleton Pattern
Todos los objetos son singletons (una única instancia):
- Gato: `tom`
- Ratones: `jerry`, `nibbles`, `mickey`

### 2. Polymorphism

**Ratones** responden polimórficamente a:
- `peso()` - Retorna el peso del ratón

**Ventaja:** Tom puede comer cualquier ratón sin modificar su lógica, ya que todos responden al mensaje `peso()`.

### 3. Encapsulation
- Tom encapsula su estado interno (energía)
- Jerry encapsula su edad
- Los métodos públicos proveen acceso controlado al estado

### 4. State Management
- Tom mantiene su energía como estado mutable
- Jerry mantiene su edad como estado mutable
- Los métodos modifican el estado de forma controlada

## Decisiones de Diseño

### ¿Por qué la energía no puede ser negativa?
**Razón:** Usar `0.max(energia - consumo)` asegura que la energía nunca sea negativa, lo cual es más realista y evita errores lógicos.

### ¿Por qué cazar verifica primero si puede?
**Razón:** El método `cazar()` solo ejecuta la acción si `puedeCazarA()` retorna true, evitando que Tom corra sin poder completar la caza.

### ¿Por qué todos los ratones implementan peso()?
**Razón:** Para lograr polimorfismo, todos deben responder al mismo mensaje, permitiendo que Tom los coma indistintamente.

### ¿Por qué Jerry tiene edad dinámica?
**Razón:** El enunciado especifica que Jerry puede cumplir años, lo cual afecta su peso. Esto demuestra manejo de estado mutable.

## Extensibilidad

El sistema está diseñado para ser fácilmente extensible:

### Agregar nuevos ratones
```wollok
object raton4 {
    method peso() = 25
}
```

### Agregar nuevos gatos
```wollok
object silvestre {
    var energia = 60
    
    method energia() = energia
    method comer(raton) { 
        energia += raton.peso() 
    }
}
```

### Agregar comportamientos a Tom
```wollok
object tom {
    // ... código existente ...
    
    method descansar() {
        energia += 10
    }
    
    method estaFatigado() = energia < 20
}
```

## Flujo de Interacción Típico

1. **Estado inicial:**
   ```wollok
   tom.energia()  // 50
   jerry.peso()   // 40 (edad 2 × 20)
   ```

2. **Tom corre:**
   ```wollok
   tom.correr(20)
   // Energía consumida: 20 / 2 = 10
   // Nueva energía: 50 - 10 = 40
   tom.energia()  // 40
   ```

3. **Tom come a Jerry:**
   ```wollok
   tom.comer(jerry)
   // Energía ganada: 12 + 40 = 52
   // Nueva energía: 40 + 52 = 92
   tom.energia()  // 92
   ```

4. **Tom caza a Nibbles:**
   ```wollok
   tom.cazar(nibbles, 40)
   // Verifica: energiaConsumida(40) = 20 <= 92? Sí
   // Corre: 92 - 20 = 72
   // Come: 72 + (12 + 35) = 119
   tom.energia()  // 119
   ```

5. **Jerry cumple años:**
   ```wollok
   jerry.cumpleaños()
   jerry.edad()  // 3
   jerry.peso()  // 60 (edad 3 × 20)
   ```

## Polimorfismo en Acción

### Ratones
```wollok
// Tom puede comer cualquier ratón
tom.comer(jerry)    // Usa jerry.peso() = 40
tom.comer(nibbles)  // Usa nibbles.peso() = 35
tom.comer(mickey)   // Usa mickey.peso() = 10

// Todos responden al mismo mensaje
jerry.peso()    // 40
nibbles.peso()  // 35
mickey.peso()   // 10
```

## Fórmulas Importantes

### Energía Consumida por Correr
```
energiaConsumida = distancia / 2
```

### Velocidad Máxima
```
velocidadMaxima = 5 + (energia / 10)
```

### Energía Ganada al Comer
```
energiaGanada = 12 + peso_del_raton
```

### Peso de Jerry
```
peso = edad × 20
```

### Puede Cazar
```
puedeCazar = energiaConsumidaPorCorrer(distancia) <= energia
```

## Consideraciones de Testing

El proyecto tiene cobertura del 100% con 26 tests distribuidos en:
- `tests/gatos.wtest` - Tests de Tom (~20 tests)
- `tests/ratones.wtest` - Tests de ratones (~8 tests)

Ver [testing.md](testing.md) para más detalles.

## Casos Borde Importantes

### Energía en 0
```wollok
tom.correr(100)  // Energía: 50 - 50 = 0
tom.correr(20)   // Energía: 0.max(0 - 10) = 0 (no negativa)
```

### Cazar sin energía suficiente
```wollok
tom.correr(100)  // Energía: 0
tom.cazar(jerry, 40)  // No puede cazar (necesita 20, tiene 0)
tom.energia()  // 0 (no cambió)
```

### Cazar con energía justa
```wollok
tom.correr(60)  // Energía: 50 - 30 = 20
tom.cazar(jerry, 40)  // Puede cazar (necesita 20, tiene 20)
// Corre: 20 - 20 = 0
// Come: 0 + 52 = 52
tom.energia()  // 52
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
- Correr 20 mts: 10
- Correr 40 mts: 20
- Correr 100 mts: 50

### Velocidad Máxima
- Con 50 de energía: 10
- Con 100 de energía: 15
- Con 0 de energía: 5
