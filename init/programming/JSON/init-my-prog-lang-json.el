;;; init-my-prog-lang-json.el --- init for JSON
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ json-mode ] -- Extends the builtin js-mode to add better syntax highlighting for JSON.

(require 'json-mode)


;;; [ json-reformat ] -- Reformat tool for JSON

;;; Usage:
;; - [M-x json-reformat-region]

(require 'json-reformat)


;;; [ json-snatcher ] --

;; Say you're looking through a large JSON file, and see a value that you want
;; to extract programmatically. This Emacs extension will allow you to snatch
;; the path to this value.

(require 'json-snatcher)

;; Then add the following lines to your .emacs file, which sets a hotkey when
;; editing JSON files in either js or js2 mode

(defun js-mode-bindings ()
  "Sets a hotkey for using the json-snatcher plugin"
  (when (string-match  "\\.json$" (buffer-name))
    (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
(add-hook 'js-mode-hook 'js-mode-bindings)
(add-hook 'js2-mode-hook 'js-mode-bindings)



(provide 'init-my-prog-lang-json)

;;; init-my-prog-lang-json.el ends here
