;;; init-my-prog-document-wikipedia.el --- init for Offline Wikipedia
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ mediawiki ] -- mediawiki frontend.

(use-package mediawiki
  :ensure t
  :defer t)


;;; [ ox-mediawiki ] -- Mediawiki Back-End for Org Export Engine.

;; Open a .org document and run `org-mw-export-as-mediawiki'.

(use-package ox-mediawiki
  :ensure t
  :defer t)


;;; [ kiwix ] -- Kiwix client for Emacs.

(use-package kiwix
  :ensure t
  :bind (:map my-prog-help-document-map
              ("w" . kiwix-at-point)
              ("W" . kiwix-at-point-interactive)
              ("M-w" . kiwix-launch-server)
              )
  )


(provide 'init-my-prog-document-wikipedia)

;;; init-my-prog-document-wikipedia.el ends here
