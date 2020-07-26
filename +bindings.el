(map!
 "<M-left>" #'left-word
 "<M-right>" #'right-word
 [remap move-beginning-of-line] #'mfiano/smarter-move-beginning-of-line
 (:after help :map help-mode-map
  :n "o" #'link-hint-open-link)
 (:after helpful :map helpful-mode-map
  :n "o" #'link-hint-open-link)
 (:after info :map info-mode-map
  :n "o" #'link-hint-open-link)
 (:after apropos :map apropos-mode-map
  :n "o" #'link-hint-open-link
  :n [tab] #'forward-button
  :n [backtab] #'backward-button)
 (:after view :map view-mode-map
  [escape] #'view-quit-all)
 (:when (featurep! :completion company)
  :i [tab] #'+company/complete
  (:after company
   (:map company-active-map
    "C-w" nil
    [tab] #'company-complete-common-or-cycle
    [backtab] #'company-select-previous))
  (:after comint :map comint-mode-map
   [tab] #'company-complete))
 (:when (featurep! :completion ivy)
  (:after ivy
   :map ivy-minibuffer-map
   "C-SPC" #'ivy-call-and-recenter))
 (:when (featurep! :emacs vc)
  (:after git-timemachine
   (:map git-timemachine-mode-map
    :n "[" #'git-timemachine-show-previous-revision
    :n "]" #'git-timemachine-show-next-revision
    :n "b" #'git-timemachine-blame)))
 (:after windmove
  "<S-up>" #'windmove-up
  "<S-down>" #'windmove-down
  "<S-left>" #'windmove-left
  "<S-right>" #'windmove-right)
 (:when (featurep! :ui workspaces)
  :n "M-t" #'+workspace/new
  :g "M-1" #'+workspace/switch-to-0
  :g "M-2" #'+workspace/switch-to-1
  :g "M-3" #'+workspace/switch-to-2
  :g "M-4" #'+workspace/switch-to-3
  :g "M-5" #'+workspace/switch-to-4
  :g "M-6" #'+workspace/switch-to-5
  :g "M-7" #'+workspace/switch-to-6
  :g "M-8" #'+workspace/switch-to-7
  :g "M-9" #'+workspace/switch-to-8
  :g "M-0" #'+workspace/switch-to-final)
 (:when (featurep! :ui tabs)
  "M-[" #'centaur-tabs-backward-tab
  "M-]" #'centaur-tabs-forward-tab)
 (:after sly
  (:map sly-mrepl-mode-map
   [S-return] #'newline-and-indent
   :i [up] (λ! (evil-goto-line) (comint-previous-input 1))
   :i [down] (λ! (evil-goto-line) (comint-next-input 1))
   :i [backspace] #'sp-backward-delete-char))
 (:after macrostep
  (:map macrostep-keymap
   :n [tab] #'macrostep-next-macro
   :n [backtab] #'macrostep-prev-macro
   :n "c" #'macrostep-collapse
   :n "e" #'macrostep-expand
   :n "q" #'macrostep-collapse-all))
 (:when (featurep! :ui popup)
  :g "M-TAB" #'+popup/toggle)

 :leader
 :desc "Eval expression" ";" #'pp-eval-expression
 :desc "M-x" "SPC" #'execute-extended-command
 :desc "Universal argument" "u" #'universal-argument
 :desc "Resume search" "'" #'ivy-resume
 (:when (featurep! :ui workspaces)
  (:prefix-map ("TAB" . "workspace")
   :desc "Switch" [tab] #'+workspace/switch-to
   :desc "Delete" "d" #'+workspace/delete
   :desc "Delete all" "D" #'+workspace/kill-session
   :desc "Load" "l" #'+workspace/load
   :desc "New" "n" #'+workspace/new
   :desc "Rename" "r" #'+workspace/rename
   :desc "Restore" "R" #'+workspace/restore-last-session
   :desc "Save" "s" #'+workspace/save))
 (:prefix-map ("b" . "buffer")
  (:when (featurep! :ui workspaces)
   :desc "Switch workspace buffer" "b" #'persp-switch-to-buffer ;
   :desc "Switch buffer" "B" #'switch-to-buffer)
  (:unless (featurep! :ui workspaces)
   :desc "Switch buffer" "b" #'switch-to-buffer)
  :desc "Delete" "d" #'kill-current-buffer
  :desc "Narrow" "n" #'doom/toggle-narrow-buffer
  :desc "Revert" "r" #'revert-buffer)
 (:prefix-map ("f" . "file")
  :desc "Copy" "c" #'doom/copy-this-file
  :desc "Find directory" "d" #'dired
  :desc "Delete" "D" #'doom/delete-this-file
  :desc "Find in emacs.d" "e" #'+default/find-in-emacsd
  :desc "Browse emacs.d" "E" #'+default/browse-emacsd
  :desc "Find" "f" #'find-file
  :desc "Find here" "F" #'+default/find-file-under-here
  :desc "Find in private config" "p" #'doom/find-file-in-private-config
  :desc "Browse private config" "P" #'doom/open-private-config
  :desc "Recent" "r" #'recentf-open-files
  :desc "Rename" "R" #'doom/move-this-file
  :desc "Save" "s" #'save-buffer
  :desc "Save as" "S" #'write-file)
 (:prefix-map ("g" . "git")
  (:when (featurep! :tools gist)
   :desc "Gist" "g" #'gist-region-or-buffer
   :desc "Gist private" "G" #'gist-region-or-buffer-private)
  (:when (featurep! :tools magit)
   :desc "Browse homepage" "b" #'forge-browse-remote
   :desc "View remote commit" "c" #'forge-browse-commit
   :desc "Initialize repository" "i" #'magit-init
   :desc "Status" "s" #'magit-status)
  (:when (featurep! :emacs vc)
   :desc "Time machine" "t" #'git-timemachine-toggle))
 (:prefix-map ("h" . "help")
  :desc "Point" "." #'helpful-at-point
  :desc "Apropos" "a" #'apropos
  :desc "Character" "c" #'describe-char
  :desc "Function" "f" #'helpful-callable
  :desc "Face" "F" #'describe-face
  :desc "Info" "i" #'info-lookup-symbol
  :desc "Key" "k" #'helpful-key
  :desc "Library" "l" #'find-library
  :desc "Minor mode" "m" #'describe-minor-mode
  :desc "Major mode" "M" #'describe-mode
  :desc "Variable" "v" #'helpful-variable)
 (:prefix-map ("n" . "notes")
  :desc "Search at point" "." #'+default/search-notes-for-symbol-at-point
  :desc "Agenda" "a" #'org-agenda
  :desc "Browse" "b" #'+default/browse-notes
  :desc "Toggle clock" "c" #'+org/toggle-clock
  :desc "Cancel clock" "C" #'org-clock-cancel
  :desc "Capture note" "n" #'org-capture
  :desc "Find" "f" #'+default/find-in-notes
  :desc "Search notes" "s" #'+default/org-notes-search
  :desc "Search headlines" "S" #'+default/org-notes-headlines
  :desc "Tag search" "t" #'org-tags-view
  :desc "Todo list" "T" #'org-todo-list)
 (:prefix-map ("o" . "open")
  :desc "New frame" "f" #'make-frame
  (:when (featurep! :ui neotree)
   :desc "Toggle project sidebar" "p" #'+neotree/open
   :desc "Project sidebar find file" "P" #'+neotree/find-this-file)
  :desc "REPL popup" "r" #'+eval/open-repl-other-window
  :desc "REPL buffer" "R" #'+eval/open-repl-same-window
  (:when (featurep! :term shell)
   :desc "Toggle shell popup" "s" #'+shell/toggle
   :desc "Shell in buffer" "S" #'+shell/here))
 (:prefix-map ("p" . "project")
  :desc "Browse current project" "." #'+default/browse-project
  :desc "Browse other project" ">" #'doom/browse-in-other-project
  :desc "Add new" "a" #'projectile-add-known-project
  :desc "Switch buffer" "b" #'projectile-switch-to-buffer
  :desc "Invalidate cache" "c" #'projectile-invalidate-cache
  :desc "Delete" "d" #'projectile-remove-known-project
  :desc "Find file" "f" #'projectile-find-file
  :desc "Find file other project" "F" #'doom/find-file-in-other-project
  :desc "Kill buffers" "k" #'projectile-kill-buffers
  :desc "Switch project" "p" #'projectile-switch-project
  :desc "Find recent" "r" #'projectile-recentf
  :desc "Save files" "s" #'projectile-save-project-buffers
  :desc "List tasks" "t" #'magit-todos-list
  :desc "Popup scratch buffer" "x" #'doom/open-project-scratch-buffer
  :desc "Switch to scratch buffer" "X" #'doom/switch-to-project-scratch-buffer)
 (:prefix-map ("q" . "quit")
  :desc "Quit" "q" #'save-buffers-kill-emacs
  :desc "Quit without saving" "Q" #'evil-quit-all-with-error-code
  :desc "Restart" "r" #'doom/restart
  :desc "Restart/restore" "R" #'doom/restart-and-restore)
 (:prefix-map ("s" . "search")
  :desc "Search buffer" "b" #'swiper-isearch
  :desc "Search buffer at point" "B" #'swiper-isearch-thing-at-point
  :desc "Search current directory" "d" #'+default/search-cwd
  :desc "Search other directory" "D" #'+default/search-other-cwd
  :desc "Jump to link" "l" #'ffap-menu
  :desc "Multi-edit" "m" #'evil-multiedit-match-all
  :desc "Multi-edit restrict region" "M" #'evil-multiedit-toggle-or-restrict-region
  :desc "Search project" "p" #'+default/search-project
  :desc "Search other project" "P" #'+default/search-other-project)
 (:prefix-map ("t" . "toggle")
  :desc "Big mode" "b" #'doom-big-font-mode
  :desc "Line numbers" "l" #'doom/toggle-line-numbers
  :desc "Spell check" "s" #'flyspell-mode)
 (:prefix-map ("w" . "window")
  :desc "Select window 1" "1" #'winum-select-window-1
  :desc "Select window 2" "2" #'winum-select-window-2
  :desc "Select window 3" "3" #'winum-select-window-3
  :desc "Select window 4" "4" #'winum-select-window-4
  :desc "Select window 5" "5" #'winum-select-window-5
  :desc "Select window 6" "6" #'winum-select-window-6
  :desc "Select window 7" "7" #'winum-select-window-7
  :desc "Select window 8" "8" #'winum-select-window-8
  :desc "Select window 9" "9" #'winum-select-window-9
  :desc "Balance" "=" #'balance-windows
  :desc "Split horizontally" "-" #'evil-window-split
  :desc "Split vertically" "|" #'evil-window-vsplit
  :desc "Delete" "d" #'evil-window-delete
  :desc "Delete others" "D" #'delete-other-windows
  :desc "New frame" "f" #'new-frame
  :desc "Delete frame" "F" #'delete-frame
  :desc "Grow/shrink" "g" #'doom/window-enlargen
  :desc "Maximize/minimize" "m" #'doom/window-maximize-buffer
  :desc "Redo" "r" #'winner-redo
  :desc "Swap" "s" #'ace-swap-window
  :desc "Undo" "u" #'winner-undo
  :desc "Go to" "w" #'ace-window)

 :localleader
 (:map (emacs-lisp-mode-map lisp-mode-map sly-mrepl-mode-map)
  (:prefix-map ("l" . "lisp")
   :desc "Absorb" "a" #'sp-absorb-sexp
   :desc "Barf forward" "b" #'sp-forward-barf-sexp
   :desc "Barf backward" "B" #'sp-backward-barf-sexp
   :desc "Convolute" "c" #'sp-convolute-sexp
   :desc "Splice killing backward" "e" #'sp-splice-sexp-killing-backward
   :desc "Splice killing forward" "E" #'sp-splice-sexp-killing-forward
   :desc "Join" "j" #'sp-join-sexp
   :desc "Open below" "o" #'evil-cp-open-below-form
   :desc "Open above" "O" #'evil-cp-open-above-form
   :desc "Raise" "r" #'sp-raise-sexp
   :desc "Slurp forward" "s" #'sp-forward-slurp-sexp
   :desc "Slurp backward" "S" #'sp-backward-slurp-sexp
   :desc "Transpose" "t" #'sp-transpose-sexp
   :desc "Wrap" "w" #'sp-wrap-round
   :desc "Unwrap" "W" #'sp-unwrap-sexp)))
