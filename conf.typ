#import "vendor/zebra-0.1.0/src/lib.typ": qrcode

// Page and text settings shared by every ballot. Use as `#show: ballot-setup`.
// The OpenDyslexic font files are in fonts/; pass `--font-path fonts` to typst.
#let ballot-setup(doc) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.5in, y: 0.15in),
  )
  
  set text(
    font: "OpenDyslexic",
    size: 11pt,
  )
  
  set par(
    justify: true,
    leading: 0.5em, //spacing between lines
  )

  doc
}

// The ballot ID and its QR code, shown to the right of a ballot's instructions. The ID is
// printed large enough to read and type in by hand if the QR code can't be scanned.
// `qr-data` is what the QR code encodes; it defaults to the ID itself.
#let ballot-id-block(ballot-id, qr-data: none) = stack(
  spacing: 0.25em,
  align(right, qrcode(if qr-data == none { ballot-id } else { qr-data }, width: 0.85in, quiet-zone: 4)),
  align(right, text(size: 8pt)[Ballot ID]),
  align(right, text(size: 10pt, weight: "bold", hyphenate: false)[#ballot-id]),
)

// One STAR ballot. When `ballot-id` is given, it is printed with a QR code beside the
// instructions so that each paper copy can be told apart when counting.
#let star-ballot(candidates: (), ballot-id: none, qr-data: none) = {
  let ballot_table(candidates) = [
    #show "bubble0": name => box[
      #box(image(
        "images/bubble-score_0.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble1": name => box[
      #box(image(
        "images/bubble-score_1.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble2": name => box[
      #box(image(
        "images/bubble-score_2.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble3": name => box[
      #box(image(
        "images/bubble-score_3.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble4": name => box[
      #box(image(
        "images/bubble-score_4.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble5": name => box[
      #box(image(
        "images/bubble-score_5.svg",
        height: 2em,
      ))
    ]
    
    #show "star0": name => box[
      #box(image(
        "images/star-score_0.svg",
        height: 5em,
      ))
    ]
    
    #show "star1": name => box[
      #box(image(
        "images/star-score_1.svg",
        height: 4em,
      ))
    ]
    
    #show "star2": name => box[
      #box(image(
        "images/star-score_2.svg",
        height: 4em,
      ))
    ]
    
    #show "star3": name => box[
      #box(image(
        "images/star-score_3.svg",
        height: 4em,
      ))
    ]
    
    #show "star4": name => box[
      #box(image(
        "images/star-score_4.svg",
        height: 4em,
      ))
    ]
    
    #show "star5": name => box[
      #box(image(
        "images/star-score_5.svg",
        height: 4em,
      ))
    ]
  
    #set table(align: (x, y) => {
        if x > 0 and y >= 0 {
          // Align vertically and horizontally
          center + horizon
        } else {
          auto
        }
      })
    
    // See the strokes section for details on this!
    #let frame(stroke) = (x, y) => (
      left:   { none },
      right:  { none },
      top:    if y > 0 { stroke } else { none },
      bottom: { stroke },
    )
      
    #table(
      columns: (5fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
      stroke: frame(1pt + rgb("21222C")),
      table.header[][*Worst* \ star0][\ star1][\ star2][\ star3][\ star4][*Best* \ star5],
      ..for name in candidates.sorted() {
        ( [*#name*], [bubble0], [bubble1], [bubble2], [bubble3], [bubble4], [bubble5] )
      }
    )
  ]
  
  align(top)[
    #image("images/STAR_Voting_Logo-black.png", fit: "contain")
  ]
  
  let instructions = box[
    #align(left)[
      #list(
        body-indent: 1.5em,
        // tight: true,
        // marker: [•],
        // indent: 0pt,
        // spacing: auto,
        // marker-align: end,
        [Give your favorite candidate(s) five stars.],
        [Give your last choice(s) zero or leave blank.],
        [Score other candidates as desired.],
        [Equal scores indicate equal support.],
      )
    ]
  ]

  if ballot-id == none {
    align(center, instructions)
  } else {
    // The ID and QR code share the instructions' row, so they add little height and every
    // copy keeps them in the same spot for scanning. The instructions move to the left
    // margin to leave room for the ID on one line.
    grid(
      columns: (auto, 1fr),
      align: (left + horizon, right + horizon),
      instructions,
      ballot-id-block(ballot-id, qr-data: qr-data),
    )
  }
  
  ballot_table(candidates)
  
  align(center)[
    #set par(justify: true)
    The two highest scoring candidates are finalists. Your full vote goes to the finalist you prefer. The finalist with the most votes wins.
  ]

}

// A single ballot document, as used by main.typ.
#let conf(
  candidates: (),
  ballot-id: none,
  qr-data: none,
  doc
) = {
  show: ballot-setup
  star-ballot(candidates: candidates, ballot-id: ballot-id, qr-data: qr-data)
  doc
}
