;;; init-my-prog-lang-haskell.el --- init Haskell for Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ haskell-mode ]

(use-package haskell-mode
  :ensure t
  :config
  (setq haskell-stylish-on-save nil)
  (setq haskell-font-lock-symbols t)
  
  (add-hook 'haskell-mode-hook
            '(lambda ()
               ;; indent
               (turn-on-haskell-indent) ; `intelligent' Haskell indentation mode
               ;; (turn-on-haskell-indentation) ; haskell-indentation minor mode
               ;; disable `aggressive-indent-mode' in `haskell-mode'.
               (aggressive-indent-mode -1)
               ;; doc
               (turn-on-haskell-doc-mode)
               ))

  
  ;; [ Haskell Interactive Mode ]
  (require 'haskell-interactive-mode)
  (require 'haskell-process)
  
  (setq haskell-process-suggest-remove-import-lines t
        haskell-process-suggest-hoogle-imports t
        haskell-process-auto-import-loaded-modules t
        haskell-process-log t
        haskell-interactive-mode-eval-mode 'haskell-mode
        haskell-tags-on-save t)

  (add-hook 'haskell-mode-hook
            '(lambda ()
               ;; inferior-haskell-mode (deprecated)
               ;; (inf-haskell-mode 1)
               ;; Haskell Interactive Mode
               (interactive-haskell-mode 1)
               ))
  
  (define-key my-prog-inferior-map (kbd "h") 'haskell-interactive-switch)

  (define-key haskell-mode-map (kbd "C-c C-s") 'haskell-interactive-bring)
  (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c M-c") 'haskell-process-cabal)
  ;; (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
  
  ;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
  ;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)
  ;; To use GHCi first and then if that fails to fallback to tags for jumping
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)

  (defun haskell-interactive-toggle-print-mode ()
    (interactive)
    (setq haskell-interactive-mode-eval-mode
          (intern
           (completing-read "Eval result mode: "
                            '("fundamental-mode"
                              "haskell-mode"
                              "espresso-mode"
                              "ghc-core-mode"
                              "org-mode")))))
  
  (define-key haskell-interactive-mode-map (kbd "C-c C-v") 'haskell-interactive-toggle-print-mode)

  ;; Doc (Haddocks)
  (require 'w3m-haddock)
  ;; make haddock pages a little more palatable (and add syntax highlighting to source view)
  (add-hook 'w3m-display-hook 'w3m-haddock-display)
  (setq haskell-w3m-haddock-dirs '("~/.cabal/share/doc/"))
  (define-key haskell-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
  
  ;; auto start `inf-haskell'
  (defun my-haskell-interactive-start ()
    (interactive)
    (unless (not (get-buffer "*haskell*"))
      (haskell-interactive-bring)
      (bury-buffer)))

  (add-hook 'haskell-mode-hook 'my-haskell-interactive-start)
  )


;;; [ flycheck-haskell ]

(use-package flycheck-haskell
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
  )


;;; [ ghc ]

(use-package ghc
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'ghc-init)

  ;; if you wish to display error each goto next/prev error,
  (setq ghc-display-error 'minibuffer)
  )


;;; [ ghci-completion ] -- completion for GHCi commands in inferior-haskell buffers.

(use-package ghci-completion
  :ensure t)


;;; [ company-ghc ] -- company-mode back-end for haskell-mode via ghc-mod.

(use-package company-ghc
  :ensure t
  :config
  (setq company-ghc-show-info t
        company-ghc-show-module t
        )
  ;; (add-to-list 'company-backends 'company-ghc)
  )


;;; [ company-ghci ] -- company backend which uses the current ghci process.

(use-package company-ghci
  :ensure t
  :config
  ;; (add-to-list 'company-backends 'company-ghci)
  )


;;; [ company-cabal ] -- company-mode back-end for haskell-cabal-mode.

;; (use-package company-cabal
;;   :ensure t
;;   :config
;;   ;; (add-to-list 'company-backends 'company-cabal)
;;   )



(dolist (hook '(haskell-mode-hook
                haskell-interactive-mode-hook
                ;; inferior-haskell-mode-hook (deprecated)
                ))
  (add-hook hook
            '(lambda ()
               (my-company-add-backends-to-mode
                '(company-ghc
                  company-ghci
                  ;; company-cabal
                  ))
               )))


;;; [ ebal ] -- Emacs interface to Cabal and Stack.

(use-package ebal
  :ensure t)


(provide 'init-my-prog-lang-haskell)

;;; init-my-prog-lang-haskell.el ends here
