;;; init-my-emacs-edit.el --- init Emacs editing
;;; Commentary:

;;; Code:

;;; [ undo-tree ]
;; [C-x u] -> undo-tree-visualizer-mode
;;    `- [C-p/n]  -- move up/down
;;    `- [C-b/f]  -- move left/right
;;    `- t    -- timestamp
;;    `- q    -- quit

(require 'undo-tree)

(global-undo-tree-mode t)


;;; [ Narrowing ]
;;; Usage:
;; - prefix --> [C-x n]
;; - [C-x n n] -- narrow to region
;; - [C-x n w] -- widen (undo narrow)

;;; don't disable narrowing functions
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)


;;; [ Multiple Narrowings ]


;;; [ capitalized-words-mode ]
;; (capitalized-words-mode 1)


;;; [ auto-capitalize ]

;;; Usage:
;; - auto capitalize words of an sentence.
;; - prevent a word in the `auto-capitalize-words' list from being capitalized or upcased in a particular context.
;;   e.g. ("GNU.emacs.sources"), insert the following whitepsace or punctuation character with:
;;   `M-x quoted insert' (e.g. `gnu C-q .').

;; (autoload 'auto-capitalize "auto-capitalize" "Autoload function `auto-capitalize'." t)
;; (autoload 'auto-capitalize-mode "auto-capitalize" "Toggle `auto-capitalize' minor mode in the buffer." t)
;; (autoload 'turn-on-auto-capitalize-mode "auto-capitalize" "Turn on `auto-capitalize' minor mode in the buffer." t)
;; (autoload 'enable-auto-capitalize-mode "auto-capitalize" "Enable `auto-capitalize' minor mode in the buffer." t)

;; (setq auto-capitalize-yank nil
;;       auto-capitalize-words '("\\<Emacs\\>" "\\<Linux\\>"
;;                               "\\<Android\>>" "\\<iOS\\>" "\\<Mac\\>")
;;       ;; TODO auto-capitalize-predicate
;;       )

;;; To turn on (unconditional) capitalization in all Text modes.
;; (turn-on-auto-capitalize-mode)
;;; To enable (interactive) capitalization in all Text modes.
;; (enable-auto-capitalize-mode)

;; (dolist (hook '(text-mode-hook
;;                 org-mode-hook
;;                 markdown-mode-hook
;;                 ;; latex-mode-hook
;;                 ))
;;   (add-hook hook (lambda ()
;;                    (turn-on-auto-capitalize-mode))))


;;; [ Iedit ] -- Edit multiple regions simultaneously in a buffer or a region
;;;
;;; This package includes Emacs minor modes (iedit-mode and
;;; iedit-rectangle-mode) based on a API library (iedit-lib) and allows you to
;;; edit one occurrence of some text in a buffer (possibly narrowed) or region,
;;; and simultaneously have other occurrences edited in the same way, with
;;; visual feedback as you type.
;;
;; Normal scenario of Iedit mode is like:
;;
;; - Highlight certain contents - by press C-; All occurrences of a symbol, string or a rectangle in the buffer or a region may be highlighted corresponding to current mark, point and prefix argument. Refer to the document of `iedit-mode’ for details.
;;
;; - Edit one of the occurrences The change is applied to other occurrences simultaneously.
;; - Finish - by pressing C-; again
;
;; You can also use Iedit mode as a quick way to temporarily show only the
;; buffer lines that match the current text being edited. This gives you the
;; effect of a temporary `keep-lines’ or `occur’. To get this effect, hit C-’
;; when in Iedit mode - it toggles hiding non-matching lines.
;;
;; Renaming refactoring is convinient in Iedit mode
;; - The symbol under point is selected as occurrence by default and only complete symbols are matched
;; - With digit prefix argument 0, only occurrences in current function are matched
;; - Restricting symbols in current region can be done by pressing C-; again
;; - Last renaming refactoring is remembered and can be applied to other buffers later
;; - Restricting the search area to just the current line can be done by pressing M-I.
;; - Restricting the search area to the lines near the current line can be done by pressing M-{ and M-}. These will expand the search region one line at a time from the top and bottom. Add a prefix argument to go the opposite direction.

;;; Iedit-rectangle-mode provides rectangle support with visible rectangle
;;; highlighting, which is similar with cua mode rectangle support. But it’s
;;; lighter weight and uses iedit mechanisms.

;;; There are also some other facilities you may never think about. Refer to the
;;; document of function `iedit-mode’ (C-h f iedit-mode RET) for more details.

;;; Usage:
;; - [C-h iedit-mode RET] -- to get help of iedit-mode
;; - [M-x iedit-mode]
;;
;; - [C-;] -- highlight certain contents
;; - [C-'] -- toggle unmatched lines visible
;; - [M-;] -- apply global modification
;;
;; - [Tab] -- next occurrence
;; - [S-Tab] -- prev occurrence
;; - [M-<] -- first occurrence
;; - [M->] -- last  occurrence
;;
;; - [M-b] -- toggle buffering
;; - [M-c] -- toggle case sensitive
;;
;; - [M-d] -- restrict function
;;
;; - [M-d] -- delete occurrences
;; - [M-SPC] -- blank occurences
;; - [M-l] -- downcase occurrences
;; - [M-u] -- upcase occurrences
;; - [M-n] -- number occurrences
;; - [M-r] -- replace occurrences
;;
;; --------------------------------
;;
;; - [M-x iedit-rectangle-mode] -- visible rectangle.
;; - [M-k] -- Iedit kill rectangle.
;; Steps:
;; - mark a rectangle like Emacs rectangle with [C-@ / C-SPC].
;; - after marked the rectangle, then press [C-c C-;] to enable iedit rectangle mode, and highlight the rectangle.

;; (require 'iedit)

;; (autoload 'iedit-mode "Iedit" "Edit multiple regions with the same content simultaneously." t)
;; (autoload 'iedit-rectangle-mode "Iedit rectangle" "Edit narrowed text." t)

;; ;; (setq iedit-occurrence-face 'isearch)

;; (defun iedit-dwim (arg)
;;   "If ARG, start iedit but use \\[narrow-to-defun] to limit its scope."
;;   (interactive "P")
;;   (if arg
;;       (iedit-mode)
;;     (save-excursion
;;       (save-restriction
;;         (widen)
;;         ;; this function determines the scope of `iedit-start'.
;;         (if iedit-mode
;;             (iedit-done)
;;           ;; `current-word' can of course be replaced by other
;;           ;; functions.
;;           (narrow-to-defun)
;;           (iedit-start (current-word) (point-min) (point-max)))))))



;;; [ multiple-cursors ]

;;; Usage:
;;; https://github.com/magnars/multiple-cursors.el
;;; - [C-c c] -- prefix of mc.
;;; - [C-c c c] / [C-S-c C-S-c] -- edit-lines

(require 'multiple-cursors)

;; TODO 'mc/mark-all-dwim

;; When you have an active region that spans multiple lines, the following will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer, use:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-pop)

;; First mark the word, then add more cursors.

;; To get out of multiple-cursors-mode, press <return> or C-g. The latter will
;; first disable multiple regions before disabling multiple cursors. If you want
;; to insert a newline in multiple-cursors-mode, use [C-j].

;; (set-face-attribute 'mc/cursor nil
;;                     :foreground "cyan")




(provide 'init-my-emacs-edit)

;;; init-my-emacs-edit.el ends here
