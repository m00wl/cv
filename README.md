# `cv` - my curriculum vitae

This repository contains my CV.

Tested with `TeX Live 2021`, `LuaHBTeX 1.13.0` and `latexmk 4.76`.

## Usage

### nix:
- build the `cv` derivation (the PDF) and make it available in the nix store:
```shell
nix build
```
- print PDF-tags of the `ws` derivation from the nix store:
```shell
nix run
```
- drop into a build environment (e.g. to execute tex-live commands manually):
```shell
nix develop
```

### non-nix:

- generate `cv.pdf`:
```shell
latexmk -outdir=build -pdf -lualatex cv.tex
```
- inspect PDF-tags of `cv.pdf`:
```shell
exiftool build/cv.pdf
```

### CI/CD

WIP

## License & Copyright

Powered by the [`moderncv`](https://github.com/susam/spcss) LaTeX template.

This is free and open source software.
You can use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of it, under the terms of the BSD 3-Clause License.
See [LICENSE.md](./LICENSE.md) for details.