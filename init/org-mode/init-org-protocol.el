;;; init-org-protocol.el --- init for Org Protocol
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ org-protocol ] -- intercept calls from emacsclient to trigger custom actions.

(use-package org-protocol
  :config
  (with-eval-after-load 'org-protocol
    (unless (featurep 'server)
      (require 'server))
    (unless (server-running-p)
      (server-start)))

  ;; [ org-protocol capture ]
  (setq org-capture-templates
        (append `(("p" ,(format "%s\torg-protocol"
                                (all-the-icons-faicon "external-link" :face 'all-the-icons-orange)))
                  ("pp" ,(format "%s\tProtocol"
                                 (all-the-icons-faicon "chrome" :face 'all-the-icons-orange))
                   entry (file ,(concat org-directory "/Tasks/Tasks.org"))
                   "* %^{Title}\nSource: %u, %c\n#+begin_quote\n%i\n#+end_quote\n\n\n%?"
                   :prepend t
                   :empty-lines 1)
                  ("pl" ,(format "%s\tProtocol Link"
                                 (all-the-icons-faicon "external-link" :face 'all-the-icons-orange))
                   entry (file ,(concat org-directory "/Tasks/Tasks.org"))
                   "* %? [[%:link][%:description]] \nCaptured On: %U"
                   :prepend t
                   :empty-lines 1))
                org-capture-templates))

  
  ;; ;; TODO: setup this option.
  ;; ;; (module-name :property value property: value ...)
  ;; (setq org-protocol-project-alist
  ;;       '(("http://orgmode.org/worg/"
  ;;          :online-suffix ".php"
  ;;          :working-suffix ".org"
  ;;          :base-url "http://orgmode.org/worg/"
  ;;          :working-directory "/home/stardiviner/Org/Worg/")
  ;;         ("http://localhost/org-notes/"
  ;;          :online-suffix ".html"
  ;;          :working-suffix ".org"
  ;;          :base-url "http://localhost/org/"
  ;;          :working-directory "/home/user/org/"
  ;;          :rewrites (("org/?$" . "index.php")))))
  )

(use-package org-protocol-capture-html
  :ensure t
  :config (setq org-capture-templates
                (append
                 `(("ph" ,(format "%s\torg-protocol-capture-html"
                                  (all-the-icons-faicon "html5" :face 'all-the-icons-pink))
                    entry (file "")
                    "* %a :website:\n\n%U %?\n\n%:initial"))
                 org-capture-templates)))


(provide 'init-org-protocol)

;;; init-org-protocol.el ends here
