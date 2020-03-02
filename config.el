(setq default-input-method "TeX"
      delete-trailing-lines t
      display-line-numbers-type t
      doom-big-font (font-spec :family "Iosevka Slab" :size 34)
      doom-font (font-spec :family "Iosevka Slab" :size 22)
      doom-scratch-initial-major-mode t
      doom-theme 'doom-one
      echo-keystrokes 0.1
      focus-follows-mouse t
      locale-coding-system 'utf-8
      make-pointer-invisible t
      mouse-autoselect-window t
      mouse-wheel-follow-mouse t
      mouse-wheel-progressive-speed nil
      mouse-yank-at-point t
      org-directory "~/Projects/Org/"
      user-full-name "Michael Fiano"
      user-mail-address "mail@michaelfiano.com"
      vc-follow-symlinks t)

(setq-default auto-save-default nil
              auto-save-list-file-prefix nil
              backup-inhibited t
              buffer-file-coding-system 'utf-8
              create-lockfiles nil
              fill-column 80
              find-file-visit-truename t
              indent-tabs-mode nil
              indicate-empty-lines t
              read-file-name-completion-ignore-case t
              require-final-newline t
              sentence-end-double-space nil
              truncate-lines t)

(setq mfiano/lisp-implementations
      '((sbcl ("ros" "dynamic-space-size=4000" "-L" "sbcl" "run"))
        (sbcl-renderdoc ("renderdoccmd" "capture" "-w" "--opt-api-validation"
                         "ros" "dynamic-space-size=4000" "-L" "sbcl" "run"))
        (ccl ("ros" "-L" "ccl-bin" "run"))))

(defvar +default-minibuffer-maps
  `(minibuffer-local-map
    minibuffer-local-ns-map
    minibuffer-local-completion-map
    minibuffer-local-must-match-map
    minibuffer-local-isearch-map
    read-expression-map
    ,@(when (featurep! :completion ivy)
        '(ivy-minibuffer-map
          ivy-switch-buffer-map))))

;;; Builtin Doom packages

(when (featurep! :ui window-select)
  (after! ace-window
    (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))))

(when (featurep! :completion company)
  (after! company
    (setq company-idle-delay nil)))

;; TODO: This feature is disabled in init.el for now until the flicker bug is
;; resolved upstream.
(when (featurep! :ui tabs)
  (after! centaur-tabs
    (setq centaur-tabs-style "alternate"
          centaur-tabs-height 40
          centaur-tabs-set-bar nil)
    (centaur-tabs-group-by-projectile-project)))

(after! eldoc
  (setq eldoc-idle-delay 0.1))

(when (featurep! :editor evil)
  (after! evil
    (setq +evil-want-o/O-to-continue-comments nil)))

(when (featurep! :tools gist)
  (after! gist
    (setq gist-view-gist t)))

(when (featurep! :tools magit)
  (after! magit
    (magit-wip-mode)
    (setq magit-log-arguments '("--graph" "--decorate" "--color")
          magit-delete-by-moving-to-trash nil
          git-commit-summary-max-length 120)))

(when (featurep! :lang common-lisp)
  (after! sly
    (setq sly-lisp-implementations mfiano/lisp-implementations
          sly-autodoc-use-multiline t
          sly-complete-symbol-function 'sly-flex-completions)
    (add-to-list 'company-backends '(company-capf company-files))))

(after! persp-mode
  (setq persp-auto-save-opt 0))

(after! smartparens
  (setq sp-show-pair-from-inside t
        sp-cancel-autoskip-on-backward-movement nil
        sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil
        sp-navigate-skip-match nil
        sp-navigate-consider-sgml-tags nil)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem)
  (smartparens-global-strict-mode 1))

(after! which-key
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-idle-delay 0.25
        which-key-idle-secondary-delay 0.25))

;;; Additional packages

(use-package! aggressive-indent
  :config (add-hook! prog-mode (aggressive-indent-mode 1)))

(use-package! evil-cleverparens
  :init
  (setq evil-move-beyond-eol t
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-swap-move-by-word-and-symbol t
        evil-cleverparens-use-regular-insert t)
  (add-hook! prog-mode #'evil-cleverparens-mode)
  (after! sly
    (add-hook! sly-mrepl-mode #'evil-cleverparens-mode)))

(use-package! whitespace-cleanup-mode
  :init (global-whitespace-cleanup-mode 1)
  :config (add-hook! before-save #'delete-trailing-whitespace))

;;; Includes

(load! "+functions")
(load! "+bindings")
