;;; init-my-tool-calendar.el --- init for Calendar
;;; -*- coding: utf-8 -*-

;;; Commentary:


;;; Code:

(unless (boundp 'my-calendar-prefix)
  (define-prefix-command 'my-calendar-prefix))
(define-key my-tools-prefix (kbd "c") 'my-calendar-prefix)
(unless (boundp 'my-org-prefix)
  (define-prefix-command 'my-org-prefix))
(define-key my-org-prefix (kbd "C") 'my-calendar-prefix)


;;; [ calendar ]

(use-package calendar
  :config
  ;; ;; Month
  ;; (setq calendar-month-name-array
  ;;       ["January" "February" "March"     "April"   "May"      "June"
  ;;        "July"    "August"   "September" "October" "November" "December"])
  ;; ;; Week days
  ;; (setq calendar-day-name-array
  ;;       ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

  ;; First day of the week
  (setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday
  (setq calendar-weekend-days '(0 6))
  ;; 'american: month/day/year, 'european: day/month/year, 'iso: year/month/day
  (setq calendar-date-style 'american)

  ;; Calendar Localization
  (setq calendar-time-zone +480 ; UTC+8 (China)
        ;; calendar-latitude
        ;; calendar-longitude
        )

  ;; mark holidays
  (setq calendar-mark-holidays-flag nil)
  (add-hook 'calendar-initial-window-hook 'calendar-mark-holidays)

  ;; mark today
  (setq calendar-today-marker 'calendar-today)
  (add-hook 'calendar-initial-window-hook 'calendar-mark-today)
  
  )



;;; [ Holidays ]

(use-package holidays
  :config
  ;; `calfw' collects holidays from function `calendar-holiday-list' and the
  ;; customize variable `calendar-holidays' which belongs to `holidays.el` in
  ;; Emacs.
  (setq holiday-general-holidays nil) ; get rid of U.S. holidays
  (setq holiday-christian-holidays nil) ; get rid of christan holidays
  (setq calendar-view-holidays-initially-flag t)
  )

;;; Annotations
;;; variable -> :annotation-sources


;;; Localized National Holidays

;;; cal-china-x.el -- Chinese calendar extras
;;; display the ‘celestial-stem’ (天干) and the ‘terrestrial-branch’ (地支) in Chinese:

;; (setq chinese-calendar-celestial-stem
;;       ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"]
;;       chinese-calendar-terrestrial-branch
;;       ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])
;;
;; (load "~/.emacs.d/init/extensions/cal-china-x.el")
;; (require 'cal-china-x)


;; Location

;; for predicate lunar eclipses.

;; Zhejiang, China Area: Latitude: 27° 09' ~ 31° 11' N , Longitude: 118° 02' ~ 122° 57' E
;; Shaoxing Area: Latitude: 29° 42' ~ 30° 19' 15" , Longitude: 120° 16' 55" ~ 120° 46' 39"

(setq calendar-location-name "Shaoxing")
(setq calendar-latitude +30.10)
(setq calendar-longitude +120.40)

(setq calendar-mark-holidays-flag nil
      calendar-today-marker 'calendar-today)




;; [ Diary ] -- Diary Mode

(use-package diary
  :config
  ;; fancy display
  (setq calendar-view-diary-initially-flag nil
        calendar-mark-diary-entries-flag nil ; 'calendar-today, "=", face
        diary-number-of-entries 7)

  (add-hook 'diary-display-function 'diary-fancy-display)
  (add-hook 'calendar-today-visible-hook 'calendar-mark-today)
  )


;;; [ calfw ] -- Calendar framework for Emacs

(use-package calfw
  :bind (:map my-calendar-prefix
              ("o" . cfw:open-org-calendar)
              ("x" . cfw:open-calendar-buffer)
              )
  :config
  ;; Faces
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
  ;; Another unicode chars
  (setq cfw:fchar-junction ?╬
        cfw:fchar-vertical-line ?║
        cfw:fchar-horizontal-line ?═
        cfw:fchar-left-junction ?╠
        cfw:fchar-right-junction ?╣
        cfw:fchar-top-junction ?╦
        cfw:fchar-top-left-corner ?╔
        cfw:fchar-top-right-corner ?╗)

  ;; Line breaking
  (setq cfw:render-line-breaker 'cfw:render-line-breaker-wordwrap)


  ;; for Org-mode
  (require 'calfw-org)

  ;; (setq cfw:org-agenda-schedule-args '(:timestamp))
  ;; (setq cfw:org-overwrite-default-keybinding nil)

  ;; org-capture template
  (setq cfw:org-capture-template
        '("c" "calfw2org" entry
          (file nil)
          "* %?\n %(cfw:org-capture-day)"))

  ;; for iCalendar (Google Calendar) users:
  ;; (require 'calfw-ical)
  ;; (cfw:open-ical-calendar "http://www.google.com/calendar/ical/.../basic.ics")

  ;; for Diary users:
  ;; - [M-x cfw:open-diary-calendar]
  ;; (require 'calfw-cal)

  ;; calfw-gcal.el -- edit Google Calendar for calfw.
  ;; (require 'calfw-gcal)

  ;; for Howm users:
  ;; (require 'calfw-howm)


  ;; General setting
  (defun my-open-calfw-week ()
    (interactive)
    (cfw:open-calendar-buffer
     :contents-sources
     (list
      (cfw:org-create-source "dark gray") ; Org-mode source
      ;; (cfw:cal-create-source "orange") ; Diary source
      ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray") ; iCalendar source1
      ;; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; Google Calendar ICS
      ;; (cfw:howm-create-source "blue") ; howm source
      )
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
  )


;;; [ iCalendar ]



(provide 'init-my-tool-calendar)

;;; init-my-tool-calendar.el ends here
