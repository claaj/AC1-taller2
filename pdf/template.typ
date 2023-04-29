#let project(title: "", authors: (), asign: "", date: "", uni: "", body) = {

  // Setear autores y titulos en el documento
  set document(author: authors, title: title)

  // Config de pagina
  set page(
    paper: "a4",
    header: align(right)[#title],
    numbering: "1",
    margin: (top: 1in, right: 1in, left: 1in, bottom: 1in),
  )

  // Config de texto
  set text(
    font: ("Linux Libertine", "Twemoji"),
    size: 11pt,
    lang: "es",
  )

  // Setear headings
  set heading(numbering: "1.a)")

  // Agregar numeros a ecuaciones
  set math.equation(numbering: "(1)")

  // Agrega bloque gris atras de bloques de código (Más fachero)
  show raw.where(block: true): block.with(
    fill: rgb("#f2f2f2"),
    inset: 10pt,
    radius: 5pt,
    width: 100%,
  )

  // Fuente bloque de codigo
  show raw: set text(font: "JetBrains Mono")

  // Centra los cuadros
  show table: align.with(center)

  // Formatear caratula
  let cover = {
    set align(center)
    v(100pt)
    title
    v(50pt)
    for author in authors {
      if author == authors.last() {
       author
      } else {
       author + ", "
      }
    }
    v(50pt)
    uni
    v(50pt)
    asign
    v(50pt)
    date
    pagebreak()
    set align(left)
  }

  // Imprimir caratula
  cover

  // Indice
  outline( title: "Indice", indent: true)
  pagebreak()

  // Justificar cuerpo.
  set par(justify: true)

  body
}
