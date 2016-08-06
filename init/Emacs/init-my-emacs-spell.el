;;; init-my-emacs-spell.el --- settings
;;; Commentary:

;;; Code:


;;; [ aspell & ispell ]

;;; Usage:
;;
;; - [M-$]
;; - [M-x ispell-complete-word]

(autoload 'ispell "ispell" t)

(setq ispell-look-command "/usr/sbin/look")

;; find aspell automatically
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 (t
  (setq ispell-program-name nil))
 )

(setq ispell-dictionary "english"
      ;; ispell-local-dictionary
      ispell-personal-dictionary nil ; If nil, the default (~/.ispell_LANGUAGE) will be used
      ispell-complete-word-dict "/usr/share/dict/words"
      ;; ispell-alternate-dictionary "/usr/share/dict/words"
      ispell-silently-savep t ; save silently. stop confirm when saving personal dictionary.
      ispell-parser 'use-mode-name
      )


;;; [ Flyspell ]

(use-package flyspell
  :ensure t
  :config
  (setq flyspell-default-dictionary "en"
        flyspell-delay 5
        ;; flyspell-before-incorrect-word-string "✗"
        ;; flyspell-after-incorrect-word-string "✗" ; × ✖ ✗ ✔
        flyspell-use-meta-tab nil ; use [M-TAB] to correct word.
        flyspell-consider-dash-as-word-delimiter-flag t
        flyspell-highlight-flag t
        flyspell-persistent-highlight t
        flyspell-highlight-properties t
        ;; flyspell-mode-line-string " FlySpell"
        )

  ;; performance
  ;; I highly suggest setting ‘flyspell-issue-message-flag’ to nil, as printing
  ;; messages for every word (when checking the entire buffer) causes an enormous
  ;; slowdown.
  (setq flyspell-issue-message-flag nil)

  ;; (define-key flyspell-mode-map (kbd "C-.") 'flyspell-correct-word-before-point)
  (define-key flyspell-mode-map (kbd "C-.") 'flyspell-auto-correct-previous-word)
  (define-key flyspell-mode-map (kbd "C-,") 'flyspell-goto-next-error)
  ;; conflict with iedit-mode toggle keybinding.
  (add-hook 'flyspell-mode-hook
            (lambda ()
              (unbind-key "C-;" flyspell-mode-map)))
  (define-key flyspell-mode-map (kbd "C-M-i") nil) ; fix Org-mode abbreviations expand keybinding [M-Tab].

  (unless (boundp 'my-edit-prefix)
    (define-prefix-command 'my-edit-prefix))
  (unless (boundp 'my-spell-prefix)
    (define-prefix-command 'my-spell-prefix))
  (define-key my-edit-prefix (kbd "s") 'my-spell-prefix)

  (define-key my-spell-prefix (kbd "C-s") 'flyspell-mode)
  (define-key my-spell-prefix (kbd "m") 'flyspell-mode)
  (define-key my-spell-prefix (kbd "p") 'flyspell-prog-mode)
  (define-key my-spell-prefix (kbd "b") 'flyspell-buffer)
  (define-key my-spell-prefix (kbd "r") 'flyspell-region)
  (define-key my-spell-prefix (kbd "c") 'ispell-word) ; default keybinding [M-$].

  (set-face-attribute 'flyspell-incorrect nil
                      :background "#444444" :foreground "red"
                      :underline '(:color "dark red" :style wave))
  (set-face-attribute 'flyspell-duplicate nil
                      :background "#555555" :foreground "orange"
                      :underline '(:color "dark red" :style line))

  ;; global
  ;; (flyspell-mode 1)

  ;; programming code
  ;; flyspell-prog-mode : enable flyspell for comments in source code
  ;; (dolist (hook
  ;;          '(prog-mode-hook
  ;;            ))
  ;;   (add-hook hook 'flyspell-prog-mode))

  ;; Org-mode
  (add-hook 'org-mode-hook
            (lambda ()
              (flyspell-mode 1)
              (flyspell-buffer)
              ;; ignore TeX commands
              (setq-local ispell-parser 'tex)
              ))

  ;; TeX
  (add-hook 'tex-mode-hook
            (lambda ()
              (setq ispell-parser 'tex)
              (flyspell-mode 1)
              ))

  ;; text
  (dolist (hook
           '(text-mode-hook
             markdown-mode-hook
             ))
    (add-hook hook 'flyspell-mode))
  )


;;; [ flyspell-lazy ]

(use-package flyspell-lazy
  ;; :ensure t
  ;; :config
  ;; (flyspell-mode 1)
  ;; (flyspell-lazy-mode 1)
  )


;;; [ flyspell-correct ] -- correcting words with flyspell via custom interface.

(use-package flyspell-correct
  :ensure t
  :config
  (setq flyspell-correct-interface 'flyspell-correct-popup)
  (define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-word-generic)
  )

(use-package flyspell-correct-popup
  :ensure t)

(use-package flyspell-correct-ivy
  :ensure t)


;;; [ flyguess ] -- guess language/dictionary for a buffer

(use-package flyguess
  ;; :ensure t
  ;; :config
  ;; (setq flyguess-dictionary-list '("english" "american" "francais"))
  )


;;; [ flyspell-guess ] -- flyspell dictionary guesser

(use-package flyspell-guess
  ;; :config
  ;; to load flyspell-guess every time you start Emacs. to activate the guess indicator (in minor-mode-list: "en").
  ;; (eval-after-load 'flyspell-guess
  ;;   (lambda ()
  ;;     '(flyspell-insinuate-guess-indicator)))
  )


;;; [ auto-dictionary ] -- tries to guess the buffer's text language and adjusts flyspell automatically.

(use-package auto-dictionary
  ;; :ensure t
  ;; :config
  ;; (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
  )


(provide 'init-my-emacs-spell)

;;; init-my-emacs-spell.el ends here
