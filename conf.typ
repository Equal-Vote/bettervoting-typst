#let conf(
  candidates: (),
  doc
) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.5in, y: 0.15in),
  )
  
  set text(
    font: "Montserrat",
    size: 16pt,
  )
  
  set par(
    justify: true,
    leading: 0.5em, //spacing between lines
  )
  
  let ballot_table(candidates) = [
    #show "bubble0": name => box[
      #box(image(
        "images/STAR_Ballot_bubble-0.svg",
        height: 1.5em,
      ))
    ]
    
    #show "bubble1": name => box[
      #box(image(
        "images/STAR_Ballot_bubble-1.svg",
        height: 1.5em,
      ))
    ]
    
    #show "bubble2": name => box[
      #box(image(
        "images/STAR_Ballot_bubble-2.svg",
        height: 1.5em,
      ))
    ]
    
    #show "bubble3": name => box[
      #box(image(
        "images/STAR_Ballot_bubble-3.svg",
        height: 1.5em,
      ))
    ]
    
    #show "bubble4": name => box[
      #box(image(
        "images/STAR_Ballot_bubble-4.svg",
        height: 1.5em,
      ))
    ]
    
    #show "bubble5": name => box[
      #box(image(
        "images/STAR_Ballot_bubble-5.svg",
        height: 1.5em,
      ))
    ]
    
    #show "star0": name => box[
      #box(image(
        "images/STAR_Ballot_legend-0.svg",
        height: 2.5em,
      ))
    ]
    
    #show "star1": name => box[
      #box(image(
        "images/STAR_Ballot_legend-1.svg",
        height: 2.5em,
      ))
    ]
    
    #show "star2": name => box[
      #box(image(
        "images/STAR_Ballot_legend-2.svg",
        height: 2.5em,
      ))
    ]
    
    #show "star3": name => box[
      #box(image(
        "images/STAR_Ballot_legend-3.svg",
        height: 2.5em,
      ))
    ]
    
    #show "star4": name => box[
      #box(image(
        "images/STAR_Ballot_legend-4.svg",
        height: 2.5em,
      ))
    ]
    
    #show "star5": name => box[
      #box(image(
        "images/STAR_Ballot_legend-5.svg",
        height: 2.5em,
      ))
    ]
  
    #set table(align: (x, _) => {
        if x == 0 {
          // Align vertically and horizontally
          left + horizon
        } else {
          center + horizon
        }}
    )
    
    #set table(fill: (_, y) => {
        if y >= 2 and calc.even(y) {
          // Fill odd rows light blue
          rgb("E0F0F3FF") 
        }}
    )
    
    #let table_insets() = (x, _) => (
        right: if x == 0 { 20pt } else { 0pt },
        left:  if x == 0 { 30pt } else { 0pt },        
        y:     8pt,
    )
    
    // Outputs a stroke pattern for a table
    #let frame() = (x, y) => (
      left:   if ( x == 0 and y == 0 ) 
                  { 2pt + rgb("000000") }
                else if ( x == 0 and y > 0 and calc.even(y) ) 
                  { 2pt + rgb("A2C4C9FF") }
                else if ( x == 0 and y >= 1 and calc.odd(y) )
                  { 2pt + rgb("000000") }
                else { none },
      right:  if ( x == 6 and y == 0 ) 
                  { 2pt + rgb("000000") }
                else if ( x == 6 and y > 0 and calc.even(y) ) 
                  { 2pt + rgb("A2C4C9FF") }
                else if ( x == 6 and y > 0 and calc.odd(y) )
                  { 2pt + rgb("000000") }
                else { none },
      top:    if ( y == 0 )
                  { 2pt + rgb("000000") }
                else if ( y > 1 )
                  { 2pt + rgb("A2C4C9FF") } 
                else { none },
      bottom: if ( y == 1 ) { 2pt + rgb("000000") }
                else { none },
    )
   
    #show table.cell.where(x: 0): set text(weight: 700, size: 19.34pt)
    
    #table(
      inset: table_insets(),
      columns: (4fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      stroke: frame(),
      table.header(
        table.cell(colspan: 7)[
          #align(top+center)[
            #image(
              "images/STAR_Voting_Logo-blue_whitebackground.png",
              width:   4.832in,
              height:  0.849in,
              fit: "contain",
            )
          ]
          
          #align(left)[
            #box[
              #align(left)[
                #list(
                  body-indent: 0.5em,
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
        ]
      ),
      table.header(
        [],
        [#text(weight: 600)[Worst] \ star0],
        [\ star1],
        [\ star2],
        [\ star3],
        [\ star4],
        [#text(weight: 600)[Best] \ star5],
      ),
      ..for name in candidates.sorted() {
        ( [ #name ],
          [ bubble0 ],
          [ bubble1 ],
          [ bubble2 ],
          [ bubble3 ],
          [ bubble4 ],
          [ bubble5 ],
        )
      },
      table.footer(
        table.cell(colspan: 7)[
            #align(center)[
              #set par(justify: true)
              The two highest scoring candidates are finalists.\
              Your full vote goes to the finalist you prefer.\
              The finalist with the most votes wins.
            ]\ #align(right)[BALLOT_ID_PLACEHOLDER]],
      ),
    )
  ]
  
  ballot_table(candidates)


  doc
}
