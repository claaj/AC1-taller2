#import "template.typ": *

#show: project.with(
  title: "Taller 2: MIPS",
  authors: (
    "Cajal Matías", "Levin Nicolas", "Zuñigas Cesar"
  ),
  uni: "Universidad Nacional de Río Negro",
  asign: "Arquitectura de Computadoras I",
  date: "28 de abril de 2023",
)

= Algoritmo de ordenamiento
== Comparación entre implementaciones
=== Caso de prueba dado por el Taller
El caso de prueba dado por el taller es:
```
arr: 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
```

#figure(
    image("../imagenes/casotp-b.png", width: 50%),
    caption: ["Cantidad de instrucciones usando la función del punto a."]
    )

#figure(
    image("../imagenes/casotp-c.png", width: 50%),
    caption: ["Cantidad de instrucciones implementando ordenamiento burbuja."]
    )

El metodo burbuja es más ineficiente porque debe intercambiar de a una posición del arreglo. Por este mismo motivo, utiliza muchas más instrucciones tanto de tipo `R` como de tipo `I`.

Para este caso de prueba el metodo burbuja utilzó un *19,4%* más de instrucciones de la ALU, *49,76%* extra en saltos y un *75,09%* de más en operaciones de memoria.

=== Peor caso de prueba
El peor caso es un arreglo que este ordenado de menor a mayor, ya que debe ser invertido en su totalidad:
```
arr: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
```

#figure(
    image("../imagenes/peor-b.png", width: 50%),
    caption: ["Cantidad de instrucciones usando la función del punto a."]
    )

#figure(
    image("../imagenes/peor-c.png", width: 50%),
    caption: ["Cantidad de instrucciones implementando ordenamineto burbuja."]
    )

Para el ordenamiento burbuja se utilzaron un *19,03%* más de instrucciones.

=== Cantidad de instrucciones, distintos largos de arreglo
En la siguiente tabla se comparan las dos implementaciones en base a la cantidad de elementos en el arreglo.
Operando con el peor caso.

#table(
    columns: (auto, auto, auto),
    inset: 5pt,
    stroke: 0.5pt,
    align: horizon,
    [*Cantidad de elementos*], [*Ejercicio B*], [*Metodo Burbuja*],
    [10], [1641], [1590],
    [20], [4461], [5548],
    [30], [9661], [11898],
    [40], [16461], [20648],
    [100], [71642], [110589],
    [1000], [3291496], [7776692],
    [1000000], [270913392133], [2709217949917],
    )

#figure(
    image("../imagenes/grafico.png", width: 80%),
    caption: ["Grafico comparando desde arreglo con 10 elementos hasta 100"]
    )

La cantidad de instrucciones crece de manera exponencial en relación a la cantidad de elementos dentro del arreglo.

= Recursividad y stack
Se puede calcular hasta el factorial de 12 inclusive, en adelante genera overflow.
Esto se debe a una limitación de la arquitectura, los registros pueden operar hasta 32 bits.
El factorial de 12 es el último factorial capaz de representarse en 32 bits.
