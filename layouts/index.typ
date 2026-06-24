#import "@preview/cmarker:0.1.9": render

#set page(
  paper: "a4",
)

#set text(
  font: (
    "Segoe UI",
    "Arial",
    "Libertinus Serif",
    "Segoe UI Emoji",
    "Segoe UI Symbol",
  ),
)

#show heading.where(level: 1): set text(
    size: 33pt,
    weight: "black",
    fill: rgb("{{ .Site.Params.primaryColor }}"),
)

#show heading.where(level: 2): set text(
    size: 15pt,
    weight: "bold",
    fill: rgb("{{ .Site.Params.primaryColor }}"),
)

#let inline-list(items, delimiter: ", ") = {
  for (i, item) in items.enumerate() {
    item
    if i < items.len() - 1 { delimiter }
  }
}

#let flexible-image(path) = layout(size => context {
  let img-width = measure(image(path)).width
  let target-width = calc.min(img-width, size.width)
  image(path, width: target-width)
})

#grid(
  columns: (4fr, 1fr),
  [
    = #upper("{{ .Site.Params.profile.name }}") \
    {{ .Site.Params.profile.tagline }} \
    {{ .Site.Params.contact.location }}

    {{ range .Site.Params.contact.list -}}
    {{ .type }}: #link("{{ .url }}") \
    {{ end }}
  ],
  [
    #align(right + horizon)[
    {{ with resources.Get "images/photo.jpg" }}
      #flexible-image("{{ .RelPermalink }}")
    {{ end }}
    ]
  ],
)

== Summary

#render({{ printf "%q" .Site.Params.summary.text }})

== Core Expertise

#list(
  {{- range .Site.Params.experience.core }}
      [{{ . }}],
  {{- end -}}
)

== Work Experience

{{ range .Site.Params.experience.list }}
  === {{ .company }}
  #list(
  spacing: 2em,
  {{ range .products }}
  [
    #block(breakable: false)[
      {{ if .title }}*{{ .title }}*{{ end }}
      {{ .dates }}

      #render({{ printf "%q" .details }})

      {{ delimit (apply .skills "printf" "*%s*" ".") " • " }}
    ]
  ],
  {{ end }}
  )
{{ end }}

{{- if .Site.Params.education }}
== Education
#list(
  {{ range .Site.Params.education.list }}
  [
  *{{ .degree }}* \
  {{ .university }} \
  {{ .dates }}
  ],
  {{ end }}
)
{{ end }}

== Languages

{{- range .Site.Params.languages.list }}
    {{ .name }} ({{ .level }}) \
{{- end }}
