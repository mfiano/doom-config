(setq-default doom-leader-key "SPC"
              doom-leader-alt "<f13>"
              doom-localleader-key ","
              doom-localleader-alt-key "<M-f13>")

(doom! :checkers
       syntax
       spell

       :completion
       (company +tng)
       (ivy +icons +prescient)

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
       common-lisp
       data
       emacs-lisp
       javascript
       latex
       markdown
       (org +dragndrop +pandoc +present)
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
       (popup +defaults +all)
       vc-gutter
       (window-select +numbers)
       workspaces

       :config
       (default +smartparens))
