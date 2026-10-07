#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *

#let code(filename, body) = {
  codly(
    header: [#filename]
  )
  body
}



#let my-template(
  title: "",
  author: "",
    code_font: ("Lilex Nerd Font Mono", "IoskeleyMono Nerd Font", "MonoLisa", "JetBrains Mono", "Fira Code", "Cascadia Code", "monospace"),
  body,
) = {
  set page(
    paper: "a4",
    margin: (
      left: 2.5cm,
      right: 2.5cm,
      top: 2.5cm,
      bottom: 2cm,
    ),
    numbering: "1",
    number-align: center,
  )

  show raw: set text(font: code_font)
  show raw.where(block: false): it => box(
    fill: luma(250),
    stroke: 0.5pt + luma(200),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 2pt,
  )[#it]


  show: codly-init.with()

  codly(
    fill: rgb("#fafafa"),
    zebra-fill: none,
    number-format: n => text(fill: rgb("#9b9fa6"), size: 0.8em)[#n],
    languages: codly-languages,
  )

  show heading: it => {
    it
    v(14pt, weak: true)
  }


  set text(
    font: "Times New Roman",
    size: 12pt,
  )

  set par(justify: true)


  page(numbering: none)[
    #align(center, [
      #set text(14pt, weight: "bold")
      #title
    ])

    #align(center)[
      #text(weight: "bold", author, size: 11pt)
    ]
  ]

  pagebreak()

  page(numbering: none)[
    #outline()
  ]
  pagebreak()

  set heading(numbering: "I.")

  body
}
