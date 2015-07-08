;;; init-my-prog-make-cmake.el --- init for CMake
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ cmake-mode ]

;; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "cmake-mode.el" t)


;;; [ cmake-font-lock ]

(autoload 'cmake-font-lock-activate "cmake-font-lock.el" t)

;; TODO: This seems not work.
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)


(provide 'init-my-prog-make-cmake)

;;; init-my-prog-make-cmake.el ends here
