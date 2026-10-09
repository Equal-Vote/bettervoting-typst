# How to Use

## Get Typst

Follow the instructions on [the Typst GitHub repo](https://github.com/typst/typst#installation) to install the command line interface on your machine.

## Set Up, Configure, and Make a PDF

Clone this git repo. Then from that directory, edit the list of candidates in the `main.typ` file. Run `typst watch --font-path fonts main.typ` to generate a pdf from the file. 

## Fonts

The ballot is set in OpenDyslexic. The regular and bold files are in `fonts/` under the SIL Open Font License (`fonts/OFL.txt`). Pass `--font-path fonts` so Typst finds them; without it, Typst falls back to a default font.

## Print numbered copies

`ballots.typ` prints several copies of a ballot, one per page. Each copy has its own ballot ID and a QR code beside the instructions, so copies can be told apart, and duplicates caught, when the ballots are counted. Pass the candidates and IDs as JSON in the `data` input:

```sh
typst compile --font-path fonts \
  --input data='{"candidates": ["Alice", "Bob"], "ballots": [{"id": "K7Q2-M9XW"}, {"id": "3HDN-PZ4R"}]}' \
  ballots.typ
```

The QR code encodes the ID. To encode something else, such as a longer string that also names the election, give a ballot a `"qr"` field. Without a `data` input, `ballots.typ` prints two sample copies.

`main.typ` can show an ID too: pass `ballot-id: "..."` (and optionally `qr-data: "..."`) to `conf`.

Twelve candidates fit on one page. A longer list runs onto a second page, and the ID and QR code appear only on the first.

## Vendored packages

`vendor/zebra-0.1.0` is the [zebra](https://github.com/rojul/typst-zebra) QR code package (MIT, see its `LICENSE`). It is vendored rather than imported from `@preview` so the template compiles offline and in typst.ts without fetching packages.
