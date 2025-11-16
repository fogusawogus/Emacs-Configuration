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
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (global-display-line-numbers-mode 1)
(set-frame-font "personal iosevka 16" t)
(recentf-mode 1)
(setq-default tab-width 4)
(global-auto-revert-mode 1)
(global-font-lock-mode 1)
(blink-cursor-mode -1)
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
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

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

(electric-pair-mode)

(use-package nano-theme
  :ensure t
  :init
  (load-theme 'nano-dark t))

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold nil)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic nil) ; if nil, italics is universally disabled
  ;; :config
  ;; (load-theme 'doom-badger t)
)

;; (use-package corfu
;;   :ensure t
;;   :init
;;   (global-corfu-mode)
;;   (corfu-history-mode))

;; (use-package cape
;;   :ensure t
;;   ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
;;   ;; Press C-c p ? to for help.
;;   :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
;;   ;; Alternatively bind Cape commands individually.
;;   ;; :bind (("C-c p d" . cape-dabbrev)
;;   ;;        ("C-c p h" . cape-history)
;;   ;;        ("C-c p f" . cape-file)
;;   ;;        ...)
;;   :init
;;   ;; Add to the global default value of `completion-at-point-functions' which is
;;   ;; used by `completion-at-point'.  The order of the functions matters, the
;;   ;; first function returning a result wins.  Note that the list of buffer-local
;;   ;; completion functions takes precedence over the global list.
;;   (add-hook 'completion-at-point-functions #'cape-dabbrev)
;;   (add-hook 'completion-at-point-functions #'cape-file)
;;   (add-hook 'completion-at-point-functions #'cape-elisp-block)
;;   (add-hook 'completion-at-point-functions #'cape-history)
;;   ;; ...
;; )

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay nil)
  (keymap-global-set "C-x C-o" 'company-complete))

(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  ;; (tab-always-indent 'complete)

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

(use-package undo-tree
  :ensure t)

;; (use-package evil
;;   :ensure t
;;   :init
;;   (evil-mode 1))

(require 'view)
(keymap-global-set "C-v" (lambda () (interactive) (View-scroll-half-page-forward) (recenter)))
(keymap-global-set "M-v" (lambda () (interactive) (View-scroll-half-page-backward) (recenter)))

;; (use-package projectile
;;   :ensure t
;;   :init
;;   (projectile-mode +1)
;;   (keymap-global-set "C-c p" 'projectile-command-map))
