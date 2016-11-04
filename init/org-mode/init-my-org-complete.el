;;; init-my-org-complete.el --- init for Org Completion
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; add Org-mode's `capf' default to `pcomplete' for `company-mode'.

(defun my-org-mode-completion-setting ()
  "My basic settings for org-mode completion."
  (interactive)
  (setq-local company-minimum-prefix-length 2)
  
  (setq-local completion-at-point-functions
              '(pcomplete-completions-at-point t))

  (make-local-variable 'company-backends)
  (setq company-backends '(company-files
                           company-capf :with company-yasnippet ; NOTE: not grouped in (.. :with ..)
                           company-dabbrev-code company-abbrev
                           company-keywords
                           ;; company-ispell
                           ))
  )

(add-hook 'org-mode-hook #'my-org-mode-completion-setting)


;;; [ company-math ]

(use-package company-math
  :ensure t
  :defer t
  :init
  (add-hook 'org-mode-hook
            (lambda ()
              (make-local-variable 'company-backends)
              (add-to-list 'company-backends 'company-math-symbols-latex t)
              ;; (append company-backends 'company-math-symbols-unicode)
              ))
  )


(provide 'init-my-org-complete)

;;; init-my-org-complete.el ends here
