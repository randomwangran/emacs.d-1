;;; init-my-org-complete.el --- init for Org Completion
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:


(if (featurep 'ivy)
    (setq org-completion-fallback-command 'ivy-read)
  ;; `completing-read', `ido', `ivy-read', `hippie-expand',
  (setq org-completion-fallback-command 'completing-read)
  )


;;; add Org-mode's `capf' default to `pcomplete' for `company-mode'.

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local completion-at-point-functions
                        '(pcomplete-completions-at-point t))

            (make-local-variable 'company-backends)
            (setq company-backends '(company-files
                                     company-capf :with company-yasnippet
                                     company-dabbrev-code company-abbrev
                                     ;; company-ispell
                                     ))
            ))


;;; [ company-math ]

(use-package company-math
  :ensure t
  :config
  (add-hook 'org-mode-hook
            (lambda ()
              (make-local-variable 'company-backends)
              (add-to-list 'company-backends 'company-math-symbols-latex t)
              ;; (append company-backends 'company-math-symbols-unicode)
              ))
  )


(provide 'init-my-org-complete)

;;; init-my-org-complete.el ends here
