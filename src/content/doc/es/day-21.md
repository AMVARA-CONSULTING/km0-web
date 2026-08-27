---
title: "Día 21 - Encuentro: datos y conducción autónoma"
description: "En el Casino del Masnou repasamos niveles de autonomía, sensores y por qué los datos de entrenamiento mandan en el coche autónomo."
pubDate: 2026-08-07
locale: es
---

En el [encuentro del 7 de agosto](/meeting/) en el Casino del Masnou hablamos de **conducción autónoma y datos**. No fue un pitch de producto: fue una mesa para entender en qué nivel estamos de verdad y por qué entrenar estos sistemas consume cantidades absurdas de información.

## Qué niveles existen (y dónde estamos)

La escala SAE va del **0 al 5**. Resumen útil:

- **Nivel 0:** el humano hace todo.
- **Nivel 1 y 2:** asistencia (mantenimiento de carril, control de velocidad adaptativo). El conductor sigue siendo responsable. Ahí viven la mayoría de coches de calle, incluido el Autopilot / Full Self-Driving de Tesla en uso cotidiano: no puedes soltar el volante mucho rato o el coche avisa y acaba frenando.
- **Nivel 3:** el coche puede llevar la conducción en condiciones acotadas (por ejemplo autopista y hasta cierta velocidad). Mercedes llegó ahí con Drive Pilot en la Clase S; la responsabilidad en ese modo es del fabricante. El paquete es caro (sensores duplicados por seguridad) y la adopción comercial se ha frenado.
- **Nivel 4:** automatización alta en un dominio concreto. Los robotaxis tipo **Waymo** en algunas ciudades de EE. UU. operan sin conductor a bordo.
- **Nivel 5:** cualquier sitio, cualquier condición. Aún no es el producto de consumo.

Hoy, para el comprador medio, el techo realista sigue siendo el **nivel 2**. Quien apunta al 4 necesita otra escala de sensores y de computación.

## Dos filosofías de sensores

Hay dos enfoques claros:

1. **Sobre todo cámaras** (filosofía Tesla): más barato, pero frágil con niebla, lluvia fuerte, sol bajo o noche.
2. **Fusión de sensores** (cámaras + lidar + radar, como Waymo): más robusto y mucho más caro de fabricar y de sincronizar.

Un lidar “mira” cientos de metros; varios lidars, radares y una docena de cámaras generan **terabytes al día por coche**. Sincronizar esas señales en tiempo real es una máquina con ruedas, no un accesorio.

## Datos, reglas e IA

Las flotas ya en circulación (sobre todo Tesla) acumulan kilómetros cada día; eso alimenta el entrenamiento. Quien no guarda esa telemetría a escala no puede competir en modelos de conducción.

Mercedes construyó mucho del nivel 3 con **reglas escritas a mano** (cientos de miles de líneas en C) antes de que la IA generativa fuera cotidiana. Parte del sector está pausando el 3, quedándose en el 2 y mirando al 4 con redes neuronales: tirar código de reglas y entrenar de nuevo. Entrenar cuesta energía de data center a escala de ciudad; desplegar el modelo en el coche sigue siendo el cuello de botella.

## Cierre

Si te interesa la conversación (datos, IA, o cómo operamos KM0), ven al próximo [encuentro](/meeting/). Entre medias, Cloud y Mail siguen en la [UE](/#services).
