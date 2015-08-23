;;; init-my-emacs-navigation.el --- init Emacs Navigation.
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ ace-jump-mode -- Ace Jump Mode ]

;;; Usage:
;; "C-;" ==> ace-jump-word-mode
;;     enter first character of a word, select the highlighted key to move to it.
;; "C-'" ==> ace-jump-mode-pop-mark
;;     popup the mark to jump back.
;; "C-u C-c SPC" ==> ace-jump-char-mode
;;     enter a character for query, select the highlighted key to move to it.
;; "C-u C-u C-c SPC" ==> ace-jump-line-mode
;;     each non-empty line will be marked, select the highlighted key to move to it.

;; enable a more powerful jump back function from ace jump mode
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-'") 'ace-jump-mode-pop-mark)



;;; [ ace-isearch ] -- A seamless bridge between isearch and ace-jump-mode.

;;; ace-isearch.el provides a minor mode which combines isearch and ace-jump-mode.

;;; Usage:
;; The "default" behavior can be summrized as:

;; *Length*
;; - L = 1 : ace-jump-mode
;; - 1 < L < 6 : isearch
;; - L >= 6 : helm-swoop-from-isearch

;; where L is the input string length during isearch. When L is 1, after a few
;; seconds specified by ace-isearch-input-idle-delay, ace-jump-mode will be
;; invoked. Of course you can customize the above behaviour.

;; (require 'ace-isearch)
;;
;; (setq ace-isearch-use-ace-jump t
;;       ;; ace-isearch-input-idle-delay 0.5
;;       ;; ace-isearch-input-length 6
;;       ;; ace-isearch-function-from-isearch 'helm-swoop-from-isearch ; 'swoop-from-isearch
;;       ;; ace-isearch-use-function-from-isearch t
;;       ;; ace-isearch-set-ace-jump-after-isearch-exit t
;;       ;; ace-isearch-use-fallback-function 
;;       )
;;
;; ;; (define-key swoop-map (kbd "C-s") 'swoop-action-goto-line-next)
;; ;; (define-key swoop-map (kbd "C-r") 'swoop-action-goto-line-prev)
;;
;; ;; (ace-isearch-mode +1)
;; (global-ace-isearch-mode +1)


;; recenter

;; (setq recenter-positions '(top middle bottom)) ; default '(middle top bottom)
;;
;; (global-set-key (kbd "C-l") 'recenter-top-bottom)


(provide 'init-my-emacs-navigation)

;;; init-my-emacs-navigation.el ends here
