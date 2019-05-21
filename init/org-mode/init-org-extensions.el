;;; init-org-extensions.el --- init for Org Extensions
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-crypt ] -- public key encryption for Org entries

(require 'org-crypt)

;; You can change the tag to any complex tag matching string by
;; setting the `org-crypt-tag-matcher' variable.
(add-to-list 'org-default-properties "CRYPTKEY")

;;; add `org-crypt' required tag to default persistent tag list.
(add-to-list 'org-tag-persistent-alist '("crypt" . ?b))

;;; set your public keyring.
(setq org-crypt-key "F09F650D7D674819892591401B5DF1C95AE89AC3")

;;; To automatically encrypt all necessary entries when saving a file.
(org-crypt-use-before-save-magic)

;;; set keybindings for org-crypt functions.
(define-key org-mode-map (kbd "C-c C-r") 'org-encrypt-entry)
(define-key org-mode-map (kbd "C-c M-r") 'org-decrypt-entry)



(provide 'init-org-extensions)

;;; init-org-extensions.el ends here
