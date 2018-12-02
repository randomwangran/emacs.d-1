;;; init-prog-lang-shell.el --- init for Shell Scripts
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ `sh-mode' (shell-script-mode ]

(setq sh-indentation 2
      sh-basic-offset 2)

;;; [ Bash ]

;;; [ Zsh ]

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh-theme\\'" . sh-mode))

;; A programmatic way of selecting a flavor when you don't want to use the
;; shebang is doing this in a sh-mode buffer:
(defun my-sh-mode-zsh-setup ()
  "Setup `sh-mode' engine to Zsh."
  (interactive)
  (if (and (buffer-file-name) ; filer out non-file buffers which will returns nil
           (string-match "\\.zsh$" (buffer-file-name)))
      (sh-set-shell "zsh")))

(add-hook 'sh-mode-hook #'my-sh-mode-zsh-setup)

;;; [ company-shell ] -- company-mode backend for shell script completion.

;; (use-package company-shell
;;   :ensure t
;;   :config
;;   (setq company-shell-modes '(sh-mode fish-mode shell-mode eshell-mode))
;;   (setq company-shell-use-help-arg nil)
;;
;;   (defun my-company-shell-setup ()
;;     ;; (setq-local completion-at-point-functions
;;     ;;             (delq 'sh-completion-at-point-function
;;     ;;                   completion-at-point-functions))
;;     (setq-local company-minimum-prefix-length 2)
;;     (add-to-list 'company-backends
;;                  '(company-shell :with company-shell-env))
;;     )
;;
;;   (dolist (hook '(sh-mode-hook
;;                   shell-mode-hook
;;                   ))
;;     (add-hook hook #'my-company-shell-setup))
;;   )

;;; [ lsp-sh ] -- Bash support for lsp-mode using Mads Hartmann's bash-language-server.

;; (use-package lsp-sh
;;   :ensure t
;;   :ensure-system-package ((bash-language-server . "npm i -g bash-language-server@1.4.0"))
;;   :after lsp
;;   :hook (sh-mode . lsp))



(provide 'init-prog-lang-shell)

;;; init-prog-lang-shell.el ends here
