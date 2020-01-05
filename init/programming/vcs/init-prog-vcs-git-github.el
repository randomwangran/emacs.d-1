;;; init-prog-vcs-git-github.el --- init for GitHub
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ ghub ] -- minuscule client library for the Github API.

(use-package ghub
  :ensure t
  :defer t)

;;; [ ghub+ ] -- A thick GitHub API client built on ghub.

(use-package ghub+
  :ensure t
  :defer t
  :commands (ghubp-get-notifications))

;;; [ magithub ] -- Magit interfaces for GitHub.

(use-package magithub
  :ensure t
  :after magit
  :preface (unless (boundp 'git-gutter-prefix)
             (define-prefix-command 'git-gutter-prefix))
  :bind (:map prog-vcs-prefix ("n" . magithub-dashboard)
              :map git-gutter-prefix
              ("f" . magithub-browse-file)
              ("F" . magithub-browse)
              ("M-c" . magithub-commit-browse) ; [w] on any commit section.
              ("M-b" . magithub-browse-file-blame))
  :init
  (add-to-list 'display-buffer-alist
               '("^\\*magithub-dash\\*" (display-buffer-same-window)))
  (add-to-list 'display-buffer-alist
               '("^\\*magithub:.*\\*" (display-buffer-same-window)))
  :config (magithub-feature-autoinject t))



(provide 'init-prog-vcs-git-github)

;;; init-prog-vcs-git-github.el ends here
