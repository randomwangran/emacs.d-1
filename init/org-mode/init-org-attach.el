;;; init-org-attach.el --- init for Org attach
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-attach ] -- Manage file attachments to org-mode tasks.

(require 'org-attach)

(setq org-attach-archive-delete 'query)

(setq org-attach-store-link-p 'attached) ; add link to `org-store-link'.

;; auto commit when Org file is in git repository.
(setq org-attach-commit t)

;;; don't auto add tag "ATTACH"
(setq org-attach-auto-tag nil)

;;; specify default directory for `org-attach'.
(defun my/org-attach-set-default-directory (orig-fun &rest args)
  "Change dir of the shell to buffer's `default-directory'."
  (let ((default-directory (expand-file-name "~/Downloads/")))
    (apply orig-fun args)))
(advice-add #'org-attach :around #'my/org-attach-set-default-directory)

;;; [ org-screenshot ] -- Take and manage screenshots in Org-mode files.

(use-package org-plus-contrib
  :load-path "~/Code/Emacs/org-mode/contrib/lisp/"
  :no-require t
  :pin manual
  :ensure-system-package scrot
  :load (org-screenshot)
  :commands (org-screenshot-take)
  :init (add-hook 'org-mode-hook
                  #'(lambda () (local-set-key (kbd "C-c o M-s") 'org-screenshot-take)))
  :config (setq org-screenshot-image-directory "data/images"))

;;; [ org-attach-screenshot ] -- screenshots integrated with org attachment dirs.

;; (use-package org-attach-screenshot
;;   :ensure t
;;   :commands (org-attach-screenshot)
;;   :bind (:map Org-prefix ("M-s" . org-attach-screenshot))
;;   :init
;;   (setq org-attach-screenshot-command-line "import %f") ; "scrot -c -d 5 -s %f"
;;   :config (setq org-attach-screenshot-relative-links t))

;;; [ org-download ] -- drag and drop images to Emacs org-mode.

(use-package org-download
  :ensure t
  :ensure-system-package wget
  :init
  (unless (boundp 'org-download-prefix)
    (define-prefix-command 'org-download-prefix))
  (define-key Org-prefix (kbd "d") 'org-download-prefix)

  (define-key org-download-prefix (kbd "i") 'org-download-image)
  (define-key org-download-prefix (kbd "s") 'org-download-screenshot)
  (define-key org-download-prefix (kbd "y") 'org-download-yank)
  (define-key org-download-prefix (kbd "d") 'org-download-delete)
  (define-key org-download-prefix (kbd "e") 'org-download-edit)

  (define-key org-mode-map (kbd "<drag-n-drop>") 'org-download-dnd)
  (define-key org-mode-map (kbd "<C-drag-n-drop>") 'org-download-dnd)
  (define-key org-mode-map (kbd "<M-drag-n-drop>") 'org-download-dnd)
  :config
  (setq org-download-screenshot-method "scrot -s %s"
        org-download-method 'attach ; 'attach, 'directory,
        ;; if you don't want the #+DOWNLOADED: annotation in your Org document
        org-download-annotate-function (lambda (_) "")
        org-download-backend t ; url-retrieve (t), wget, curl.
        ;; org-download-heading-lvl
        ;; org-download-timestamp "_%Y-%m-%d_%H:%M:%S"
        org-download-image-dir "data/images" ; nil: default to "."
        ;; org-download-image-width nil ; use #+attr_html: :width
        ;; org-download-img-regex-list '("<img +src=\"" "<img +\\(class=\"[^\"]+\"\\)? *src=\"")
        )

  (org-download-enable)
  )

;;; [ org-web-tools ] -- retrieving web page content and processing it into Org-mode content.

(use-package org-web-tools
  :ensure t
  :commands (org-web-tools-insert-link-for-url ; insert Org link
             org-web-tools-insert-web-page-as-entry ; insert web page as Org entry
             org-web-tools-read-url-as-org ; display web page as Org in new buffer
             org-web-tools-convert-links-to-page-entries ; convert all links in current Org entry to Org headings
             ))

;;; [ org-board ] -- Org mode's web archiver.

(use-package org-board
  :ensure t
  :ensure-system-package wget
  :defer t
  :bind (:map Org-prefix ("C-a" . org-board-keymap))
  :config
  (add-to-list 'display-buffer-alist
               '("org-board-wget-call" (display-buffer-below-selected)))
  )


(provide 'init-org-attach)

;;; init-org-attach.el ends here
