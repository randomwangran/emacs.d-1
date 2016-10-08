;;; init-my-authoring.el --- init for Authoring & Writing.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ visual-fill-column ] -- wrapping visual-line-mode buffers at fill-column.

(use-package visual-fill-column
  :ensure t
  :defer t
  :bind (("C-x t v" . visual-fill-column-mode))
  :config
  (setq-default visual-fill-column-center-text nil)
  )


;;; [ org-if ] -- Interactive Fiction Authoring System for Emacs and Org-Mode.

;; (use-package org-if
;;   :ensure t
;;   :config
;;   (org-babel-do-load-languages 'org-babel-load-languages '((org-if . t)))
;;   )


(provide 'init-my-authoring)

;;; init-my-authoring.el ends here
