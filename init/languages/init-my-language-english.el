;;; init-my-language-english.el --- init for English Language.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ capitalized-words-mode ]

;; (capitalized-words-mode 1)


;;; [ auto-capitalize ]

;; (use-package auto-capitalize
;;   :ensure t
;;   :defer t
;;   :init
;;   (autoload 'auto-capitalize "auto-capitalize"
;;     "Autoload function `auto-capitalize'." t)
;;   (autoload 'auto-capitalize-mode "auto-capitalize"
;;     "Toggle `auto-capitalize' minor mode in the buffer." t)
;;   (autoload 'turn-on-auto-capitalize-mode "auto-capitalize"
;;     "Turn on `auto-capitalize' minor mode in the buffer." t)
;;   (autoload 'enable-auto-capitalize-mode "auto-capitalize"
;;     "Enable `auto-capitalize' minor mode in the buffer." t)
;;   :config
;;   (setq auto-capitalize-yank nil
;;         auto-capitalize-words '("\\<Emacs\\>" "\\<Linux\\>"
;;                                 "\\<Android\>>" "\\<iOS\\>" "\\<Mac\\>")
;;         ;; auto-capitalize-predicate
;;         )
;;
;;   ;; To turn on (unconditional) capitalization in all Text modes.
;;   ;; (turn-on-auto-capitalize-mode)
;;   ;; To enable (interactive) capitalization in all Text modes.
;;   ;; (enable-auto-capitalize-mode)
;;   ;; enable in specific modes.
;;   (dolist (hook '(text-mode-hook
;;                   org-mode-hook
;;                   markdown-mode-hook
;;                   ;; latex-mode-hook
;;                   ))
;;     (add-hook hook (lambda ()
;;                      (turn-on-auto-capitalize-mode))))
;;   )


;;; [ Super Smart Capitalization ]

;; Languages are fleeting. But Emacs is forever.
;; =>
;; Languages are fleeting, but Emacs is forever.



;;; [ electric punctuation ]


(provide 'init-my-language-english)

;;; init-my-language-english.el ends here
