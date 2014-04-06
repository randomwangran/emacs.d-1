;;; init-my-prog-lang-ruby.el --- my Ruby init

;;; Commentary:


;;; Code:


;;; custom functions

;;; FIXME: key binding always override by flyspell-auto-correct-word.
(defun insert-arrow ()
  "Insert => for Ruby old school style hash."
  (interactive)
  (delete-horizontal-space t)
  (insert " => "))



;;; [ ruby-mode ]

;; - [C-M-n] -- end of block
;; - [C-M-p] -- beginning of block
;; - [C-M-q] -- (prog-indent-sexp)
;;
;; - [C-c C-r] -- (ruby-send-region)
;; - [C-c C-b] -- (ruby-send-block)
;; - [C-c C-x] -- (ruby-send-definition)
;; - [C-c C-l] -- (ruby-load-file)
;; - [C-x C-e] -- (ruby-send-last-sexp)
;; - [C-c C-s] -- (inf-ruby)
;; - [C-c C-z] -- (ruby-switch-to-inf)

(require 'ruby-mode)

;; (add-auto-mode 'ruby-mode
;;                "Gemfile\\'" "\\.gemspec\\'"
;;                "Rakefile\\'" "\\.rake\\'"
;;                "\\.erb\\'"
;;                "Kirkfile\\'" "Capfile\\'" "Guardfile\\'" "Vagrantfile\\'"
;;                "\\.rxml\\'" "\\.rjs\\'"
;;                "\\.builder\\'" "\\.jbuilder\\'"
;;                "\\.ru\\'" "\\.rabl\\'" "\\.thor\\'"
;;                "\\.irbrc\\'" "\\.pryrc\\'"
;;                )

;; Stupidly the non-bundled ruby-mode isn't a derived mode of
;; prog-mode: we run the latter's hooks anyway in that case.
(add-hook 'ruby-mode-hook
          (lambda ()
            (unless (derived-mode-p 'prog-mode)
              (run-hooks 'prog-mode-hook))

            ;; TODO: modify those colors.
            ;; Words prefixed with $ are global variables,
            ;; prefixed with @ are instance variables.
            (modify-syntax-entry ?$ "w") ; global variable
            (modify-syntax-entry ?@ "w") ; instance variable
            ;; FIXME: (modify-syntax-entry ?@@ "w") ; class variable
            (modify-syntax-entry ?? "w")
            (modify-syntax-entry ?! "w")
            (modify-syntax-entry ?: ".")

            (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
            ;; (define-key ruby-mode-map (kbd "TAB") 'indent-for-tab-command)

            (define-key ruby-mode-map (kbd "C-.") 'insert-arrow)

            ;; hs-minor-mode
            (add-to-list 'hs-special-modes-alist
                         '(ruby-mode
                           "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
                           (lambda (arg) (ruby-end-of-block)) nil))

            (electric-indent-local-mode 1)
            (setq ruby-deep-indent-paren '(?\( ?\[ ?\] t)
                  ruby-deep-indent-paren-style 'space)
            ))




;;; enh-ruby-mode

;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
;; ;; (setq enh-ruby-program "(path-to-ruby1.9.3)/bin/ruby")

;; (require 'enh-ruby-mode)



;; We never want to edit Rubinius bytecode or MacRuby binaries
(add-to-list 'completion-ignored-extensions ".rbc")
(add-to-list 'completion-ignored-extensions ".rbo")

;; TODO: whether need this?
;; Font lock for new hash style
;; (font-lock-add-keywords
;;  'ruby-mode
;;  '(("\\(\\b\\sw[_a-zA-Z0-9]*:\\)\\(?:\\s-\\|$\\)" (1 font-lock-constant-face))))



;;; ruby-hash-syntax

;; (require 'ruby-hash-syntax)


;;; [ ruby-block ]

(require 'ruby-block)

(setq ruby-block-delay 0)
(setq ruby-block-highlight-toggle t)
(ruby-block-mode t)


;;; [ ruby-end ]



;;; [ ruby-electric ]

(require 'ruby-electric)

(add-hook 'ruby-mode-hook
          (lambda ()
            (autopair-mode -1) ; conflict with ruby-electric.
            ))


;;; yard-mode -- for Ruby YARD comments

;; (require 'yard-mode)

;; (add-hook 'ruby-mode-hook 'yard-mode)


;;; [ yari ] -- Yet Another Ri Interface
;; yari.el provides an Emacs frontend to Ruby's `ri' documentation tool. It offers lookup and completion.
(require 'yari)

(dolist (hook '(ruby-mode-hook
                ))
  (add-hook hook (lambda ()
                   (setq yari-ri-program-name "ri")

                   ;; (local-set-key (kbd "C-h d") 'yari)
                   ;; or with my-help-document-prefix-map prefix.
                   (define-key my-help-document-prefix-map (kbd "d") 'yari)
                   (define-key my-help-document-prefix-map (kbd "D") 'yari-helm)
                   )))


;;; [ rvm ] -- integrates Emacs with the rvm (Ruby Version Manager)

;;; Usage:
;;; - [M-x rvm-activate-corresponding-ruby]
;;; - [M-x rvm-use] -- to use another ruby version.
;;; - open the source of any rubygem in your current gemset.
;;;   [M-x rvm-open-gem]

(require 'rvm)
(autoload 'rvm "rvm" "RVM" t)

(rvm-use-default)        ; use rvm's default ruby for the current Emacs session.

(add-hook 'ruby-mode-hook
          (lambda ()
            (rvm-activate-corresponding-ruby)))


;;; [ inf-ruby / Inferior Ruby ]
;;; -- inf-ruby provides a REPL buffer connected to a Ruby(irb/pry) subprocess.

;;; Usage:
;;; - [M-x inf-ruby] :: A simple IRB process can be fired up with M-x inf-ruby.
;;; - [M-x inf-ruby-console-auto] :: To launch a REPL with project-specific console instead, type M-x inf-ruby-console-auto. It recognizes several project types, including Rails, gems and anything with racksh in their Gemfile.
;;; - To see the list of the keybindings defined by inf-ruby-minor-mode, type M-x describe-function [RET] inf-ruby-minor-mode [RET].

;;; Usage:
;; - [M-x run-ruby] -- which runs IRB in an Emacs buffer
;; keybindings:
;; - [C-c C-s] -- inf-ruby
;; - [C-c C-z] -- ruby-switch-to-inf
;; - [M-C-x]   -- ruby-send-definition
;; - [C-x C-e] -- ruby-send-last-sexp
;; - [C-c C-b] -- ruby-send-block
;; - [C-c M-b] -- ruby-send-block-and-go
;; - [C-c C-x] -- ruby-send-definition
;; - [C-c M-x] -- ruby-send-definition-and-go
;; - [C-c C-r] -- ruby-send-region
;; - [C-c M-r] -- ruby-send-region-and-go
;; - [C-c C-l] -- ruby-load-file

(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

;; to your init file to easily switch from common Ruby compilation modes to
;; interact with a debugger.
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(setq inf-ruby-default-implementation "ruby"
      ;; inf-ruby-implementations '(("ruby" . "irb --inf-ruby-mode -r irb/completion")
      ;;                            ("pry"  . "pry")
      ;;                            ("jruby" . "jruby -S irb -r irb/completion")
      ;;                            ("rubinius" . "rbx -r irb/completion")
      ;;                            ("yarv" . "irb1.9 --inf-ruby-mode -r irb/completion")
      ;;                            ("macruby" . "macirb -r irb/completion"))
      ;; inf-ruby-prompt-format
      )

;; integrate with rvm.el
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; Generally, you'll want to start with `M-x inf-ruby-console-auto'. If there's
;; no Ruby console running, most interactive commands provided by Robe will
;; offer to launch it automatically.
;;
(inf-ruby)
;; FIXME: (error "No matching directory found")
;; (inf-ruby-console-auto)


;;; [ ac-inf-ruby ]

;; (require 'ac-inf-ruby)

;; ;;; for Ruby buffers. {Ruby}
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (eval-after-load 'auto-complete
;;               (add-to-list 'ac-sources 'ac-source-inf-ruby))
;;             (add-hook 'inf-ruby-minor-mode-hook 'ac-inf-ruby-enable)
;;             ))

;; ;;; for inf-ruby buffer. (Inf-Ruby)
;; (eval-after-load 'auto-complete
;;   (add-to-list 'ac-modes 'inf-ruby-mode))
;; (add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)
;; (eval-after-load 'inf-ruby
;;   (define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete))


;;; [ auto-complete-ruby ]

(require 'auto-complete-ruby)


;;; [ rcodetools ]

(require 'rcodetools)


;;; [ Robe ] -- Code navigation, documentation lookup and completion for Ruby.
;;;
;;; Robe is a code assistance tool that uses a Ruby REPL subprocess with your
;;; application or gem code loaded, to provide information about loaded classes
;;; and modules, and where each method is defined.
;;;
;;; Generally, you'll want to start with `M-x inf-ruby-console-auto'. If there's
;;; no Ruby console running, most interactive commands provided by Robe will
;;; offer to launch it automatically.
;;;
;;; As you change the code in your project, you'll want to update the running
;;; process. To load the current file, type `C-c C-l (ruby-load-file)', see
;;; inf-ruby for more commands. When you're developing a Rails project, you can
;;; type `C-c C-k' instead, to reload the whole environment at once.
;;;
;;; Features:
;;;
;;; Jump to method definition
;;; Jump to super or a constructor called at point
;;; Jump to a module or class (provided it has at least one method defined)
;;; Display method documentation
;;; Display information about method called at point using ElDoc
;;; Method and constant name completion
;;;
;;; To see the available commands, type M-x describe-package RET robe RET.
;;;
;;; Usage:
;; - [C-c C-d] -- robe-doc
;; - [C-c C-k] -- robe-rails-refresh
;; - [M-,] -- pop tag mark
;; - [M-.] -- robe-jump

(require 'robe)

(add-hook 'ruby-mode-hook 'robe-mode)

;;; [start robe]
;; The exceptions are code completion and eldoc, which only work if the server
;; is already running. To launch it, type M-x robe-start.
;;; Both of the bellowing work only when the connection to the Ruby subprocess
;;; has been established. To do that, either use one of the core Robe commands,
;;; or type M-x robe-start.
;;
;; FIXME: (error "No matching directory found")
;; (eval-after-load 'robe
;;   (robe-start))

;; for auto-complete
(add-hook 'robe-mode-hook
          (lambda ()
            (ac-robe-setup)
            (add-to-list 'ac-sources 'ac-source-robe)
            ;; (set-face-attribute 'ac-??? )
            ))

;; for company-mode
;; (push 'company-robe company-backends)

;; TODO: (setq robe-)


;;; [ ruby-compilation ]

;;; Usage:
;; - [C-x t] -- ruby-compilation-this-buffer
;; - [C-x T] -- ruby-compilation-this-test
;; - [C-h f ruby-compilation-mode] -- get help.
;; - [C-o] -- compilation-display-error
;; - [RET] / [C-c C-c] -- compile-goto-error
;; - [TAB] / [M-n] -- compilation-next-error
;; - [backtab] / [M-p] -- compilation-previous-error
;; - [g] -- recompile
;; - [C-c C-f] -- next-error-follow-minor-mode
;; - [C-c C-k] -- kill compilation

;; FIXME: I require 'ruby-compilation, will lead ruby-compilation bind [p] key to (previous-error-no-select) directly. from Emacs default code `simple.el'.
(add-hook 'ruby-mode-hook
          (lambda ()
            (require 'ruby-compilation)
            ))


;;; [ rspec-mode ] -- Ruby RSpec


;;; [ ruby-dev ]


;;; [ ruby-interpolation ]


;;; [ ruby-refactor ]


;;; [ ruby-test ] -- test runner for ruby unit test.

;;; Usage:
;; - [C-x t] -- ruby test: run file.
;; - [C-x SPC] -- ruby test: run file.
;; - [C-x C-SPC] -- ruby test: run test at point.
;; - [C-c t] -- ruby test: toggle implementation and specification.


;;; [ ruby-test-mode ] -- Emacs minor mode for Behaviour and Test Driven Development in Ruby.

;;; Usage:
;;
;; C-c C-,   - Runs the current buffer's file as an unit test or an
;;             rspec example.
;; C-c M-,   - Runs the unit test or rspec example at the current buffer's
;;             buffer's point.
;; C-c C-s   - Toggle between implementation and test/example files.



;;; [ ruby-tools ]


;;; [ rbenv ] -- integrating rbenv with Emacs


;;; [ yard-mode ] --- Minor mode for Ruby YARD comments


;;; [ Rinari ] -- A Ruby on Rails minor mode for Emacs

;;; Rinari Is Not A Ruby IDE.
;;;
;;; Well, OK it kind of is. Rinari is a set of Emacs Lisp functions aimed
;;; towards making Emacs (or XEmacs) into a top-notch Ruby on Rails development
;;; environment.
;;;
;;; Currently Rinari focuses on the core functionality most everyone would use when working on a Rails applications including...
;; - Navigation between files in your Rails project (see Navigation)
;; - Facilitation of Test/Behavior Driven Development (see Test/Behavior Driven Development)
;; - Execution of tests, consoles, and web-servers (see Execution)
;;
;;; Usage:
;; - [C-h b] :: show all key bindings of Rinari.
;; - [M-x rinari-<tab>] :: all rinari functions.
;; - TAGS
;;   To have Rinari automatically update your tags-file-name variable to point
;;   to the tags of your current rails project, set rinari-tags-file-name (see
;;   Navigation) to the path to your tags file relative to the root of your
;;   rails applications.
;;   (setq rinari-tags-file-name "TAGS")

(require 'rinari)

(add-hook 'rinari-minor-mode-hook
          '(lambda ()
             (setq yas-extra-modes (cons 'rails-mode yas-extra-modes))))

(setq rinari-tags-file-name "TAGS")

(global-rinari-mode t)

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (defadvice ruby-mode-set-encoding
;;                 (around ruby-mode-set-encoding-disable activate) nil)))


(define-key rinari-minor-mode-map (kbd "C-.") 'insert-arrow)


;;; Rhtml setup

;;; http://rinari.rubyforge.org/Rhtml-Setup.html#Rhtml-Setup
;;; There are three options for editing .rhtml files in Emacs. They are presented here in order of decreasing functionality.
;; - nXhtml-Mode: a package for web development
;; - MuMaMo-Mode: allows multiple major modes in a single buffer
;; - rhtml-Mode: edit rhtml files without using multiple major modes

;; (require 'rhtml-mode)

;; (add-hook 'rhtml-mode-hook
;;           (lambda () (rinari-launch)))

;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . rhtml-mode))
;; (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . rhtml-mode))


;;; [ motion-mode ] -- RubyMotion


;;; [ Cucumber ]


;;; [ projectile-rails ]

;;; Usage:
;;; - <prefix> -> [C-c r] + [key]

(require 'projectile-rails)

(setq projectile-rails-add-keywords t)  ; highlight rails keywords.
(setq projectile-rails-expand-snippet t) ; yasnippet expand skeleton class snippet.

(add-hook 'projectile-mode-hook 'projectile-rails-on)


;;; [ Misc Functions ]
(defun browse-development ()
  "Browse rails development url."
  (interactive)
  (browse-url "http://127.0.0.1:3000"))



(provide 'init-my-prog-lang-ruby)

;;; init-my-prog-lang-ruby.el ends here
