# note

`note` is a command-line utility that allows you to create and edit notes in
your local filesystem.

**Notable features:**  
- supported note formats:
    - `*.txt`: plain text
    - `*.md`: markdown
    - `*.tex`: XeLaTeX
    - `*.typ`: Typst
    - `*.ly`: Lilypond
- every note is a directory and may contain arbitrary files and subdirectories
  within, but there is always a single "main" file
- notes are version controlled using git
- for heavier formats, there is a seamless caching mechanism to mitigate build
  delay when trying to view a note
- uses `$EDITOR` for editing, `${PDF_READER:-zathura}` for viewing PDFs and
  `${BROWSER:-firefox}` for viewing HTML

**Limitations:**  
- the script relies on some hard-coded external tools:
    - [bemenu](https://github.com/Cloudef/bemenu)
    - [secrets](https://github.com/randoragon/secrets)
    - [lxmake](https://github.com/randoragon/lxmake)
    - rsync
    - md2html
    - git
    - typst
    - xelatex (texlive-basic, latexrecommended, fontsrecommended, latexextra,
      plaingeneric, langcjk, binextra, bibtexextra)
- in general, this script exists for personal use and is not very configurable
