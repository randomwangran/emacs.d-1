;;; init-my-tool-calendar.el --- init for Calendar
;;; -*- coding: utf-8 -*-

;;; Commentary:


;;; Code:

;;; Calendar Mode

(require 'calendar)

;; ;; Month
;; (setq calendar-month-name-array
;;       ["January" "February" "March"     "April"   "May"      "June"
;;        "July"    "August"   "September" "October" "November" "December"])
;; ;; Week days
;; (setq calendar-day-name-array
;;       ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

;;; Calendar Localization

;; First day of the week
(setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday
(setq calendar-date-style 'american) ; 'american: month/day/year, 'european: day/month/year, 'iso: year/month/day


;;; Localized National Holidays

;;; cal-china-x.el -- Chinese calendar extras
;;; display the ‘celestial-stem’ (天干) and the ‘terrestrial-branch’ (地支) in Chinese:

(load "~/.emacs.d/init/extensions/cal-china-x.el")
(require 'cal-china-x)


;; Location

;; for predicate lunar eclipses.

;; Zhejiang, China Area: Latitude: 27° 09' ~ 31° 11' N , Longitude: 118° 02' ~ 122° 57' E
;; Shaoxing Area: Latitude: 29° 42' ~ 30° 19' 15" , Longitude: 120° 16' 55" ~ 120° 46' 39"

(setq calendar-location-name "Shaoxing")
(setq calendar-latitude +30.10)
(setq calendar-longitude +120.40)

(setq calendar-mark-holidays-flag nil
      calendar-mark-diary-entries-flag nil ; 'calendar-today, "=", face
      calendar-view-diary-initially-flag t
      calendar-today-marker 'calendar-today)


;;; Calendar Printing
;;;
;;; Usage:
;;
;; - press "t m" on the current month in Calendar Mode buffer. This will create
;;   a new buffer named 'calendar.tex' containing a latex representation of the
;;   current month.
;;
;; - then press [C-c C-c] to "compile" the file. You can see it by press [C-c
;;   C-c] again.
;;
;; - press [C-c C-p] to print the compiled PDF file.
;;
;;; Printing to A4 pages
;;
;; If you print A4 pages, the calendars are probably too wide for you. I often
;; print monthly calendars. The default setup prints them 18cm wide; I want them
;; 17cm wide. Here’s how to do it:
;;
;; (add-hook 'cal-tex-hook 'my-calendar-print-A4)
;; (defun my-calendar-print-A4 ()
;;   "Replace all occurences of 18cm with 17cm."
;;   (goto-char (point-min))
;;   (while (search-forward "18cm" nil t)
;;     (replace-match  "17cm")))
;;
;;; Printing Key bindings
;;
;; - [p C-h] -- list out all key bindings


;;; Key Bindings
;;
;; - [C-SPC] + [M-=] -- count the number of days in region (between the mark and
;;                      the current point).
;; - [8 C-n] -- move ahead 8 days.

(add-hook 'calendar-initial-window-hook
          '(lambda ()
             (calendar-mark-today)
             (calendar-mark-holidays)
             ;; (mark-diary-entries) ; FIXME: void function.
             ))


;; [ Diary ] -- Diary Mode

;; Usage:
;;
;; - [M-x calendar RET d]
;; - [M-x diary]
;;
;; - `diary-mode-map'
;;   - m  mark diary entries
;;   - d  view diary entries
;;   - s  show all diary entries
;;   - id insert diary entry
;;   - iw insert weekly diary entry
;;   - im insert monthly diary entry

;; fancy display
(setq calendar-view-diary-initially-flag t
      calendar-mark-diary-entries-flag t
      diary-number-of-entries 7)

(add-hook 'diary-display-function 'diary-fancy-display)
(add-hook 'calendar-today-visible-hook 'calendar-mark-today)


;;; [ iCalendar ]



;;; [ calfw ] -- Calendar framework for Emacs

(require 'calfw)

;;; Holidays
;; calfw collects holidays from the customize variable `calendar-holidays` which belongs to `holidays.el` in Emacs.
;; calfw gets the holidays using the function (calendar-holiday-list).
(require 'holidays)

(setq holiday-general-holidays nil) ; get rid of U.S. holidays
(setq holiday-christian-holidays nil) ; get rid of christan holidays
(setq calendar-view-holidays-initially-flag t)

;;; Annotations
;;; variable -> :annotation-sources


;;; Keybindings

(unless (boundp 'my-calendar-prefix)
  (define-prefix-command 'my-calendar-prefix))
(define-key my-tools-prefix (kbd "c") 'my-calendar-prefix)
(define-key my-org-prefix (kbd "C") 'my-calendar-prefix)


;;; for Org-mode

;;; - [M-x cfw:open-org-calendar]

(require 'calfw-org)

;; (setq cfw:org-agenda-schedule-args '(:timestamp))
;; (setq cfw:org-overwrite-default-keybinding nil)

(define-key my-calendar-prefix (kbd "o") 'cfw:open-org-calendar)

;;; org-capture template
(setq cfw:org-capture-template
      '("c" "calfw2org" entry
        (file nil)
        "* %?\n %(cfw:org-capture-day)"))

;;; for iCalendar (Google Calendar) users:
;; (require 'calfw-ical)
;; TODO (cfw:open-ical-calendar "http://www.google.com/calendar/ical/.../basic.ics")

;;; for Diary users:
;;; - [M-x cfw:open-diary-calendar]
;; (require 'calfw-cal)

;;; calfw-gcal.el -- edit Google Calendar for calfw.
;; (require 'calfw-gcal)

;;; for Howm users:
;; (require 'calfw-howm)


;;; General setting

(defun my-open-calfw-week ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "dark gray") ; Org-mode source
    ;; (cfw:cal-create-source "orange") ; Diary source
    ;; TODO
    ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray") ; iCalendar source1
    ;; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; Google Calendar ICS
    ;; (cfw:howm-create-source "blue") ; howm source
    )
   ;; TODO add annotation-sources
   ;; :annotation-sources
   ;; (list
   ;;  (cfw:ical-create-source "Moon" "~/moon.ics" "Gray") ; Moon annotations
   ;;  )
   :view 'week                         ; 'month, 'week, 'day
   )
  (bury-buffer)
  (switch-to-buffer "*cfw-calendar*")
  ;; (toggle-frame-maximized)
  ;; (cfw:refresh-calendar-buffer t)
  )

(defun my-open-calfw-day ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "dark gray") ; Org-mode source
    (cfw:cal-create-source "orange") ; Diary source
    )
   :view 'day                           ; 'month, 'week, 'day
   )
  (bury-buffer)
  (switch-to-buffer "*cfw-calendar*")
  )

(defun my-open-calfw-month ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "dark gray") ; Org-mode source
    (cfw:cal-create-source "orange") ; Diary source
    )
   :view 'month                         ; 'month, 'week, 'day
   )
  (bury-buffer)
  (switch-to-buffer "*cfw-calendar*")
  )

(define-key my-calendar-prefix (kbd "c") 'my-open-calfw-week)
(define-key my-calendar-prefix (kbd "w") 'my-open-calfw-week)
(define-key my-calendar-prefix (kbd "d") 'my-open-calfw-day)
(define-key my-calendar-prefix (kbd "m") 'my-open-calfw-month)
(define-key my-calendar-prefix (kbd "x") 'cfw:open-calendar-buffer)


;;; Faces

;; Year / Month
(set-face-attribute 'cfw:face-title nil
                    :foreground "forest green"
                    :weight 'bold
                    :height 2.3)
;; 1-31
(set-face-attribute 'cfw:face-default-day nil
                    :foreground "white" :background "black"
                    )
;; 1-31 (N)
(set-face-attribute 'cfw:face-day-title nil
                    :foreground "dim gray"
                    :background "black")
;; Week (1-5)
(set-face-attribute 'cfw:face-header nil
                    :foreground "sky blue"
                    :weight 'bold)
;; Saturday
(set-face-attribute 'cfw:face-saturday nil
                    :inherit 'cfw:face-day-title
                    :foreground "deep pink"
                    :weight 'bold
                    ;; :box '(:color "orange" :line-width -1)
                    )
;; Sunday
(set-face-attribute 'cfw:face-sunday nil
                    :inherit 'cfw:face-day-title
                    :foreground "deep pink"
                    :weight 'bold
                    ;; :box '(:color "yellow" :line-width -1)
                    )
;; Holidays
(set-face-attribute 'cfw:face-holiday nil
                    :inherit 'cfw:face-day-title
                    :foreground "yellow" :background "black"
                    ;; :weight 'normal
                    :overline t
                    ;; :box '(:color "yellow" :line-width -1)
                    )
;; Grid
(set-face-attribute 'cfw:face-grid nil
                    :foreground "#333333"
                    )
;; ??
(set-face-attribute 'cfw:face-default-content nil
                    :foreground "gray")
;; ??
(set-face-attribute 'cfw:face-periods nil
                    :foreground "cyan")
;; ??
(set-face-attribute 'cfw:face-annotation nil
                    :foreground "dark green"
                    ;; :background "#121212"
                    )
;; past days
(set-face-attribute 'cfw:face-disable nil
                    :foreground "#333333"
                    :strike-through t)
;; today (N)
(set-face-attribute 'cfw:face-today-title nil
                    :inherit 'cfw:face-day-title
                    :foreground "cyan"
                    :weight 'bold
                    ;; :box '(:color "dark cyan" :line-width -1)
                    )
;; today events grid
(set-face-attribute 'cfw:face-today nil
                    :inherit 'cfw:face-day-title
                    :foreground "dark gray"
                    :background "#121212"
                    :weight 'normal
                    )
;; current select
(set-face-attribute 'cfw:face-select nil
                    :foreground "black" :background "cyan"
                    ;; :box '(:color "cyan" :line-width -1)
                    )
;; toolbar [ < ] [ > ] [Today ]                      [Day] [Week] [Two Weeks] [Month]
(set-face-attribute 'cfw:face-toolbar nil
                    :foreground "gray")
(set-face-attribute 'cfw:face-toolbar-button-on nil
                    :foreground "white"
                    :weight 'bold
                    :box '(:color "yellow" :line-width 1))
(set-face-attribute 'cfw:face-toolbar-button-off nil
                    :foreground "dim gray"
                    :weight 'normal)


;; Grid frame

;; Default setting
(setq cfw:fchar-junction ?+
      cfw:fchar-vertical-line ?|
      cfw:fchar-horizontal-line ?-
      cfw:fchar-left-junction ?+
      cfw:fchar-right-junction ?+
      cfw:fchar-top-junction ?+
      cfw:fchar-top-left-corner ?+
      cfw:fchar-top-right-corner ?+)

;; Unicode characters
(setq cfw:fchar-junction ?╋
      cfw:fchar-vertical-line ?┃
      cfw:fchar-horizontal-line ?━
      cfw:fchar-left-junction ?┣
      cfw:fchar-right-junction ?┫
      cfw:fchar-top-junction ?┯
      cfw:fchar-top-left-corner ?┏
      cfw:fchar-top-right-corner ?┓)

;; Another unicode chars
(setq cfw:fchar-junction ?╬
      cfw:fchar-vertical-line ?║
      cfw:fchar-horizontal-line ?═
      cfw:fchar-left-junction ?╠
      cfw:fchar-right-junction ?╣
      cfw:fchar-top-junction ?╦
      cfw:fchar-top-left-corner ?╔
      cfw:fchar-top-right-corner ?╗)


;;; Line breaking

(setq cfw:render-line-breaker 'cfw:render-line-breaker-wordwrap)

;;; 'cfw:render-line-breaker-none
;;;     Never breaks lines. Longer contents are truncated.
;;; 'cfw:render-line-breaker-simple (default)
;;;     This strategy breaks lines with rigid width. This may be not so beautiful, but In the most cases it looks good.
;;; 'cfw:render-line-breaker-wordwrap
;;;     This strategy breaks lines with the emacs function 'fill-region'. Although, the line breaking algorithm of the Emacs is not so smart as more complicated ones, such as Knuth/Plass algorithm, this strategy is better than the simple one.


;;; Calfw framework details

;;; How to add a new calendar source?
;;; Defining the 'cfw:source' object, one can extend calfw calendar source.
;;; 'cfw:source-data' details

;;; cfw:source-data

;;; keybindings
;; ;; Vim style navigation around
;; (define-key cfw:calendar-mode-map (kbd "k") 'cfw:navi-previous-week-command)
;; (define-key cfw:calendar-mode-map (kbd "j") 'cfw:navi-next-week-command)
;; (define-key cfw:calendar-mode-map (kbd "h") 'cfw:navi-previous-day-command)
;; (define-key cfw:calendar-mode-map (kbd "l") 'cfw:navi-next-day-command)
;; ;; 
;; (define-key cfw:calendar-mode-map (kbd "p") 'cfw:navi-previous-week-command)
;; (define-key cfw:calendar-mode-map (kbd "n") 'cfw:navi-next-week-command)
;; (define-key cfw:calendar-mode-map (kbd "b") 'cfw:navi-previous-day-command)
;; (define-key cfw:calendar-mode-map (kbd "f") 'cfw:navi-next-day-command)


;; [ Appointment & Remind ]
;; (require 'appt)
;; (setq appt-issue-message t) ; raise issue message for appointment

;; planner



(provide 'init-my-tool-calendar)

;;; init-my-tool-calendar.el ends here
