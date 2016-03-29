;;; init-my-emacs-modes.el --- init Emacs modes settings
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ mmm-mode ] -- Minor mode to allow multiple major modes in one buffer.

(use-package mmm-mode
  :ensure t
  :config
  (setq mmm-global-mode 'maybe) ; t, nil, 'maybe (turn itself on in precisely).

  (setq mmm-submode-mode-line-format "~M > [~m]"
        mmm-primary-mode-display-name t
        ;; mmm-buffer-mode-display-name t
        )

  (setq mmm-submode-decoration-level 3)

  ;; (mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)

  (unless (boundp 'my-edit-prefix)
    (define-prefix-command 'my-edit-prefix))
  (define-key my-edit-prefix (kbd "m") 'mmm-mode) ; enable mmm-mode on region.
  )


;;; submode classes

;; (mmm-add-classes
;;  '((embedded-css
;;     :submode css
;;     :face mmm-declaration-submode-face
;;     :front "<style[^>]*>"
;;     :back "</style>")))


;;; submode groups

;; (mmm-add-to-group 'html-js '((js-html
;;                               :submode javascript
;;                               :face mmm-code-submode-face
;;                               :front "%=%"
;;                               :back "%=%"
;;                               :end-not-begin t)))


;;; [ mumamo-noweb ] -- multiple major modes


;;; [ polymode ] -- Object oriented framework for multiple emacs modes based on indirect buffers.

;;; Usage:
;;
;; Basic Usage
;;
;; All polymode keys start with the prefix defined by polymode-prefix-key,
;; default is [M-n]. The polymode-mode-map is the parent of all polymodes' maps:
;;
;; - `polymode-minor-mode' :: enable polymode on this buffer.
;;
;; [ prefix ]
;;
;; - [M-n] -- `polymode-prefix-key'
;;
;;  [ BACKENDS ]
;;
;;    e polymode-export
;;
;;    E polymode-set-exporter
;;
;;    w polymode-weave
;;
;;    W polymode-set-weaver
;;
;;    t polymode-tangle ;; not implemented yet
;;
;;    T polymode-set-tangler ;; not implemented yet
;;
;;    $ polymode-show-process-buffer
;;  
;;  [ NAVIGATION ]
;;  
;;  - C-n polymode-next-chunk
;;  
;;  - C-p polymode-previous-chunk
;;  
;;  - C-M-n polymode-next-chunk-same-type
;;  
;;  - C-M-p polymode-previous-chunk-same-type
;;  
;;  [ MANIPULATION ]
;;  
;;  - M-k polymode-kill-chunk
;;  
;;  - M-m polymode-mark-or-extend-chunk
;;  
;;  - C-t polymode-toggle-chunk-narrowing
;;  
;;  - M-i polymode-insert-new-chunk

;;; Activation of Polymodes
;;
;; Polymodes are functions, just like ordinary emacs modes. The can be used in
;; place of emacs major or minor modes alike. There are two main ways to
;; automatically activate emacs (poly)modes:

;; 1. By registering a file extension by adding modes to `auto-mode-alist':
;;; MARKDOWN
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . poly-markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-markdown+r-mode))

;;; 2. By setting local mode variable in you file:
;;; // -*- mode: poly-C++R -*-
;;; ## -*- mode: poly-brew+R; -*-

;;; Developing with Polymode (custom modes)
;;
;; check out polymode/modes/readme.md

;; (require 'polymode)
;;
;; ;; modes
;; (require 'poly-base)
;; (require 'poly-org)
;; (require 'poly-markdown)
;; (require 'poly-noweb)
;; (require 'poly-R)
;; (require 'poly-erb)
;; (require 'poly-slim)
;;
;;
;; (setq polymode-prefix-key '(kbd "M-n"))
;;
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . poly-markdown))


;;; [ auto-mode-alist ]

(add-to-list 'auto-mode-alist '("\\.conkyrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("conkyrc\\'" . conf-mode))

;;; Arch PKGBUILD (pkgbuild-mode)
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD\\'" . pkgbuild-mode)) auto-mode-alist))


(provide 'init-my-emacs-modes)

;;; init-my-emacs-modes.el ends here
