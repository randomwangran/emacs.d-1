;;; init-dired.el --- init Dired for Emacs
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ Dired ] (Directory editing mode)

(use-package dired
  :defer t
  :bind (("C-x d" . dired)
         :map dired-mode-map
         ("j" . dired-next-line)
         ("k" . dired-previous-line)
         ("g" . dired-do-redisplay)
         ("F" . find-name-dired)
         )
  :init
  ;; auto refresh dired when file changes
  (setq dired-auto-revert-buffer t)
  (add-hook 'dired-mode-hook #'turn-on-auto-revert-mode)
  :config
  (setq dired-create-destination-dirs 'ask)

  ;; Another thing that did annoy me was the fact that when I traverse the
  ;; directory hierarchy, I leave a trail of open Dired buffers with all the
  ;; directories I go through. This is also easy to change: just enable the
  ;; `dired-find-alternate-file' function (bound to a in Dired) and use it to
  ;; visit a file or directory in place (IOW, open it instead of the current Dired
  ;; buffer – this also works for files I want to visit!).
  ;;
  (put 'dired-find-alternate-file 'disabled nil) ; key [a] in Dired.

  ;; allow dired to be able to delete or copy a whole dir.
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'top) ; 'top means ask once

  ;; Dired tries to guess a default target directory.
  ;; This means: if there is a Dired buffer displayed in the next window, use its
  ;; current directory, instead of this Dired buffer's current directory.
  (setq dired-dwim-target t)

  ;; reuse the current dired buffer to visit a directory.
  (use-package dired-single
    :ensure t
    :init
    (defun my:dired-single-enable ()
      (define-key dired-mode-map [return] 'dired-single-buffer)
      (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
      (define-key dired-mode-map "^"
        (function (lambda nil (interactive) (dired-single-buffer "..")))))
    (add-hook 'dired-mode-hook #'my:dired-single-enable))
  
  (use-package dired-toggle-sudo
    :ensure t
    :bind (:map dired-mode-map ("#" . dired-toggle-sudo)))
  
  ;; allow rsync from dired buffers especially for large files.
  (use-package dired-rsync
    :ensure t
    :commands (dired-rsync))

  ;; open file with `eww'.
  (define-key dired-mode-map (kbd "e")
    (lambda ()
      (interactive)
      (eww-open-file (dired-get-file-for-visit))))

  ;; [image-dired ] -- image in Dired
  (use-package image-dired+
    :ensure t
    :after image-dired
    :init
    (eval-after-load 'image-dired+ '(image-diredx-async-mode 1))
    (eval-after-load 'image-dired+ '(image-diredx-adjust-mode 1))
    :config
    (define-key image-dired-thumbnail-mode-map (kbd "C-n") 'image-diredx-next-line)
    (define-key image-dired-thumbnail-mode-map (kbd "C-p") 'image-diredx-previous-line)
    (define-key image-dired-thumbnail-mode-map (kbd "g") 'revert-buffer)
    (define-key image-dired-thumbnail-mode-map (kbd "x") 'image-diredx-flagged-delete)
    (setq image-dired-track-movement nil) ; suppress unknown cursor movements.
    ;; TODO: not work.
    (define-key image-dired-minor-mode-map (kbd "C-t D") 'image-dired-show-all-from-dir)
    (define-key image-dired-minor-mode-map (kbd "C-t s") 'image-dired-slideshow-start)
    (define-key image-dired-thumbnail-mode-map "g" 'revert-buffer)
    (add-to-list 'display-buffer-alist
                 '("^\\*image-dired\\*" (display-buffer-same-window)))
    (add-to-list 'display-buffer-alist
                 '("^\\*image-dired-display-image\\*" (display-buffer-same-window)))
    )

  ;; rename files editing their names in dired buffers.
  (use-package wdired
    :ensure t
    :bind (:map dired-mode-map ("C-c C-p" . wdired-change-to-wdired-mode))
    :config (setq wdired-allow-to-change-permissions t))

  (use-package dired-x ; extra Dired functionality
    :preface
    ;; don't bind [C-x C-j] from `dired-x'. (conflict with `ace-window')
    (setq dired-bind-jump nil)
    :config
    ;; ignore specific files
    ;; toggle `dired-omit-mode' to hide hidden files with [C-x M-o]
    ;; (add-hook 'dired-mode-hook #'dired-omit-mode)
    (setq dired-omit-files
          (concat dired-omit-files
                  "\\|^.DS_STORE$\\|^.projectile$"
                  "\\(?:.*\\.\\(?:aux\\|log\\|synctex\\.gz\\|run\\.xml\\|bcf\\|am\\|in\\)\\'\\)\\|^\\.\\|-blx\\.bib"))
    )

  ;; use `all-the-icons' icons to display for files.
  (use-package all-the-icons-dired
    :ensure t
    :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

  ;; Edit Filename At Point in an Emacs' dired buffer
  (use-package dired-efap
    :ensure t
    :bind (:map dired-mode-map
                ([f2] . dired-efap)
                ([down-mouse-1] . dired-efap-click))
    :config
    (setq dired-efap-use-mouse t)
    ;; (setq dired-efap-initial-filename-selection 'no-extension)
    )

  ;; `dired-do-*' commands
  (require 'dired-aux)

  (use-package dired-narrow
    :ensure t
    :bind (:map dired-mode-map ("/" . dired-narrow)))
  
  ;; A convienent way to look up file contents in other window while browsing
  ;; directory in Dired.
  (use-package peep-dired
    :ensure t
    :bind (:map dired-mode-map ("P" . peep-dired))
    :config
    (setq peep-dired-cleanup-on-disable t
          peep-dired-cleanup-eagerly t
          peep-dired-enable-on-directories t
          peep-dired-ignored-extensions '("mkv" "iso" "mp4")))

  ;; launch an external application with command `mimeopen' from dired.
  (use-package dired-launch
    :ensure t
    :bind (:map dired-launch-mode-map
                ("J" . nil)
                ("K" . nil)
                ("C-c l" . dired-launch-command)
                ("C-c L" . dired-launch-with-prompt-command))
    :init (dired-launch-enable))
  
  ;; [ make-it-so ] -- Transform files with Makefile recipes.
  (use-package make-it-so
    :ensure t
    :config
    (mis-config-default)
    (setq mis-recipes-directory
          (concat user-emacs-directory "init/extensions/make-it-so-recipes/")))
  )


(provide 'init-dired)

;;; init-dired.el ends here
