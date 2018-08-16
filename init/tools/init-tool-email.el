;;; init-tool-email.el --- init for Email
;;; -*- coding: utf-8 -*-

;;; Commentary:

;;; - [C-x m] :: `compose-mail'

;;; Code:


(unless (boundp 'email-prefix)
  (define-prefix-command 'email-prefix))
(define-key tools-prefix (kbd "m") 'email-prefix)

;;; [ mail-mode ] -- mail-mode is replaced with message-mode.


;;; [ message-mode ]

;; 'message-user-agent, 'mail-user-agent, 'gnus-user-agent, 'mu4e-user-agent,
(setq mail-user-agent 'message-user-agent
      ;; compose-mail-user-agent-warnings nil
      ;; use `postfix' server instead of `smtpmail'.
      send-mail-function 'sendmail-send-it
      message-send-mail-function 'message-send-mail-with-sendmail
      ;; message-send-mail-real-function 'message-send-mail-with-sendmail
      )

(defun message-mode-setup ()
  ;; add email name complete support
  (add-hook 'completion-at-point-functions
            'mail-completion-at-point-function nil t)
  (add-hook 'completion-at-point-functions
            'message-completion-function nil t)

  (footnote-mode 1)
  )

(add-hook 'message-mode-hook #'message-mode-setup)

;;; cite region in message-mode.
(defun message-cite-region (beg end &optional levels)
  "Cite region in message-mode."
  (interactive "*r\np")
  (goto-char beg)
  (beginning-of-line)
  (let*((first-line (line-number-at-pos))
        (last-line  (line-number-at-pos end))
        (num-lines  (1+ (- last-line first-line))) )
    (dotimes (unused num-lines)
      (while (looking-at ">") (delete-char 1)) ; TODO: away hard-code
      (when  (looking-at " ") (delete-char 1))
      (when (> levels 0)
        (insert-char ?> levels)
        (insert-char ?\ ) ) ; this repairs ugly >quotes as well
      (forward-line 1) )
    ;; clean up
    (goto-char (point-min))
    (forward-line (1- last-line))
    (end-of-line)
    (when (region-active-p) (keyboard-quit))))

(define-key message-mode-map (kbd "M-;") 'message-cite-region)

;;; [ encrypt email ]

;;; - [C-c C-m C-e] :: (mml-secure-message-sign-encrypt)
;;;    This will add a tag at the beginning of the mail.
;;;    <#secure method=pgpmime mode=signencrypt>
;;;    the `mode=signencrypt' means:
;;;      - `sign'
;;;      - `encrypt'


;; (require 'init-gnus)
(require 'init-mu4e)


;; procmail
(add-to-list 'auto-mode-alist '("\\.procmailrc\\'" . conf-mode))
;; getmail
(add-to-list 'auto-mode-alist '("\\.getmailrc\\'" . conf-mode))
;;; [ Thunderbird ]
;; use org mode for eml files (useful for thunderbird plugin like "external editor").
(add-to-list 'auto-mode-alist '("\\.eml\\'" . org-mode))



(provide 'init-tool-email)

;;; init-tool-email.el ends here
