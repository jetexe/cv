#import "@preview/cmarker:0.1.8": render

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

#grid(
  columns: (4fr, 1fr),
  [= #upper("{{ .Site.Params.profile.name }}") \
  {{ .Site.Params.profile.tagline }} \
  {{ .Site.Params.contact.location }}

  {{ range .Site.Params.contact.list -}}
  {{ .type }}: #link("{{ .url }}") \
  {{ end }}
  ],
  [
  #align(right + horizon)[
    #image("assets/images/photo.jpg", height: 90pt, fit: "contain")
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
=== {{ .title }} \
{{ if .company -}}{{ .company }} | {{ end -}}{{ .dates }}

{{ if .details }}#render({{ printf "%q" .details }}){{ end }}
{{ if .items }}
==== Core Technologies
#pad(left: 1em)[

#inline-list((
{{- end -}}
{{ range .items }}
     "{{ .details }}",
{{- end }}
{{- if .items }}
), delimiter: " • ")

]
{{- end }}
{{- end -}}

{{- if .Site.Params.education -}}
== Education

{{ range .Site.Params.education.list }}
=== {{ .university }}({{ .dates }})
{{ .degree }}
{{ end }}
{{ end }}

== Languages

{{- range .Site.Params.languages.list }}
    {{ .name }} \
    {{ .level }}


{{ end -}}

