;;; init-prog-lang-json.el --- init for JSON
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ json-mode ] -- Extends the builtin js-mode to add better syntax highlighting for JSON.

(use-package json-mode
  :ensure t
  :defer t
  :commands (json-mode-show-path json-mode-beautify)
  :config
  (setq json-reformat:indent-width 2
        json-reformat:pretty-string? t ; decode some special characters. like \u00e4.
        ;; json-reformat:special-chars-as-pretty-string '((?\" . ?\")
        ;;                                                (?\\ . ?\\))
        )

  ;; Then add the following lines to your .emacs file, which sets a hotkey when
  ;; editing JSON files in either js or js2 mode
  (defun js-mode-bindings ()
    "Sets a hotkey for using the json-snatcher plugin"
    (when (string-match  "\\.json$" (buffer-name))
      (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
  (add-hook 'js-mode-hook 'js-mode-bindings)
  (add-hook 'js2-mode-hook 'js-mode-bindings)
  )


;;; [ json-snatcher ]

(use-package json-snatcher
  :ensure t
  :defer t)

;;; [ json-navigator ] -- view and navigate JSON structures.

(use-package json-navigator
  :ensure t
  :defer t)



(provide 'init-prog-lang-json)

;;; init-prog-lang-json.el ends here