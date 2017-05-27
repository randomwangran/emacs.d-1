;;; init-bibliography.el --- init for bibliography
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:
;;; ----------------------------------------------------------------------------

;; (setq reftex-default-bibliography
;;       (quote
;;        ("default.bib" "other-default.bib")))


;;; [ bibtex ] -- BibTeX mode for GNU Emacs.

(use-package bibtex
  :config
  (setq bibtex-parse-keys-fast t
        bibtex-parse-keys-timeout 0
        )
  (use-package bibtex-style
    :ensure t)
  (use-package bibtex-utils
    :ensure t)
  )

;;; ----------------------------------------------------------------------------
;;; [ helm-bibtex ] -- Helm interface for bibliography manager.

(use-package helm-bibtex
  :ensure t
  :defer t)

;;; [ ivy-bibtex ] -- A BibTeX bibliography manager based on Ivy.

(use-package ivy-bibtex
  :ensure t
  :defer t)

;;; [ company-bibtex ] -- Emacs company-mode completion back-end for Bibtex keys.

(use-package company-bibtex
  :ensure t
  :config
  (setq company-bibtex-bibliography
        '("~/.emacs.d/bibliography/bibliography.bib"
          ))

  (add-to-list 'company-backends 'company-bibtex t)
  )

;;; [ ebib ] -- a BibTeX database manager.

;; (use-package ebib
;;   :ensure t
;;   :config
;;   (use-package ebib-handy
;;     :ensure t)
;;   )

;;; [ bibretrieve ] -- Retrieving BibTeX entries from the web.

;; (use-package bibretrieve
;;   :ensure t)

;;; ----------------------------------------------------------------------------

(provide 'init-bibliography)

;;; init-bibliography.el ends here
