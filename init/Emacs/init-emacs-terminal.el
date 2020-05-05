;;; init-emacs-terminal.el --- init for TERMs -*- lexical-binding: t; -*-

;;; Time-stamp: <2020-05-05 15:33:58 stardiviner>

;;; Commentary:



;;; Code:

;;; [ term ] -- general command interpreter in a window stuff.

(use-package term
  :commands (term))

;;; [ vterm ] -- This package implements a terminal via libvterm.

(use-package vterm
  :ensure t
  :defer t
  :commands (vterm))

;;; [ multi-vterm ] -- Like multi-term.el but for vterm

(use-package multi-vterm
  :ensure t
  :defer t
  :commands (multi-vterm multi-vterm-next multi-vterm-prev multi-vterm-dedicated-toggle multi-vterm-projectile)
  :config
  (define-key vterm-mode-map [return] #'vterm-send-return))



(provide 'init-emacs-terminal)

;;; init-emacs-terminal.el ends here
