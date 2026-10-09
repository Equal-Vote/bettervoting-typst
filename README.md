# How to Use

## Get Typst

Follow the instructions on [the Typst GitHub repo](https://github.com/typst/typst#installation) to install the command line interface on your machine.

## Set Up, Configure, and Make a PDF

Clone this git repo. Then from that directory, edit the list of candidates in the `main.typ` file. Run `typst watch --font-path fonts main.typ` to generate a pdf from the file. 

## Fonts

The ballot is set in OpenDyslexic. The regular and bold files are in `fonts/` under the SIL Open Font License (`fonts/OFL.txt`). Pass `--font-path fonts` so Typst finds them; without it, Typst falls back to a default font.

## Print a batch of numbered ballots

`ballots.typ` prints a batch of ballots. It starts with a cover page that lists every ballot ID in the batch, then prints one ballot per page. Each ballot shows its ID in readable text and as a QR code, beside the instructions, so copies can be told apart, and duplicates caught, when the ballots are counted. Keep the cover page with the ballots: each counted ballot's ID should appear on it exactly once.

Pass the data as JSON in the `data` input:

```sh
typst compile --font-path fonts \
  --input data='{"title": "Board election", "printed": "October 9, 2026", "candidates": ["Alice", "Bob"], "ballots": [{"id": "K7Q2M-9XW3H"}, {"id": "3HDNP-Z4R8C"}]}' \
  ballots.typ
```

For an example of the output, see [`examples/sample-ballots.pdf`](examples/sample-ballots.pdf): a cover page and three ballots.

`title` and `printed` are optional and only appear on the cover page. The QR code encodes the ID; to encode something else, such as a longer string that also names the election, give a ballot a `"qr"` field. Without a `data` input, `ballots.typ` prints a two-ballot sample batch.

`main.typ` can show an ID too: pass `ballot-id: "..."` (and optionally `qr-data: "..."`) to `conf`.

Twelve candidates fit on one page. A longer list runs onto a second page, and the ID and QR code appear only on the first.

## Vendored packages

`vendor/zebra-0.1.0` is the [zebra](https://github.com/rojul/typst-zebra) QR code package (MIT, see its `LICENSE`). It is vendored rather than imported from `@preview` so the template compiles offline and in typst.ts without fetching packages.
