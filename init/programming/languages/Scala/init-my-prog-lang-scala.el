;;; init-my-prog-lang-scala.el --- init for Scala
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ scala-mode ]

(use-package scala-mode
  :ensure t
  :config
  ;; let the awesome Smartparens take care of parentheses in Scala buffers.
  (remove-hook 'post-self-insert-hook
               'scala-indent:indent-on-parentheses)

  (sp-local-pair 'scala-mode "(" nil
                 :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'scala-mode "{" nil
                 :post-handlers '(("||\n[i]" "RET") ("| " "SPC")))
  )


;;; [ sbt-mode ]

(use-package sbt-mode
  :ensure t
  :commands sbt-start sbt-command
  :bind (:map scala-mode-map
              ("C-c C-s" . run-scala))
  )


;;; [ ENSIME ]

(use-package ensime
  :ensure t
  :init
  (add-hook 'scala-mode-hook 'ensime-mode)
  :config
  (setq ensime-completion-style 'company
        ensime-graphical-tooltips t
        ensime-auto-generate-config t)
  )


(provide 'init-my-prog-lang-scala)

;;; init-my-prog-lang-scala.el ends here
