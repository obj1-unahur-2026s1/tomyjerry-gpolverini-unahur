# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-04-30

### Agregado

#### Gatos
- Implementación del objeto `tom` con gestión de energía, movimiento y alimentación
- Atributos: `energia` (inicial: 50)
- Método `energia()`: retorna la energía actual
- Método `energiaConsumidaPorCorrer(distancia)`: calcula energía consumida (distancia / 2)
- Método `velocidadMaxima()`: calcula velocidad (5 + energia / 10)
- Método `correr(distancia)`: reduce energía (mínimo 0)
- Método `comer(raton)`: aumenta energía (12 + peso del ratón)
- Método `puedeCazarA(distancia)`: verifica si tiene energía suficiente
- Método `cazar(raton, distancia)`: corre y come si puede cazar

#### Ratones
- **Jerry**: 
  - Edad inicial: 2 años
  - Peso dinámico: edad × 20
  - Método `cumpleaños()`: incrementa edad
  - Método `edad()`: retorna edad actual
  - Método `peso()`: retorna peso calculado
- **Nibbles**:
  - Peso constante: 35
  - Método `peso()`: retorna 35
- **Mickey**:
  - Peso constante: 10
  - Método `peso()`: retorna 10

#### Tests (Cobertura 100%)
- **gatos.wtest** (~20 tests):
  - Energía inicial
  - Energía consumida por correr (casos: 0, normal, grande)
  - Velocidad máxima (múltiples escenarios)
  - Correr (casos: normal, límite, exceso, caso 0)
  - Comer (Jerry, Nibbles, Mickey, acumulación)
  - Puede cazar (casos true/false, límites)
  - Cazar (éxito, fallo, distancia 0, sin energía)
- **ratones.wtest** (6 tests):
  - Jerry: edad inicial, peso, cumpleaños
  - Nibbles: peso
  - Mickey: peso

#### Documentación
- README.md con especificación completa del ejercicio
- docs/index.md - Índice de documentación
- docs/architecture.md - Arquitectura del sistema
- docs/development.md - Guía para desarrolladores
- docs/setup.md - Guía de instalación
- docs/testing.md - Guía de testing
- CONTRIBUTING.md - Guía de contribución
- CODE_OF_CONDUCT.md - Código de conducta
- CHANGELOG.md - Este archivo
- LICENSE (ISC)

#### Configuración
- Proyecto configurado para Wollok
- Estructura de carpetas src/ (2 archivos) y tests/ (2 archivos)
- Configuración de .gitignore para archivos de log
- Imports correctos entre módulos
- Separación de responsabilidades: gatos y ratones

### Polimorfismo
- **Ratones**: todos responden a `peso()`, permitiendo que Tom los coma indistintamente
- Permite agregar nuevos ratones sin modificar el código de Tom

### Patrones de Diseño
- Singleton Pattern para todos los objetos
- Polymorphism para ratones
- Encapsulation de estado interno
- State Management para energía y edad

### Decisiones de Diseño
- La energía nunca puede ser negativa (usa `0.max()`)
- Cazar verifica primero si Tom tiene energía suficiente
- Todos los ratones implementan `peso()` para polimorfismo
- Jerry tiene edad dinámica que afecta su peso
- Cada viaje de caza implica correr primero y luego comer

### Casos Borde Cubiertos
- Energía en 0
- Correr más de lo que permite la energía
- Cazar sin energía suficiente
- Cazar con energía justa
- Distancia 0
- Jerry cumpliendo años múltiples veces

### Formato de Tests
- Formato Given-When-Then para todos los tests
- Un solo assert por test
- Tests independientes
- Cobertura de casos normales y borde
- Sin tests redundantes

[1.0.0]: https://github.com/usuario/tom-y-jerry/releases/tag/v1.0.0
