;;; init-my-prog-lang-haskell.el --- init Haskell for Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ haskell-mode ]

(use-package haskell-mode
  :ensure t
  :config
  (setq haskell-font-lock-symbols t
        haskell-stylish-on-save nil
        haskell-tags-on-save nil
        )
  
  ;; [ Haskell Interactive Mode ]
  (require 'haskell-interactive-mode)
  (require 'haskell-process)
  
  ;; (setq haskell-process-type 'auto ; 'cabal-repl
  ;;       ;; haskell-process-args-cabal-repl '("--ghc-option=-ferror-spans"
  ;;       ;;                                   "--with-ghc=ghci-ng"
  ;;       ;;                                   )
  ;;       haskell-process-suggest-remove-import-lines t
  ;;       haskell-process-suggest-haskell-docs-imports t
  ;;       haskell-process-suggest-hoogle-imports t
  ;;       haskell-process-auto-import-loaded-modules t
  ;;       haskell-process-log t
  ;;       haskell-process-use-presentation-mode t
  ;;       haskell-interactive-mode-eval-mode 'haskell-mode
  ;;       haskell-complete-module-preferred '("Data.ByteString"
  ;;                                           "Data.ByteString.Lazy"
  ;;                                           "Data.Conduit"
  ;;                                           "Data.Function"
  ;;                                           "Data.List"
  ;;                                           "Data.Map"
  ;;                                           "Data.Maybe"
  ;;                                           "Data.Monoid"
  ;;                                           "Data.Ord")
  ;;       )

  
  (defun my-haskell-mode-basic-settings ()
    "Some basic settings for `haskell-mode'."
    (interactive)
    ;; indent
    (haskell-indent-mode 1) ; `intelligent' Haskell indentation mode
    (aggressive-indent-mode -1)
    ;; doc
    (haskell-doc-mode 1)
    )
  
  (add-hook 'haskell-mode-hook #'my-haskell-mode-basic-settings)

  (define-key my-prog-inferior-map (kbd "h") 'haskell-interactive-switch)

  (define-key haskell-mode-map (kbd "C-c C-s") 'haskell-interactive-bring)
  (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c M-c") 'haskell-process-cabal)
  
  ;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
  ;; (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)
  ;; To use GHCi first and then if that fails to fallback to tags for jumping
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)

  ;; [ module ]
  ;; (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

  ;; Doc (Haddocks)
  (require 'w3m-haddock)
  ;; make haddock pages a little more palatable (and add syntax highlighting to source view)
  (add-hook 'w3m-display-hook 'w3m-haddock-display)
  (setq haskell-w3m-haddock-dirs '("~/.cabal/share/doc/"))
  (define-key haskell-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)

  ;; API search (use Hayoo)
  (define-key haskell-mode-map (kbd "C-h d d") 'haskell-hayoo)
  
  ;; auto start `inf-haskell'
  (defun my-haskell-interactive-start ()
    (interactive)
    (unless (get-buffer "*haskell*")
      (haskell-interactive-bring)
      (bury-buffer)))

  (add-hook 'haskell-mode-hook 'my-haskell-interactive-start)
  )


;;; [ hindent ] -- Haskell indent.

(use-package hindent
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode)
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
  ;; (setq ghc-debug t)
  (add-hook 'haskell-mode-hook #'ghc-init)

  ;; if you wish to display error each goto next/prev error,
  (setq ghc-display-error 'minibuffer)
  )


;;; [ company-ghc ] -- company-mode back-end for haskell-mode via ghc-mod.

(use-package company-ghc
  :ensure t
  :config
  (setq company-ghc-show-info t
        company-ghc-show-module t
        )
  )


;;; [ company-ghci ] -- company backend which uses the current ghci process.

(use-package company-ghci
  :ensure t)


;;; [ company-cabal ] -- company-mode back-end for haskell-cabal-mode.

;; (use-package company-cabal
;;   :ensure t
;;   )



(defun my-haskell-company-backends-setup ()
  "Setup `company-backends' for Haskell related modes."
  (interactive)
  (add-to-list (make-local-variable 'company-backends)
               '(company-ghc
                 :with
                 company-yasnippet
                 company-ghci
                 ;; company-cabal
                 ))
  )

(dolist (hook '(haskell-mode-hook
                haskell-interactive-mode-hook
                interactive-haskell-mode-hook
                ;; inferior-haskell-mode-hook (deprecated)
                ))
  (add-hook hook #'my-haskell-company-backends-setup))


;;; [ intero ] -- Complete interactive development program for Haskell.

(use-package intero

;;; [ scion ] -- IDE library for Haskell based on the GHC API.

(use-package scion
  :ensure t
  :config
  ;; (setq scion-program "~/.cabal/bin/scion-server")
  ;; (setq scion-completing-read-function 'ido-completing-read)
  
  (add-hook 'haskell-mode-hook
            (lambda ()
              (scion-mode 1)
              (scion-flycheck-on-save 1)))
  
  (add-hook 'scion-connected-hook
            (lambda ()
              (notifications-notify :title "Haskell Scion connected"
                                    :body "Haskell Scion connected.")))
  )


;;; [ ebal ] -- Emacs interface to Cabal and Stack.

(use-package ebal
  :ensure t)


(provide 'init-my-prog-lang-haskell)

;;; init-my-prog-lang-haskell.el ends here
