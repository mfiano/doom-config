(setq-default doom-leader-key "SPC"
              doom-leader-alt "<f13>"
              doom-localleader-key ","
              doom-localleader-alt-key "<M-f13>")

(doom! :checkers
       syntax
       spell

       :completion
       (company +tng)
       (ivy +prescient +icons)

       :editor
       (evil +everywhere)
       fold
       multiple-cursors

       :emacs
       (dired +ranger +icons)
       electric
       (ibuffer +icons)
       vc

       :lang
       clojure
       common-lisp
       data
       emacs-lisp
       javascript
       latex
       markdown
       nim
       (org +dragndrop +gnuplot +pandoc +present)
       python
       rust
       sh
       web

       :term
       shell

       :tools
       (eval +overlay)
       gist
       (lookup +dictionary +docsets)
       magit

       :ui
       doom
       fill-column
       hl-todo
       modeline
       nav-flash
       neotree
       ophints
       (popup +all +defaults)
       tabs
       vc-gutter
       (window-select +numbers)
       workspaces)
