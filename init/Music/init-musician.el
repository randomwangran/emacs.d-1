;;; init-musician.el --- init for Musician.

;;; Commentary:



;;; Code:

;;; [ LilyPond ]

(use-package lilypond-mode
  :preface
  (autoload 'LilyPond-mode "lilypond-mode" "LilyPond Editing Mode" t)
  :mode (("\\.ly$" . LilyPond-mode)
         ("\\.ily$" . LilyPond-mode))
  :init (add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))
  (add-to-list 'display-buffer-alist
               '("\\*lilypond\\*" . (display-buffer-reuse-window display-buffer-below-selected)))
  )

;;; [ ob-lilypond ]

(require 'ob-lilypond)
(add-to-list 'org-babel-load-languages '(lilypond . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

;;; [ gregorio-mode ] -- Gregorio Mode for .gabc files.

(use-package gregorio-mode
  :ensure t
  :defer t)



(provide 'init-musician)

;;; init-musician.el ends here
