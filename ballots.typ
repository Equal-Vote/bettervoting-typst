#import "conf.typ": ballot-setup, star-ballot

// Prints a batch of STAR ballots: a cover page listing every ballot ID in the batch, then
// one ballot per page, each with its own ID and QR code, so copies can be told apart (and
// duplicates caught) when the ballots are counted.
//
// The data comes in as JSON through the `data` input:
//
//   typst compile --font-path fonts \
//     --input data='{"title": "Board election", "candidates": ["Alice", "Bob"], "ballots": [{"id": "K7Q2M-9XW3H"}, {"id": "3HDNP-Z4R8C"}]}' \
//     ballots.typ
//
// "title" and "printed" (a date to show on the cover) are optional. Each ballot may also
// carry a "qr" string, which its QR code encodes instead of the ID.

#let sample = (
  title: "Sample batch",
  candidates: ("Option 01", "Option 02", "Option 03"),
  ballots: ((id: "SAMPL-E0001"), (id: "SAMPL-E0002")),
)
#let data = if "data" in sys.inputs { json(bytes(sys.inputs.data)) } else { sample }
#let title = data.at("title", default: none)
#let printed = data.at("printed", default: none)

#show: ballot-setup

// Cover page(s): a record of the batch to keep with the ballots.
#block(width: 100%)[
  #set par(justify: false)
  #align(center)[
    #text(size: 18pt, weight: "bold")[Ballot batch] \
    #if title != none { text(size: 13pt)[#title] }
  ]
  #v(0.5em)
  #align(center)[#{
    let n = data.ballots.len()
    str(n) + if n == 1 { " ballot" } else { " ballots" }
    if printed != none { ", printed " + printed }
  }]
  #v(0.5em)
  This page lists the ID of every ballot in this batch. Keep it with the ballots: when they
  are counted, each ballot's ID should appear here exactly once.
  #v(1em)
]
#columns(3, gutter: 1.2em)[
  #set text(size: 9pt)
  #for (i, ballot) in data.ballots.enumerate() [
    // One unbreakable box per entry, so an ID never wraps across lines.
    #box[#box(width: 2.4em, align(right)[#(i + 1).]) #h(0.4em) #text(weight: "bold", hyphenate: false)[#ballot.id]] \
  ]
]

#for ballot in data.ballots {
  pagebreak()
  star-ballot(
    candidates: data.candidates,
    ballot-id: ballot.id,
    qr-data: ballot.at("qr", default: none),
  )
}
