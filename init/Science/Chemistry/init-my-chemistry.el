;;; init-my-chemistry.el --- init for Chemistry.

;;; Commentary:



;;; Code:

;;; Chemistry: SMILES
(use-package smiles-mode
  :ensure t
  :ensure-system-package (babel . "sudo pacman -S --noconfirm openbabel")
  :config
  (use-package ob-smiles
    :ensure t
    :config
    (add-to-list 'org-babel-load-languages '(smiles . t))
    (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
    ;; FIXME: (add-to-list 'org-babel-tangle-lang-exts '("smiles" . "??"))
    )
  )



(provide 'init-my-chemistry)

;;; init-my-chemistry.el ends here
