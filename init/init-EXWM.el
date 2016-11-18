;;; init-EXWM.el --- init for EXWM (Emacs X Windows Manager)
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:
;;; ----------------------------------------------------------------------------
;;; [ EXWM ] -- (Emacs X Windows Manager)

(when (featurep 'exwm)
  (require 'exwm)
  (require 'exwm-config)
  (exwm-config-default)
  )

;;; [ exwm-x ] -- make exwm easier for Mouse-Control-People to use.

(use-package exwm-x
  :ensure t
  :config
  ;; (require 'exwm-x-example)
  )


;;; ----------------------------------------------------------------------------

(provide 'init-EXWM)

;;; init-EXWM.el ends here
