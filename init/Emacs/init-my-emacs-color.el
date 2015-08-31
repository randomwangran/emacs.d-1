;;; init-my-emacs-color.el --- init for Color Manippulation
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ rainbow-mode ] -- colorize color names in buffers

(dolist (hook
         '(emacs-lisp-mode-hook
           css-mode-hook
           html-mode-hook))
  (add-hook hook (lambda () (rainbow-mode 1))))


;;; [ kurecolor ] -- color editing goodies for Emacs.


(provide 'init-my-emacs-color)

;;; init-my-emacs-color.el ends here
