;;; init-my-prog-project.el --- init Project settings for Emacs

;;; Commentary:


;;; Code:


(unless (boundp 'project-prefix)
  (define-prefix-command 'project-prefix))
(global-set-key (kbd "C-c p") 'project-prefix)


;;; [ projectile ] -- minor mode to assist project management and navigation.

(use-package projectile
  :ensure t
  :init
  (setq projectile-keymap-prefix (kbd "C-c p"))
  :config
  ;; Caching: nil, (* 10 60) [10 minutes],
  (setq projectile-enable-caching nil ; nil: disable caching to fix TRAMP hang
                                        ; on sending password
        ;; remote file exists cache expire to 10 minutes
        projectile-file-exists-remote-cache-expire '(* 30 60)
        )
  ;; using Projectile everywhere
  (setq projectile-require-project-root t)
  ;; Completion Options
  (setq projectile-completion-system 'ivy
        projectile-use-git-grep t ; use `vc-git-grep'
        )

  ;; test
  (setq projectile-create-missing-test-files t)

  ;; Toggle `projectile-mode'
  ;; (projectile-global-mode)
  ;; OR:
  (add-hook 'prog-mode-hook 'projectile-mode)

  (use-package counsel-projectile
    :ensure t
    :config
    (counsel-projectile-mode 1))
  )

;;; [ projectile-variable ] -- store project local variables.

(use-package projectile-variable
  :ensure t)

;;; [ project-shells ] -- manage the shell buffers for each project.

(use-package project-shells
  :ensure t
  :init
  (setq project-shells-keymap-prefix "C-x !")
  (with-eval-after-load 'project-shells
    (define-key project-shells-map (kbd "!") 'my-smart-eshell))
  :config
  ;; (project-shells-setup projectile-mode-map)

  (global-project-shells-mode 1)
  ;; (add-hook 'prog-mode-hook #'project-shells-mode)
  )


(provide 'init-my-prog-project)

;;; init-my-prog-project.el ends here
