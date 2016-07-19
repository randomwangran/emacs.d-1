;;; init-my-org-view.el --- init for Org View
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; [ default view ]

(setq org-startup-folded t
      org-startup-indented t
      org-startup-truncated t
      ;; org-startup-with-beamer-mode nil
      ;; org-hide-block-startup t
      org-hide-leading-stars t
      org-indent-mode-turns-on-hiding-stars t
      org-indent-indentation-per-level 1
      org-hide-emphasis-markers t
      )

(setq org-fontify-emphasized-text t
      org-fontify-quote-and-verse-blocks t
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      )

;; include ' in org-verbatim face highlight.
(setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n,\"")
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)

;; [ pretty entities ]

;; \pi will display as π
;; [C-c C-x \]
(setq org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t)

(setq org-script-display
      '(((raise -0.3)
         (height 0.7)
         (:foreground "yellow"))
        ((raise 0.3)
         (height 0.7)
         (:foreground "yellow"))
        ((raise -0.5))
        ((raise 0.5))
        )
      )

;; [ indent ]

(use-package org-indent
  :config
  (set-face-attribute 'org-indent nil
                      )
  )

;; [ org-bullets ]

(require 'org-bullets nil t)

(setq-default org-bullets-bullet-list
              ;; '("◉")
              ;; '("✩" "✡" "✪" "☯" "✜" "◌" "◉" "⍟" "❀" "✿" "☢")
              '("Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ" "Ⅺ" "Ⅻ")
              ;; '("❶" "❷" "❸" "❹" "❺" "❻" "❼" "❽" "❾" "❿")
              ;; '("①" "②" "③" "④" "⑤" "⑥" "⑦" "⑧" "⑨" "⑩")
              ;; '("㊀" "㊁" "㊂" "㊃" "㊄" "㊅" "㊆" "㊇" "㊈" "㊉")
              )

(defface org-bullets-face
  '((t (:inherit nil
                 :foreground "olive drab"
                 ;; :box '(:color "dark slate gray" :line-width 2)
                 )))
  "My custom face for org-bullets."
  :group 'org-faces)
(setq org-bullets-face-name 'org-bullets-face)

(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode 1)
            (set-face-attribute 'org-bullets-face nil
                                :weight 'bold :height 150
                                :foreground "cyan"
                                ;; :box '(:color "dark slate gray" :line-width -1)
                                )
            ))


;;; better list bullets

;; Asterisks and dashes for bullet lists are fine, but having an actual circular
;; bullet, is just nice:

;; match "- list item"
(font-lock-add-keywords
 'org-mode
 '(("^\\([-+]\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; match " - list item"
(font-lock-add-keywords
 'org-mode
 '(("^ +\\([-+]\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


;;; [ org-beautify-theme ] -- A sub-theme to make org-mode more beautiful.

;; (require 'org-beautify-theme)


;;; eldoc-mode support

;; (add-hook 'org-mode-hook #'eldoc-mode)


;;; [ wc-mode ]

(use-package wc-mode
  :ensure t
  :config
  (add-hook 'org-mode-hook 'wc-mode)
  )


(provide 'init-my-org-view)

;;; init-my-org-view.el ends here
