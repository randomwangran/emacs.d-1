;;; init-my-emacs-settings.el --- init my Emacs settings

;;; Commentary:

;;; Code:

;;; [ Disabled Commands ]
;; To enable all disabled commands in one fell swoop, put this in .emacs (not recommended for newbies):
;; TODO uncomment this when you are very familiar with Emacs.
;; (setq disabled-command-function nil)


(fset 'yes-or-no-p 'y-or-n-p) ; treat 'y' as yes, 'n' as no.

(setq inhibit-startup-message t) ; no splash screen


;;; [ Time ]
(setq system-time-locale "C") ; make timestamps in org-mode appear in English.
;;; time-stamp
;; (add-hook 'before-save-hook 'time-stamp)
;; (setq time-stamp-pattern nil)


;; [ Bell ]
(setq visible-bell t)


;;; [ User Information ]
(setq user-full-name "stardiviner")
(setq user-mail-address "numbchild@gmail.com")
;; (setq user-login-name "chris")


;;; [ mode ]
(setq default-major-mode 'org-mode) ; use org-mode for any unspecified mode.


;;; [ session ]

;;; [ auto save ]
;; (auto-save-mode t)
(setq auto-save-default t               ; create #autosave# files
      auto-save-list-file-prefix "~/.emacs.d/auto-save-list/.saves-"
      auto-save-interval 200)

;; places
(require 'saveplace)
(setq save-place t                      ; save point place
      save-place-file "~/.emacs.d/.emacs-places")





(provide 'init-my-emacs-settings)

;;; init-my-emacs-settings.el ends here
