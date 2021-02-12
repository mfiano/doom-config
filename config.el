(setq default-input-method "TeX"
      delete-trailing-lines t
      display-line-numbers-type t
      doom-big-font (font-spec :family "Iosevka Slab" :size 30)
      doom-font (font-spec :family "Iosevka Slab" :size 22)
      doom-theme 'doom-one
      echo-keystrokes 0.1
      focus-follows-mouse t
      locale-coding-system 'utf-8
      make-pointer-invisible t
      mouse-autoselect-window t
      mouse-wheel-follow-mouse t
      mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(3)
      mouse-yank-at-point t
      org-directory "~/Projects/Org/"
      select-enable-primary t
      user-full-name "Michael Fiano"
      user-mail-address "mail@michaelfiano.com"
      vc-follow-symlinks t)

(setq-default auto-save-default nil
              auto-save-list-file-prefix nil
              backup-inhibited t
              buffer-file-coding-system 'utf-8
              create-lockfiles nil
              fill-column 100
              find-file-visit-truename t
              indent-tabs-mode nil
              indicate-empty-lines t
              read-file-name-completion-ignore-case t
              require-final-newline t
              sentence-end-double-space nil
              truncate-lines t)

(setq mfiano/lisp-implementations
      '((sbcl ("ros" "dynamic-space-size=8000" "-L" "sbcl" "run"))
        (sbcl-renderdoc ("renderdoccmd" "capture" "-w" "--opt-api-validation"
                         "ros" "dynamic-space-size=4000" "-L" "sbcl" "run"))
        (ccl ("ros" "-L" "ccl-bin" "run"))))

;;; Builtin Doom packages

(when (featurep! :ui window-select)
  (after! ace-window
    (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))))

(when (featurep! :completion company)
  (after! company
    (setq company-idle-delay nil)))

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
    (magit-todos-mode)
    (setq)
    (setq transient-values '((magit-log:magit-log-mode "--graph" "--color" "--decorate"))
          magit-log-auto-more t
          magit-log-margin-show-committer-date t
          magit-delete-by-moving-to-trash nil
          magit-wip-after-save-mode t
          magit-wip-after-apply-mode t
          magit-wip-before-change-mode t
          git-commit-summary-max-length 120)))

(when (featurep! :lang common-lisp)
  (after! sly
    (setq sly-lisp-implementations mfiano/lisp-implementations
          sly-autodoc-use-multiline t
          sly-complete-symbol-function 'sly-flex-completions
          sly-enable-evaluate-in-emacs t)
    (add-to-list 'company-backends '(company-capf company-files))
    (set-popup-rule! "^\\*sly-mrepl"
      :vslot 2 :side 'bottom :size 0.25 :quit nil :ttl nil)))

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
  (sp-pair "(" nil :unless '(:rem sp-point-before-word-p))
  (smartparens-global-strict-mode 1))

(after! web-mode
  (setq web-mode-markup-indent-offset 2))

(after! which-key
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-idle-delay 0.25
        which-key-idle-secondary-delay 0.25))

;;; Additional packages
(use-package! aggressive-indent
  :config
  (add-hook! prog-mode (aggressive-indent-mode 1)))

(use-package! evil-cleverparens
  :init
  (setq evil-move-beyond-eol t
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-swap-move-by-word-and-symbol t
        evil-cleverparens-use-regular-insert t)
  (add-hook! prog-mode #'evil-cleverparens-mode)
  (after! sly
    (add-hook! sly-mrepl-mode #'evil-cleverparens-mode)))

(use-package! hungry-delete
  :init (setq hungry-delete-join-reluctantly t)
  :config
  (after! smartparens
    (global-hungry-delete-mode)
    (add-hook! smartparens-enabled-hook #'hungry-delete-mode)))

(use-package! whitespace-cleanup-mode
  :init (global-whitespace-cleanup-mode 1)
  :config (add-hook! before-save #'delete-trailing-whitespace))

;;; Hacks

;; ivy-resume no longer refreshes contents if file on disk differs since last
;; call when searching across a buffer/project. This attempts to fix that.
(defadvice! refresh-on-ivy-resume (orig-fn &rest args)
  :around #'ivy--reset-state
  (let ((this-command this-command))
    (when (eq this-command 'ivy-resume)
      (setq this-command nil))
    (apply orig-fn args)))

;;; Includes

(load! "+functions")
(load! "+bindings")
