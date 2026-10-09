#import "conf.typ": ballot-setup, star-ballot

// Prints several copies of a STAR ballot, one per page, each with its own ballot ID and
// QR code, so copies can be told apart (and duplicates caught) when the ballots are counted.
//
// The data comes in as JSON through the `data` input:
//
//   typst compile --font-path fonts \
//     --input data='{"candidates": ["Alice", "Bob"], "ballots": [{"id": "K7Q2-M9XW"}, {"id": "3HDN-PZ4R"}]}' \
//     ballots.typ
//
// Each ballot may also carry a "qr" string, which the QR code encodes instead of the ID.

#let sample = (
  candidates: ("Option 01", "Option 02", "Option 03"),
  ballots: ((id: "SAMPLE-0001"), (id: "SAMPLE-0002")),
)
#let data = if "data" in sys.inputs { json(bytes(sys.inputs.data)) } else { sample }

#show: ballot-setup

#for (i, ballot) in data.ballots.enumerate() {
  if i > 0 { pagebreak() }
  star-ballot(
    candidates: data.candidates,
    ballot-id: ballot.id,
    qr-data: ballot.at("qr", default: none),
  )
}
