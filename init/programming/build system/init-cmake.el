;;; init-cmake.el --- init for CMake
;;; -*- coding: utf-8 -*-

;;; Commentary:

;;; http://www.itk.org/Wiki/CMake/Editors/Emacs

;;; Code:

;;; [ cmake-mode ]

(use-package cmake-mode
  :ensure t
  :defer t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode))
  :init (use-package cmake-font-lock :ensure t))

;;; [ eldoc-cmake ] -- Eldoc support for CMake.

(use-package eldoc-cmake
  :ensure t
  :hook (cmake-mode . eldoc-cmake-enable))

;;; [ cmake-ide ]

(use-package cmake-ide
  :ensure t
  :defer t
  :init (cmake-ide-setup))

;;; [ cmake-project ] -- Integrates CMake build process with Emacs.

(use-package cmake-project
  :ensure t
  :defer t)


(provide 'init-cmake)

;;; init-cmake.el ends here
