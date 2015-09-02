;;; init-my-packages.el --- init for my packages
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

(defvar my-packages
  '(names
    namespaces
    let-alist ; (from GNU ELPA)
    ;; auto-compile
    use-package
    
    ;; Emacs
    ;; Apperance
    color-theme
    color-theme-solarized
    monokai-theme
    page-break-lines
    ;; mode-line
    nyan-mode nyan-prompt
    ;; Keybinding
    helm-bind-key
    which-key
    hydra
    ;; showkey
    ;; keyfreq
    ;; Debug
    edebug-x
    bug-hunter
    ;; Profile & Benchmark
    ;; esup benchmark-init
    ;; Server & Client
    edit-server
    ;; View
    ;; on-screen
    ;; Macro
    ;; elmacro macrostep
    ;; Edit
    undo-tree
    iedit multiple-cursors
    expand-region
    vlf
    tablist
    ;; Narrow
    ;; fancy-narrow narrow-indirect narrow-reindent recursive-narrow
    ;; narrowed-page-navigation
    ;; Navigation
    show-marks
    ;; ace-jump-mode
    ;; Fold
    allout allout-widgets
    foldout
    origami
    ;; Info, Man,
    info+ ; woman
    ;; Dired
    dired-rainbow
    dired-single dired-efap dired-details dired-narrow dired-open dired-sort dired-k ; dired-hack-utils
    direx
    peep-dired
    image-dired
    dired-dups
    ;; ranger
    ;; Sudo
    ;; sudo-edit
    ;; Spell
    flyspell flyspell-lazy
    helm-flyspell flyspell-popup
    ;; Completion System
    helm
    helm-helm-commands helm-descbinds
    ;; ivy counsel
    ;; Popup
    popup pos-tip
    showtip
    ;; Frame, Window & Session Management
    window-number
    popwin ; shackle
    zoom-window ; zoom-frm
    ;; window-purpose
    ;; e2wm elscreen
    workgroups2
    ;; Mode
    mmm-mode ; polymode
    ;; Unicode
    ;; helm-unicode
    pretty-mode
    ;; pretty-symbols
    ;; purty-mode
    ;; Color
    ansi-color rainbow-mode kurecolor
    ;; Process
    ;; dizzee ; prodigy
    ;; Server
    elnode web-server websocket ; httpd
    
    ;; Shell
    eshell ; shell-here shell-toggle
    ;; shelldoc
    
    ;; Org-mode
    org org-plus-contrib
    org-bullets
    org-beautify-theme
    org-agenda-property
    org-pdfview
    org-projectile
    org-download
    org-password-manager
    ;; org-caldav org-gcal org-mac-iCal
    orgtbl-ascii-plot
    orgit
    ob-prolog
    ob-mongo
    ob-http ob-browser
    ob-ipython
    ;; ob-translate
    org-screenshot
    org-projectile
    ;; org-pomodoro
    ;; org-vcard
    ;; org-trello org-redmine org-readme
    ;; org-tree-slide
    
    ;; Programming
    ;; Auto Complete
    company company-statistics company-quickhelp
    ;; company-try-hard
    ;; Snippet
    yasnippet
    helm-c-yasnippet
    ;; Template
    ;; yatemplate skeletor
    ;; Diff
    ;; diffview
    ;; VCS
    magit
    magit-find-file magit-filenotify magit-popup magit-tramp
    magit-gitflow
    ;; magit-annex magit-gerrit magit-gh-pulls magit-stgit magit-topgit
    ;; helm-git helm-git-files
    git-messenger
    git-gutter git-gutter+
    ;; git-gutter-fringe git-gutter-fringe+
    ;; Gitlab
    gitlab
    ;; Indent
    aggressive-indent ; auto-indent-mode
    indent-guide
    ;; Electric
    paredit
    smartparens ; autopair
    ;; Comment
    poporg ; outorg
    boxquote fic-mode
    ;; Linter
    flycheck flycheck-pos-tip helm-flycheck
    ;; Document
    dash helm-dash dash-at-point dash-functional
    irfc
    ;; Project Sidebar
    project-explorer ; sr-speedbar
    ;; Project
    projectile
    helm-projectile
    helm-cmd-t
    ;; Search
    isearch+ anzu
    swiper
    helm-c-moccur color-moccur
    ;; Regexp
    visual-regexp visual-regexp-steroids
    ample-regexps pcre2el regex-tool
    ;; wgrep wgrep-ack wgrep-helm
    ack full-ack helm-ack
    ag helm-ag
    pt helm-pt
    ;; helm-recoll
    ;; Tags
    ;; ctags ctags-update
    ;; rtags
    helm-cscope
    xcscope
    ggtags
    helm-gtags
    ;; Compile
    smart-compile quickrun
    ;; Inferior
    ;; REPL
    eval-in-repl
    ;; Make
    ;; helm-make
    ;; Sense
    ;; cedet
    sourcegraph
    ;; License
    ;; xlicense
    ;; Code Paste
    yagist helm-gist
    ;; Bug Track System
    bts bts-github
    ;; Test
    ;; cerbere test-case-mode
    ;; runtests
    ;; Refactor
    emr
    
    ;; Languages
    ;; Lisp
    rainbow-delimiters rainbow-blocks
    slime slime-annot slime-company ; slime-repl
    sly sly-company
    geiser
    eval-sexp-fu
    ;; Emacs Lisp
    elisp-slime-nav
    eldoc-eval
    hl-sexp highlight-symbol highlight-escape-sequences
    ;; ert
    ;; ert-async  ert-runner ert-modeline ert-expectations ; ert-junit
    ;; Shell
    insert-shebang
    ;; C & C++
    irony irony-eldoc flycheck-irony
    company-irony company-irony-c-headers
    company-c-headers
    function-args
    ;; company-cmake
    ;; Lua
    ;; lua-mode
    ;; Ruby
    ruby-mode enh-ruby-mode ruby-additional
    inf-ruby ruby-compilation ; pry
    rbenv rvm  ; ruby-dev  ; chruby
    robe ; zossima
    yari yard-mode ; helm-rb
    ruby-tools
    rspec-mode minitest ruby-test-mode
    ruby-block ruby-hash-syntax ruby-interpolation
    ruby-electric ; ruby-end
    ;; ruby-guard
    ;; motion-mode
    ;; Python
    pyenv-mode pyvenv
    virtualenv virtualenvwrapper
    ;; jedi company-jedi
    anaconda-mode company-anaconda
    ;; Clojure
    clojure-mode-extra-font-locking
    inf-clojure ; clojure-env
    cider-eval-sexp-fu
    flycheck-clojure
    elein
    ;; Elixir
    elixir-mode ; alchemist
    ;; Go
    go-mode go-complete company-go go-eldoc
    gore-mode ; gotest
    ;; Java
    ;; jdee
    emacs-eclim
    ;; PHP
    php-mode inf-php php-eldoc
    ;; php-boris php-boris-minor-mode
    ;; phpunit
    ;; Nim
    ;; nim-mode
    ;; Rust
    ;; rust-mode flycheck-rust
    ;; Haskell
    haskell-mode
    ;; Erlang
    erlang
    ;; Julia
    julia-mode
    ;; IPython
    ein ; ein-mumamo
    ;; ESS
    ess
    ess-smart-equals ess-smart-underscore
    ess-R-data-view ess-R-object-popup
    ;; company-ess
    ;; Processing
    ;; processing-mode
    ;; Plot
    gnuplot
    ;; Database
    ;; SQL
    sqlup-mode format-sql sql-indent
    emacsql
    edbi edbi-sqlite edbi-database-url company-edbi edbi-minor-mode
    ;; db db-sql
    db-pg
    ;; sqlplus
    ;; SQLite
    sqlite
    ;; PostgreSQL
    pg pgdevenv
    ;; NoSQL
    ;; MongoDB
    mongo inf-mongo ; mongo-elnode
    ;; Redis
    redis eredis
    ;; HTML
    emmet-mode
    ;; CSS
    css-eldoc
    show-css
    ;; Scss & Less
    ;; scss-mode
    ;; less-css-mode
    ;; helm-css-scss
    ;; Slim
    ;; slim-mode
    ;; JavaScript
    js2-mode js3-mode js-doc
    js-comint
    tern company-tern tj-mode
    jst jss
    ;; Node.js
    ;; nodejs-repl
    ;; CoffeeScript
    coffee-mode
    ;; Web
    web-mode
    ;; multi-web-mode
    skewer-mode
    json-mode ; json-rpc
    ;; xml xmlunicode ; xmlgen xml-rpc
    ;; web-beautify
    restclient httprepl web
    web-completion-data
    know-your-http-well httpcode
    company-web company-restclient
    ;; Browser
    ;; dom
    ;; WebKit
    ;; kite jss
    livid-mode
    ;; AngularJS
    angularjs-mode
    ;; Assembly
    nasm-mode iasm-mode
    ;; TeX
    company-auctex company-math
    latex-pretty-symbols
    px latex-preview-pane ; latex-math-preview
    ;; Markdown
    markdown-mode
    ;; YAML
    yaml-mode
    ;; pandoc-mode
    ;; Sass
    sass-mode
    ;; Haml
    haml-mode
    
    ;; Frameworks
    ;; Ruby on Rails
    projectile-rails rails-new ; helm-rails
    rhtml-mode
    ;; Android
    android-mode
    ;; Arduino
    arduino-mode company-arduino

    ;; Linux
    ;; emamux
    systemd
    nginx-mode
    pkgbuild-mode
    ;; stumpwm-mode
    ;; Container
    docker dockerfile-mode
    docker-tramp
    vagrant vagrant-tramp
    ;; Heroku
    heroku
    
    ;; Tools
    ;; Bookmarks
    helm-bm
    helm-w3m helm-firefox ; helm-chrome
    ;; PDF
    pdf-tools
    ;; Image
    image+ ; xpm
    ;; Ascii Graphic
    artist chart
    ;; Notify
    ;; sauron
    ;; Speak
    ;; ess
    ;; Browser
    ;; w3m
    ;; Email
    ;; gnus
    ;; mu4e
    mu4e-maildirs-extension helm-mu
    ;; Contacts
    bbdb bbdb-vcard bbdb-csv-import
    ;; Feeds: RSS & Atom
    elfeed elfeed-web
    ;; Blog
    octopress org-octopress
    ;; Calendar
    calfw ; calfw-gcal
    ;; Chat
    ;; IRC
    ;; erc circe
    ;; weechat
    ;; Music
    ;; emms ; emms-info-media helm-emms
    ;; Screenshot & Screencast
    screenshot camcorder ; impatient-mode
    ;; command-log-mode
    ;; Download
    ;; aria2 wget
    ;; Read
    spray
    ;; Typing
    ;; speed-type
    ;; World Time
    world-time-mode
    ;; Collaborate
    ;; rudel togetherly
    
    ;; Emacs Libraries
    ;; Object
    ;; @
    ;; Overlay
    ;; ov
    ;; Popup
    ;; Process
    ;; Widget
    ;; widget-mvc
    ;; async deferred concurrent
    
    ;; Languages
    ;; Chinese
    ;; pangu-spacing
    ;; pinyin-search
    ;; Japanese
    ;; migemo
    )
  "A list of packages to ensure are installed at launch.")



(provide 'init-my-packages)

;;; init-my-packages.el ends here
