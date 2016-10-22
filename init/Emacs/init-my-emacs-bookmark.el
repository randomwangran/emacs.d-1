;;; init-my-emacs-bookmark.el ---
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;; [ Bookmark ] -- Emacs built-in bookmark

(require 'bookmark)

;; load bookmarks from file.
(with-eval-after-load 'bookmark
  (setq-default bookmark-default-file
                (expand-file-name "bookmarks.el" user-emacs-directory))
  (bookmark-maybe-load-default-file))

(setq bookmark-save-flag 1
      bookmark-automatically-show-annotations t)

(unless (boundp 'my-bookmark-map)
  (define-prefix-command 'my-bookmark-map))
(global-set-key (kbd "C-x r b") 'my-bookmark-map)

(global-unset-key (kbd "C-x r l"))
(global-unset-key (kbd "C-x r m"))

(define-key my-bookmark-map (kbd "b") 'bookmark-jump)
(define-key my-bookmark-map (kbd "j") 'bookmark-jump)
(define-key my-bookmark-map (kbd "l") 'bookmark-bmenu-list)
(define-key my-bookmark-map (kbd "a") 'bookmark-set)
(define-key my-bookmark-map (kbd "M") 'bookmark-set)


;;; [ bm.el ] -- Visual Bookmarks for GNU Emacs.

(use-package bm
  :ensure t
  :defer t
  :bind (("<C-f2>" . bm-toggle)
         ("<f2>" . bm-next)
         ("<S-f2>" . bm-previous))
  :init
  (setq bm-restore-repository-on-load t)
  ;; this could affect Emacs increasing running usage Persistence
  (setq bm-repository-file "~/.emacs.d/.bm-repository"
        bm-repository-size 100)
  
  ;; NOTE: `my-bookmark-map' is not void yet. it is in init-my-emacs-bookmark.el
  (unless (boundp 'my-bookmark-map)
    (define-prefix-command 'my-bookmark-map))

  (unless (boundp 'my-bookmark-bm-map)
    (define-prefix-command 'my-bookmark-bm-map))
  (define-key my-bookmark-map (kbd "m") 'my-bookmark-bm-map)

  ;; mark
  (define-key my-bookmark-bm-map (kbd "m") 'bm-toggle)
  ;; navigate
  (define-key my-bookmark-bm-map (kbd "n") 'bm-next)
  (define-key my-bookmark-bm-map (kbd "p") 'bm-previous)
  ;; show
  (define-key my-bookmark-bm-map (kbd "j") 'bm-show)
  (define-key my-bookmark-bm-map (kbd "J") 'bm-show-all)
  (define-key my-bookmark-bm-map (kbd "N") 'bm-show-next)
  (define-key my-bookmark-bm-map (kbd "P") 'bm-show-prev)
  ;; persistent
  (define-key my-bookmark-bm-map (kbd "t") 'bm-toggle-buffer-persistence)
  ;; save to repository
  (define-key my-bookmark-bm-map (kbd "s") 'bm-save) ; Save bookmarks to persistent repository.
  (define-key my-bookmark-bm-map (kbd "b") 'bm-buffer-save) ; Save all bookmarks to repository.
  (define-key my-bookmark-bm-map (kbd "B") 'bm-buffer-save-all) ; Save bookmarks in all buffers.
  ;; remove/delete
  (define-key my-bookmark-bm-map (kbd "d") 'bm-remove-all-current-buffer)
  (define-key my-bookmark-bm-map (kbd "D") 'bm-remove-all-all-buffers)

  :config
  (setq bm-in-lifo-order t)
  (setq bm-cycle-all-buffers nil)
  (setq temporary-bookmark-p nil)
  (setq bm-annotate-on-create t)
  (setq bm-highlight-style 'bm-highlight-line-and-fringe)
  (setq bm-marker 'bm-marker-left)

  ;; faces
  (set-face-attribute 'bm-face nil
                      :background "saddle brown")
  (set-face-attribute 'bm-fringe-face nil
                      :inherit 'bm-face
                      :foreground "white"
                      :weight 'normal
                      )
  (set-face-attribute 'bm-persistent-face nil
                      :background "royal blue")
  (set-face-attribute 'bm-fringe-persistent-face nil
                      :inherit 'bm-persistent-face
                      :foreground "dark red"
                      :weight 'bold
                      )
  
  ;; mouse
  (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
  (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
  (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
  (global-set-key (kbd "<left-margin> <mouse-1>") 'bm-toggle-mouse)

  ;; ;; loading the repository from file when on start up.
  ;; (add-hook 'after-init-hook 'bm-repository-load)
  ;; ;; Restoring bookmarks when on file find.
  ;; (add-hook 'find-file-hooks 'bm-buffer-restore)
  ;; ;; Saving bookmark data on killing a buffer
  ;; (add-hook 'kill-buffer-hook 'bm-buffer-save)
  ;; ;; Saving the repository to file when on exit.
  ;; ;; kill-buffer-hook is not called when Emacs is killed, so we
  ;; ;; must save all bookmarks first.
  ;; (add-hook 'kill-emacs-hook '(lambda nil
  ;;                               (bm-buffer-save-all)
  ;;                               (bm-repository-save)))
  ;; ;; Update bookmark repository when saving the file.
  ;; (add-hook 'after-save-hook 'bm-buffer-save)
  ;; ;; Restore bookmarks when buffer is reverted.
  ;; (add-hook 'after-revert-hook 'bm-buffer-restore)
  )


(provide 'init-my-emacs-bookmark)

;;; init-my-emacs-bookmark.el ends here
