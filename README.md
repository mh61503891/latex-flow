[![Gem Version](https://badge.fury.io/rb/latex-flow.svg)](http://badge.fury.io/rb/latex-flow)

# latex-flow

Latex-flow is a command-line tool to support LaTeX's workflow.

**This is a beta version.**

## Features

- **Command Wrapper** for LaTeX, BibTex, and Dvipdfm
- **Syntax Highlight of Logs** for LaTeX, BibTeX, and Dvipdfm
- **Automated build** by monitoring change of source files (*.tex|*.bib)
- **Archiving** of source files
- TODO: **LaTeX's template manager and repository**

## Installation

    $ gem install latex-flow

## Usage

### Automated Build

```
$ ls
main.tex main.bib
$ latex-flow build main --auto --color --verbose
```

### Environment Variables

- `LATEX`
- `BIBTEX`
- `DVIPDFM`

#### Example

```
LATEX='platex -kanji=utf8 -halt-on-error' BIBTEX='pbibtex -kanji=utf8' DVIPDFM='dvipdfmx' latex-flow build main --auto --color --verbose
```

### Help

```
$ latex-flow help
Commands:
  latex-flow archive TAG               # Archive files into ./archives/1404138641-[TAG].zip
  latex-flow archives                  # Show a list of archives in ./archives/
  latex-flow bibtex TARGET [OPTIONS]   # Execute the bibtex command
  latex-flow build TARGET [OPTIONS]    # Build a pdf file
  latex-flow clean                     # Remove any temporary files
  latex-flow dvipdfm TARGET [OPTIONS]  # Execute the dvipdfm command
  latex-flow help [COMMAND]            # Describe available commands or one specific command
  latex-flow latex TARGET [OPTIONS]    # Execute the latex command
  latex-flow version                   # Show LatexFlow's version information

Options:
  -V, [--verbose=Enable verbose output mode], [--no-verbose]
  -C, [--color=Enable color output mode], [--no-color]
```
