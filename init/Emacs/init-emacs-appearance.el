;;; init-emacs-appearance.el --- my Emacs apperance init

;;; Commentary:


;;; Code:


(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;; [ Transparent ]

(defun my:set-transparency-alpha (alpha)
  "Loop through transparency `ALPHA' settings."
  (interactive (list
                (completing-read "Transparency Alpha: "
                                 '("100" "90" "80" "70" "60"))))
  (let* ((active-alpha (string-to-number alpha))
         (inactive-alpha (- active-alpha 20)))
    (set-frame-parameter (selected-frame) 'alpha (list active-alpha inactive-alpha))
    (add-to-list 'default-frame-alist (cons 'alpha (list active-alpha inactive-alpha)))
    ))

(my:set-transparency-alpha "95")

;;; [ Title ]

(setq frame-title-format "Emacs λ Hacking")

;; (setq frame-title-format "Emacs λ %b")

;; (setq frame-title-format
;;       '("" invocation-name ": "
;;         (:eval
;;          (if (buffer-file-name)
;;              (abbreviate-file-name (buffer-file-name))
;;            "%b"))))

;;; [ border & margin ]

(setq-default left-margin-width 0
              right-margin-width 0)
;; frame internal border width
(set-frame-parameter nil 'internal-border-width 5)
;; (set-window-buffer nil (current-buffer))

;;; [ fringe ]

;; (setq fringe-indicator-alist
;;       '((truncation left-arrow right-arrow)
;;         (continuation left-curly-arrow right-curly-arrow)
;;         (overlay-arrow . right-triangle)
;;         (up . up-arrow)
;;         (down . down-arrow)
;;         (top top-left-angle top-right-angle)
;;         (bottom bottom-left-angle bottom-right-angle top-right-angle top-left-angle)
;;         (top-bottom left-bracket right-bracket top-right-angle top-left-angle)
;;         (empty-line . empty-line)
;;         (unknown . question-mark)))

(setq-default indicate-buffer-boundaries 'left
              indicate-empty-lines t
              indicate-unused-lines nil)


;; both side fringe 10 pixels wide.
;; (fringe-mode 10)
;; make left fringe 10 pixels wide, and right fringe disappear.
;; (fringe-mode '(10 . 0))
;; or
;; (set-fringe-style '(10 . 0))
;; restore the default size
;; (fringe-mode nil)


;;; [ echo area ]


;;; [ Widget ]

;;; [ line ]

;;; [ line space(spacing) / line height ]
;; - (info "(elisp) Line Height")
;; - (info "(elisp) Layout Parameters")
;; The total height of each display line consists of the height of the
;; contents of the line, plus optional additional vertical line spacing
;; above or below the display line.

;; additional space to put between lines.
(setq-default line-spacing 0.1)         ; 0.1, 1, 0, nil.

;;; [ line numbers ]

;;; Emacs native line number mode.
;; (global-display-line-numbers-mode -1)

;;; [ current line & column ]

;; highlight current line
(global-hl-line-mode 1)

;;; [ point & cursor ]

(setq-default mouse-avoidance-mode 'animate ; auto move mouse away when cursor is at mouse position
              cursor-in-echo-area nil
              mouse-yank-at-point t
              blink-cursor-blinks 10
              )

;;; horizontal bar
(setq-default cursor-type t ; '(hbar . 2)
              cursor-in-non-selected-windows nil)
;; (set-cursor-color "cyan")
(set-cursor-color "deep pink")

;;; hollow
;; (setq-default cursor-type 'hollow
;;               cursor-in-non-selected-windows nil)
;; (set-cursor-color "green")

;;; adaptive cursor width
;; make cursor the width of the character it is under
;; i.e. full width of a TAB
(setq x-stretch-cursor t)

(blink-cursor-mode 1)

;;; [ Selection ]

(setq transient-mark-mode t)


;;; [ wrap & fill ]
(setq-default fill-column 80)
(setq-default truncate-lines t) ; truncate long lines.
(setq-default truncate-partial-width-windows 50)
(setq-default global-visual-line-mode nil) ; soft wrap lines at word boundary
(setq-default visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

;;; [ auto-fill-mode ] -- auto fill paragraphs like hitting [M-q].

;;; global
;; (auto-fill-mode t)
;;; auto fill comments but not code in programming modes:
(add-hook 'prog-mode-hook
          '(lambda () (setq-local comment-auto-fill-only-comments t)))
;;; enable only for text writing modes.
(toggle-text-mode-auto-fill)
(dolist (hook '(text-mode-hook
                org-mode-hook
                markdown-mode-hook))
  (add-hook hook 'turn-on-auto-fill))

;;; [ fci ] -- Fill Column Indicator

;; (with-eval-after-load 'fill-column-indicator
;;   (setq fci-rule-width 10)
;;   (setq fci-rule-character ?❚)
;;   ;; (setq fci-rule-character-color "#999999")
;;   (setq fci-dash-pattern 1.00)
;;   (global-visual-fill-column-mode))


;;; [ page (^L) ]

;; - <C-x [/]> :: navigate.
;; "^\014",
;; (setq page-delimiter
;;       (rx bol ";;;" (not (any "#")) (* not-newline) "\n"
;;           (* (* blank) (opt ";" (* not-newline)) "\n")))
;; Expanded regexp:
;; "^;;;[^#].*\n\\(?:[[:blank:]]*\\(?:;.*\\)?\n\\)*"
;;
;; The regexp above is a bit special. We’re setting the page delimiter to be a
;; ;;; at the start of a line, plus any number of empty lines or comment lines
;; that follow it (that # part is to exclude ;;;###autoload cookies).


;;; Disable GUI dialog boxes

(setq use-dialog-box nil) ; use mini-buffer for everything' else..


;;; trailing whitespace

(require 'whitespace)
(setq whitespace-line-column 80) ; limit line length
(setq whitespace-style '(face lines-tail))
;; (add-hook 'prog-mode-hook 'whitespace-mode)
;; (global-whitespace-mode +1)


;;; [ beacon ] -- highlight the cursor whenever the window scrolls.

(use-package beacon
  :ensure t
  :defer t
  :init
  (beacon-mode 1)
  :config
  (setq beacon-blink-when-point-moves-vertically 10
        beacon-blink-when-point-moves-horizontally 20
        beacon-blink-when-focused t
        beacon-blink-duration 0.2
        beacon-blink-delay 0.2
        beacon-size 30
        beacon-color 0.5)
  )

;;; [ all-the-icons ] -- A utility package to collect various Icon Fonts and propertize them within Emacs.

(use-package all-the-icons
  :ensure t
  :defer t
  :config
  (add-to-list 'all-the-icons-mode-icon-alist
               '(erc-mode all-the-icons-faicon "commenting-o" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(ag-mode all-the-icons-faicon "search" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(sh-mode all-the-icons-alltheicon "terminal" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(sql-interactive-mode all-the-icons-faicon "database" 1.0 :v-adjust 0.05))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(arduino-mode all-the-icons-fileicon "arduino" 1.0 :v-adjust 0.00))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(sly-mrepl-mode all-the-icons-fileicon "lisp" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(slime-repl-mode all-the-icons-fileicon "lisp" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(inferior-python-mode all-the-icons-alltheicon "python" :height 1.0 :v-adjust 0.0))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(package-menu-mode all-the-icons-octicon "package" :height 1.0 :v-adjust 0.0))
  )



(provide 'init-emacs-appearance)

;;; init-emacs-appearance.el ends here
