(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(column-number-mode 1)
(setopt auto-revert-avoid-polling t)
(scroll-bar-mode -1)
(setopt sentence-end-double-space nil)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (global-display-line-numbers-mode 1)
(set-frame-font "personal iosevka 16" t)
(setq nano-font-family-monospaced "personal iosevka")
(setq nano-font-size 16)
(setq split-width-threshold 9999)
(setq split-height-threshold 0)
(recentf-mode 1)
(setq-default tab-width 4)
(global-auto-revert-mode 1)
(global-font-lock-mode 1)
(blink-cursor-mode -1)
(keymap-global-set "C-c c" 'org-capture)
(setq mac-command-modifier 'meta)
(require 'org-download)
(use-package orderless
  :ensure t
  :custom
  ;; (orderless-style-dispatchers '(orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)) ;; Disable defaults, use our settings
;; (ido-mode 1)
;; (ido-everywhere 1)
(defvar autosavedir (expand-file-name "~/.emacs.d/autosaves/"))
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
(make-directory autosavedir t)
(setq auto-save-file-name-transforms `((".*" ,autosavedir t)))
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq ring-bell-function 'ignore)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))
(use-package savehist
  :init
  (savehist-mode))
;; (use-package modus-themes
;;   :ensure t
;;   :init
;;   (load-theme 'modus-vivendi t))

;; (use-package ido-completing-read+
;;   :ensure t
;;   :init
;;   (ido-ubiquitous-mode 1))
;; (use-package amx
;;   :ensure t
;;   :init
;;   (amx-mode 1))
;; (use-package ido-yes-or-no
;;   :ensure t
;;   :init
;;   (ido-yes-or-no-mode 1))
;; (use-package icomplete
;;   :ensure t
;;   :init
;;   (icomplete-mode 1))

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))

(when (string= system-type "windows-nt")
  (cd "C:/Users/Jacob/"))

(electric-pair-mode t)

(use-package nano-theme
  :ensure t
  :init)


(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold nil)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic nil) ; if nil, italics is universally disabled
  ;; :config
  ;; (load-theme 'doom-badger t)
)

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-preselect 'insert)
  :bind
  (:map corfu-map
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  (corfu-history-mode))
;; :bind ("C-x C-o" . ))

(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-history)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  ;; ...
)

;; (use-package company
;;   :ensure t
;;   :init
;;   (add-hook 'after-init-hook 'global-company-mode)
;;   (setq company-idle-delay nil)
;;   (keymap-global-set "C-x C-o" 'company-complete))

(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold t)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p)
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))
  (use-short-answers t)
  (ispell-dictionary "en_US")
  )

;; (use-package which-key
;;   :ensure t     ;; This is built-in, no need to fetch it.
;;   :defer t        ;; Defer loading Which-Key until after init.
;;   :hook
;;   (after-init . which-key-mode)) ;; Enable which-key mode after initialization.

(use-package marginalia
  :ensure t
  :hook
  (after-init . marginalia-mode))

(use-package consult
  :ensure t
  :defer t
  :init
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult for xref locations with a preview feature.
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package magit
  :ensure t)

;; (use-package undo-tree
;;   :ensure t)

;; (use-package evil
;;   :ensure t
;;   :init
;;   (evil-mode 1))

(require 'view)
(keymap-global-set "C-v" (lambda () (interactive) (View-scroll-page-forward) (recenter)))
(keymap-global-set "M-v" (lambda () (interactive) (View-scroll-page-backward) (recenter)))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  (keymap-global-set "C-c p" 'projectile-command-map))

(use-package flx
  :ensure t)

;; (use-package company-fuzzy
;;   :ensure t
;;   :hook (company-mode . company-fuzzy-mode)
;;   :init
;;   (global-company-fuzzy-mode 1)
;;   (setq company-fuzzy-sorting-backend 'flx
;;         company-fuzzy-reset-selection t
;;         company-fuzzy-prefix-on-top nil
;;         company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@")))

;; (use-package fussy
;;   :ensure t
;;   :config
;;   (fussy-setup))

;; (use-package smartparens
;;   :ensure t
;;   :init
;;   (smartparens-global-mode 1))

(use-package prescient
  :ensure t
  :config
  (prescient-persist-mode 1))

(use-package corfu-prescient
  :ensure t
  :after corfu prescient
  :custom
  (corfu-prescient-enable-sorting t)
  (corfu-prescient-override-sorting nil)
  (corfu-prescient-enable-filtering nil)
  :config
  (corfu-prescient-mode 1))

;; (use-package god-mode
;;   :ensure t
;;   :init
;;   (setq god-exempt-major-modes nil)
;;   (setq god-exempt-predicates nil)
;;   (god-mode-all)
;;   (define-key god-local-mode-map (kbd "i") #'god-local-mode)
;;   (global-set-key (kbd "<escape>") #'(lambda () (interactive) (god-local-mode 1)))
;;   (define-key god-local-mode-map (kbd ".") #'repeat))


(use-package flycheck
  :ensure t
  ;; :config
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)
  )

;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory "~/roamBank")
;;   (org-roam-completion-everywhere t)
;;   :bind (("C-c o e" . org-roam-buffer-toggle)
;;          ("C-c o s" . org-roam-node-find)
;;          ("C-c o i" . org-roam-node-insert))
;;   :config
;;   (org-roam-setup))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; (use-package yasnippet-snippets
;;   :ensure t)

(use-package meow
  :ensure t
  :init
  (defun meow-setup ()
  ;; (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)
   '(":" . execute-extended-command)
   '("%" . meow-query-replace-regexp)))
  :config
  (meow-setup)
  (meow-global-mode 1))

(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "TAB") #'indent-for-tab-command))

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-copy-envs '("LIBRARY_PATH" "INFOPATH" "CPATH" "MANPATH"))
  (exec-path-from-shell-initialize))

(use-package vundo
  :ensure t)

(require 'dash)
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1)))
(add-hook 'after-change-major-mode-hook 'meow-normal-mode)

(use-package eglot-booster
  :after eglot
  :config (eglot-booster-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) .
                 ("rust-analyzer" :initializationOptions
                  (:check (:command "clippy"))))))

(use-package surround
  :ensure t
  :bind (("C-c s i" . surround-insert)
         ("C-c s d" . surround-delete)
         ("C-c s y" . surround-kill)))

(setq shell-command-switch "-ic")

(defun org-home ()
  (interactive)
  (find-file "~/org/main.org"))

(defun to-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(use-package embark
  :ensure t
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t)

(use-package vertico-prescient
  :ensure t
  :after vertico prescient
  :custom
  (vertico-prescient-enable-sorting t)
  (vertico-prescient-override-sorting nil)
  (vertico-prescient-enable-filtering nil)
  :config
  (vertico-prescient-mode 1))

(use-package org-appear
  :ensure t
  :init
  (add-hook 'org-mode-hook 'org-appear-mode))

(use-package savehist
  :init
  (savehist-mode t))
