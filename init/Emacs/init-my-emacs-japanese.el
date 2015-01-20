;;; init-my-emacs-japanese.el --- init for Japanese support
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ migemo ] -- provides Japanese increment search with 'Romanization of Japanese'(ローマ字).

;;; Usage:
;;
;; -


(require 'migemo)
(autoload 'migemo "migemo" "" t)

(setq migemo-command "cmigemo"
      migemo-options '("-q" "--emacs")
      ;; Set your installed path
      ;; migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict"
      ;; migemo-user-dictionary nil
      ;; migemo-regex-dictionary nil
      migemo-coding-system 'utf-8-unix
      )

(migemo-init)


;;; [ helm-migemo ] --

;; (define-key global-map [(control ?:)] 'helm-migemo)


;;; [ oniisama ]

;; (require 'oniisama)


(provide 'init-my-emacs-japanese)

;;; init-my-emacs-japanese.el ends here
