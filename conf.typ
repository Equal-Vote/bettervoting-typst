#let conf(
  candidates: (),
  doc
) = {
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
  
  let ballot_table(candidates) = [
    #show "bubble0": name => box[
      #box(image(
        "bubble-score_0.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble1": name => box[
      #box(image(
        "bubble-score_1.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble2": name => box[
      #box(image(
        "bubble-score_2.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble3": name => box[
      #box(image(
        "bubble-score_3.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble4": name => box[
      #box(image(
        "bubble-score_4.svg",
        height: 2em,
      ))
    ]
    
    #show "bubble5": name => box[
      #box(image(
        "bubble-score_5.svg",
        height: 2em,
      ))
    ]
    
    #show "star0": name => box[
      #box(image(
        "star-score_0.svg",
        height: 5em,
      ))
    ]
    
    #show "star1": name => box[
      #box(image(
        "star-score_1.svg",
        height: 4em,
      ))
    ]
    
    #show "star2": name => box[
      #box(image(
        "star-score_2.svg",
        height: 4em,
      ))
    ]
    
    #show "star3": name => box[
      #box(image(
        "star-score_3.svg",
        height: 4em,
      ))
    ]
    
    #show "star4": name => box[
      #box(image(
        "star-score_4.svg",
        height: 4em,
      ))
    ]
    
    #show "star5": name => box[
      #box(image(
        "star-score_5.svg",
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
    #image("STAR_Voting_Logo-black.png", fit: "contain")
  ]
  
  align(center)[
    #box[
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
  ]
  
  ballot_table(candidates)
  
  align(center)[
    #set par(justify: true)
    The two highest scoring candidates are finalists. Your full vote goes to the finalist you prefer. The finalist with the most votes wins.
  ]

  doc
}
