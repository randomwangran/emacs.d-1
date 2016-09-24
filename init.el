;;; init.el --- --- user init file  -*- no-byte-compile: t -*-

;;; Commentary:


;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;;; [ profiler ]

;; (profiler-start 'cpu+mem)


;;; [ things before load ]

;; Turn off mouse interface early in startup to avoid momentary display
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please... jeez
(setq inhibit-startup-screen t)

(setq confirm-kill-emacs 'yes-or-no-p)

(toggle-frame-maximized)



(require 'server)
(unless (server-running-p)
  (server-start))


;;; add my init files directory

(let ((default-directory "~/.emacs.d/init/"))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ; shadow
           (append
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")

(setq load-prefer-newer t)


;;; [ package manager ]

(load "~/.emacs.d/init/init-my-pm-package.el")
(require 'init-my-pm-package)

(require 'color)
(use-package color-theme
  :ensure t)


;;; debug, profiling etc

(require 'init-my-emacs-debug)
(require 'init-my-emacs-benchmark)


;;; my custom functions

(use-package dash
  :ensure t
  :config
  (eval-after-load "dash" '(dash-enable-font-lock))
  )

(require 'init-my-library)
(require 'init-my-functions)


;;; Emacs
(require 'init-my-emacs-environment)
(require 'init-my-emacs-settings)
(require 'init-my-emacs-performance)
(require 'init-my-emacs-font)
(require 'init-my-emacs-color-theme)
(require 'init-my-emacs-appearance)
(require 'init-my-emacs-prettify)
(require 'init-my-emacs-mode-line)
(require 'init-my-emacs-popup)
(require 'init-my-emacs-completion)
(require 'init-my-emacs-notify)
(require 'init-my-emacs-help)
(require 'init-my-emacs-minibuffer)
(require 'init-my-emacs-buffer)
(require 'init-my-emacs-window)
(require 'init-my-emacs-frame)
(require 'init-my-emacs-session)
(require 'init-my-emacs-idle)
(require 'init-my-emacs-edit)
(require 'init-my-emacs-navigation)
(require 'init-my-emacs-bookmark)
(require 'init-my-emacs-keybinding)
(require 'init-my-emacs-indent)
(require 'init-my-emacs-outline)
(require 'init-my-emacs-input-method)
(require 'init-my-emacs-spell)
(require 'init-my-emacs-file)
(require 'init-my-emacs-tramp)
(require 'init-my-emacs-color)
(require 'init-my-emacs-image)
(require 'init-my-emacs-pdf)
(require 'init-my-emacs-ebook)
(require 'init-my-emacs-dired)
(require 'init-my-emacs-modes)
(require 'init-my-emacs-abbrev)
(require 'init-my-emacs-search)
(require 'init-my-emacs-highlight)
(require 'init-my-emacs-regexp)
(require 'init-my-emacs-vcs)
(require 'init-my-emacs-shell)
(require 'init-my-emacs-comint)
(require 'init-my-emacs-subprocess)
(require 'init-my-emacs-network)
(require 'init-my-emacs-encrypt)
(require 'init-my-emacs-xwidget)
(require 'init-my-emacs-customize)


;;; Vim

;; (require 'init-my-vim)


;;; Languages

(unless (boundp 'my-search-language-prefix)
  (define-prefix-command 'my-search-language-prefix))
(define-key my-search-prefix (kbd "l") 'my-search-language-prefix)

(require 'init-my-language-english)
;; (require 'init-my-language-chinese)
;; (require 'init-my-language-japanese)


;;; Tools
(unless (boundp 'my-tools-prefix)
  (define-prefix-command 'my-tools-prefix))
(global-set-key (kbd "C-x t") 'my-tools-prefix)

(require 'init-my-org-mode)
(require 'init-my-tool-calendar)
(require 'init-my-tool-dictionary)
(require 'init-my-tool-clock)
(require 'init-my-tool-speak)
(require 'init-my-tool-calculator)
(require 'init-my-tool-keyboard)
(require 'init-my-tool-tmux)
(require 'init-my-tool-hex)
(require 'init-my-tool-file)
(require 'init-my-tool-diagram)
(require 'init-my-tool-ascii)
;; (require 'init-my-tool-bbdb)
(require 'init-my-tool-network)
(require 'init-my-tool-browser)
(require 'init-my-tool-downloader)
(require 'init-my-tool-OpenSpritz)
(require 'init-my-tool-email)
;; (require 'init-my-tool-feeds)
(require 'init-my-tool-blog)
(require 'init-my-tool-paste)
(require 'init-my-tool-notify)
;; (require 'init-my-tool-irc-erc)
(require 'init-my-tool-music)
;; (require 'init-my-tool-subtitle)
(require 'init-my-tool-screenshot)
(require 'init-my-tool-screencast)
;; (require 'init-my-tool-stack-exchange)


;;; Programming
(require 'init-my-prog-programming)
(require 'init-my-prog-license)
(require 'init-my-prog-code)
(require 'init-my-prog-comment)
(require 'init-my-prog-electric)
(require 'init-my-prog-indent)
(require 'init-my-prog-folding)
(require 'init-my-prog-complete)
(require 'init-my-prog-sense)
(require 'init-my-prog-tags)
(require 'init-my-prog-snippet)
(require 'init-my-prog-template)
(require 'init-my-prog-sidebar)
(require 'init-my-prog-document)
;; (require 'init-my-prog-inferior)
(require 'init-my-prog-eval)
(require 'init-my-prog-compile)
(require 'init-my-prog-make)
(require 'init-my-prog-lint)
(require 'init-my-prog-debug)
(require 'init-my-prog-test)
(require 'init-my-prog-refactor)
(require 'init-my-prog-project)
(require 'init-my-prog-vcs)
;; (require 'init-my-prog-bug-track-system)


;;; Programming Languages
(require 'init-my-prog-lang-lisp)
(require 'init-my-prog-lang-emacs-lisp)
(require 'init-my-prog-lang-common-lisp)
;; (require 'init-my-prog-lang-lisp-scheme)
;; (require 'init-my-prog-lang-newLisp)
;; (require 'init-my-prog-lang-shen)
(require 'init-my-prog-lang-clojure)
(require 'init-my-prog-lang-ruby)
(require 'init-my-prog-lang-python)
;; (require 'init-my-prog-lang-perl)
(require 'init-my-prog-lang-shell)
(require 'init-my-prog-lang-C-common)
(require 'init-my-prog-lang-C++)
(require 'init-my-prog-lang-D)
(require 'init-my-prog-lang-go)
;; (require 'init-my-prog-lang-rust)
;; (require 'init-my-prog-lang-nim)
(require 'init-my-prog-lang-lua)
(require 'init-my-prog-lang-swift)
(require 'init-my-prog-lang-java)
;; (require 'init-my-prog-lang-jvm-groovy)
;; (require 'init-my-prog-lang-jvm-kotlin)
(require 'init-my-prog-lang-php)
(require 'init-my-prog-lang-html)
(require 'init-my-prog-lang-css)
(require 'init-my-prog-lang-javascript)
;; (require 'init-my-prog-lang-coffeescript)
;; (require 'init-my-prog-lang-sibilant)
;; (require 'init-my-prog-lang-dart)
(require 'init-my-prog-lang-database)
(require 'init-my-prog-lang-xml)
(require 'init-my-prog-lang-json)
(require 'init-my-prog-lang-haskell)
;; (require 'init-my-prog-lang-scala)
;; (require 'init-my-prog-lang-elixir)
;; (require 'init-my-prog-lang-erlang)
(require 'init-my-prog-lang-ESS)
(require 'init-my-prog-lang-julia)
(require 'init-my-prog-lang-R)
(require 'init-my-prog-lang-gnuplot)
;; (require 'init-my-prog-lang-octave)
;; (require 'init-my-prog-lang-matlab)
(require 'init-my-prog-lang-tex)
(require 'init-my-prog-lang-markdown)
(require 'init-my-prog-lang-reStructuredText)
(require 'init-my-prog-lang-yaml)
(require 'init-my-prog-lang-prolog)
;; (require 'init-my-prog-lang-ocaml)
(require 'init-my-prog-lang-verilog)
(require 'init-my-prog-lang-assembly)
(require 'init-my-prog-lang-forth)
(require 'init-my-prog-lang-HDL)

;; (require 'init-my-prog-lang-applescript)


;;; Frameworks
(require 'init-my-prog-framework-web)
(require 'init-my-prog-framework-http)
(require 'init-my-prog-web-browser)
(require 'init-my-prog-framework-ruby-on-rails)
(require 'init-my-prog-framework-android)
(require 'init-my-prog-framework-arduino)
(require 'init-my-prog-framework-qt)


;;; Programming Tools

(require 'init-my-prog-tools)


;;; Systems

(require 'init-linux)
(require 'init-mac)
(require 'init-microsoft-windows)


;;; Electronic

(require 'init-my-electronic)


;;; Electric Music

(require 'init-my-electric-music)


;;; Accessibility

(require 'init-my-emacs-accessibility)


;;; Math
(require 'init-my-math)


;;; Authoring & Writing
(require 'init-my-authoring)


;;; Games
(require 'init-my-games)


;;; at the end!!!

(require 'init-my-startup)



;;; init.el ends here
