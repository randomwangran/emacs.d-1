;;; init-my-prog-lang-php.el --- init for PHP
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ php-mode ]

(use-package php-mode
  :ensure t
  :config
  (with-eval-after-load 'php-mode
    (require 'php-ext))
  (setq php-search-documentation-browser-function t)
  )


;;; [ php-eldoc ]

(use-package php-eldoc
  :ensure t
  :config
  (add-hook 'php-mode-hook 'php-eldoc-enable))


;;; [ inf-php ]

(use-package inf-php
  :ensure t
  :config
  )


;;; [ php-boris ]

(use-package php-boris
  :ensure t
  :config
  )


;;; [ php-boris-minor-mode ]

(use-package php-boris-minor-mode
  :ensure t
  :config
  (add-hook 'php-mode-hook 'php-boris-minor-mode)
  )


;;; [ ac-php ] -- auto-completion and company source for php for GNU Emacs.

(use-package ac-php
  :ensure t
  :config
  ;; fix ac-php duplicate parentheses with `smartparens-mode'.
  (add-to-list 'sp-ignore-modes-list 'php-mode)
  ;; or:
  ;; (add-hook 'php-mode-hook
  ;;           '(lambda ()
  ;;              (if smartparens-mode
  ;;                  (smartparens-mode -1))))
  
  (add-hook 'php-mode-hook
            (lambda ()
              ;; company-mode
              ;; (my-company-add-backend-locally 'company-ac-php-backend)

              ;; auto-complete
              ;; (setq ac-sources '(ac-source-php))
              (add-to-list 'ac-sources 'ac-source-php-template)
              (add-to-list 'ac-sources 'ac-source-php)
              
              (smartparens-mode 1)
              ))
  
  ;; keybindings
  ;; goto define & go back
  (define-key php-mode-map (kbd "M-.") 'ac-php-find-symbol-at-point)
  (define-key php-mode-map (kbd "M-,") 'ac-php-location-stack-back)
  (define-key php-mode-map (kbd "C-h d d") 'ac-php-show-tip)
  )


;;; [ phpunit ]

(use-package phpunit
  :ensure t
  :config
  (define-key php-mode-map (kbd "C-c t t") 'phpunit-current-test)
  (define-key php-mode-map (kbd "C-c t c") 'phpunit-current-class)
  (define-key php-mode-map (kbd "C-c t p") 'phpunit-current-project)
  )


;;; [ ob-php ] -- execute PHP within org-mode blocks.

(use-package ob-php
  :ensure t)


(provide 'init-my-prog-lang-php)

;;; init-my-prog-lang-php.el ends here
