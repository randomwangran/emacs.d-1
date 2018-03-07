;;; init-emacs-help.el --- init Emacs's help settings.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


(add-to-list 'display-buffer-alist
             '("^\\*Help\\*$" (display-buffer-reuse-window display-buffer-below-selected)))
(add-to-list 'display-buffer-alist
             '("^\\*Apropos\\*$" (display-buffer-reuse-window display-buffer-below-selected)))

;;; [ Info ]

(use-package info
  :bind ("C-h i" . info-display-manual)
  :init
  ;; - `Info-default-directory-list'
  (add-to-list 'Info-directory-list
               (expand-file-name "info/" user-emacs-directory))
  (add-to-list 'display-buffer-alist
               '("\\*info\\*" . (display-buffer-reuse-window display-buffer-below-selected)))
  ;; let `[s]' search like =isearch= for incremental search.
  (setq Info-isearch-search t)
  ;; - `Info-mode-hook'
  )

;;; [ info-colors ] -- A modern adaption of the extra coloring provided by info+ package.

(use-package info-colors
  :ensure t
  :defer t
  :init
  (add-hook 'Info-selection-hook 'info-colors-fontify-node))


(provide 'init-emacs-help)

;;; init-emacs-help.el ends here