;;; init-prog-lsp.el --- init for Language Server Protocol

;;; Commentary:



;;; Code:

;;; [ eglot ] -- Client for Language Server Protocol (LSP) servers.

;; (use-package eglot
;;   :ensure t
;;   :hook (prog-mode . eglot-ensure))

;;; [ lsp-mode ] -- clients for servers using Language Server Protocol.

(use-package lsp-mode
  :ensure t
  :defer t
  :load (lsp-clients) ; load `lsp-clients' for auto configuration of language server clients.
  :commands (lsp lsp-describe-session)
  ;; :hook (prog-mode . lsp)
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point)
              ("M-RET"   . lsp-execute-code-action))
  ;; speed-up lsp-mode performance
  :custom ((lsp-log-io nil)             ; for Debug
           ;; (lsp-enable-folding nil)
           ;; (lsp-diagnostic-package :none) ; no real-time syntax check
           ;; (lsp-enable-snippet nil) ; handle yasnippet by myself
           (lsp-enable-symbol-highlighting nil)
           (lsp-enable-links nil))
  :hook (lsp-mode . lsp-enable-which-key-integration)
  :config
  ;; disable some lsp clients
  ;; (add-to-list 'lsp-disabled-clients 'ccls)
  ;; (add-to-list 'lsp-disabled-clients '(emacs-lisp-mode . nil))
  ;; (add-to-list 'lsp-disabled-clients '(web-mode . angular-ls))

  ;; don't scan 3rd party javascript libraries
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored)
  
  ;; manage lsp-mode popup buffers
  (add-to-list 'display-buffer-alist
               '("^\\*lsp-help\\*" (display-buffer-below-selected))))

;; [ lsp-ui ] -- UI modules for lsp-mode.

(use-package lsp-ui
  :ensure t
  :commands (lsp-ui-mode)
  :hook (lsp-mode . lsp-ui-mode)
  :custom ((lsp-ui-doc-enable nil)
           (lsp-ui-doc-header nil)
           (lsp-ui-doc-include-signature t)
           (lsp-ui-doc-position 'at-point)
           (lsp-ui-sideline-show-hover nil)
           (lsp-ui-sideline-enable nil))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions) ; [M-.]
              ([remap xref-find-references] . lsp-ui-peek-find-references)   ; [M-?]
              ("C-c C-j" . lsp-ui-imenu))
  :preface (if (featurep 'xwidget-internal) (setq lsp-ui-doc-use-webkit t)))

;;; [ lsp-treemacs ] -- LSP treemacs

(use-package lsp-treemacs
  :ensure t
  :hook (lsp-mode . lsp-treemacs-sync-mode)
  :commands (lsp-treemacs-quick-fix
             lsp-treemacs-symbols-list
             lsp-treemacs-references
             lsp-treemacs-implementations
             lsp-treemacs-call-hierarchy
             lsp-treemacs-type-hierarchy
             lsp-treemacs-deps-list))

;;; [ dap-mode ] -- Debug Adapter Protocol mode for lsp-mode.

(use-package dap-mode
  :ensure t
  :ensure posframe ; fix void `posframe-hide' in `dap-ui-controls-mode'
  :after lsp
  :commands (dap-debug)
  :bind (:map dap-mode-map
              ("<f5>" . dap-debug)
              ("<f7>" . dap-step-in)
              ("<M-f7>" . dap-step-out)
              ("<f8>" . dap-next)
              ("<f9>" . dap-continue)))

;;; [ lsp-ivy ] -- LSP Ivy integration.

(use-package lsp-ivy
  :ensure t
  :commands (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol)
  :bind (:map lsp-command-map ("g G" . lsp-ivy-workspace-symbol)))

;;; [ lsp-docker ] -- lsp-mode uses lsp-docker to run language servers using in Docker containers.

(use-package lsp-docker
  :ensure t
  :defer t)


(provide 'init-prog-lsp)

;;; init-prog-lsp.el ends here
