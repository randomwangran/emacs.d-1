;;; init-my-emacs-spell.el --- settings
;;; Commentary:

;;; Code:


;;; [ aspell & ispell ]

;;; Usage:
;;
;; - [M-$]
;; - [M-x ispell-complete-word]

(require 'ispell)

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
      ispell-silently-savep t ; `ispell-pdict-save' save silently. stop confirm when saving personal dictionary.
      ispell-parser 'use-mode-name
      )


;;; [ Flyspell ] -- [M-$], [C-;]

(use-package flyspell
  :ensure t
  :defer t
  :init
  ;; global
  ;; (flyspell-mode 1)

  ;; programming code
  ;; flyspell-prog-mode : enable flyspell for comments in source code
  (dolist (hook
           '(prog-mode-hook
             ))
    (add-hook hook 'flyspell-prog-mode))

  ;; Org-mode
  (add-hook 'org-mode-hook
            (lambda ()
              ;; ignore TeX commands
              (setq-local ispell-parser 'tex)
              (flyspell-mode 1)
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
        )

  ;; performance
  ;; I highly suggest setting ‘flyspell-issue-message-flag’ to nil, as printing
  ;; messages for every word (when checking the entire buffer) causes an enormous
  ;; slowdown.
  (setq flyspell-issue-message-flag nil)

  (set-face-attribute 'flyspell-incorrect nil
                      :underline '(:color "red" :style wave))
  (set-face-attribute 'flyspell-duplicate nil
                      :underline '(:color "dim gray" :style wave))

  ;; conflict with `iedit-mode' toggle keybinding.
  ;; (add-hook 'flyspell-mode-hook
  ;;           (lambda ()
  ;;             (unbind-key "C-;" flyspell-mode-map)))

  ;; fix Org-mode abbreviations expand keybinding [M-Tab].
  (define-key flyspell-mode-map (kbd "C-M-i") nil)

  ;; (define-key flyspell-mode-map (kbd "C-.") 'flyspell-correct-word-before-point)
  (define-key flyspell-mode-map (kbd "C-.") 'flyspell-auto-correct-previous-word)
  (define-key flyspell-mode-map (kbd "C-,") 'flyspell-goto-next-error)
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


(provide 'init-my-emacs-spell)

;;; init-my-emacs-spell.el ends here
