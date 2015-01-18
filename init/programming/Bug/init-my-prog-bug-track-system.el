;;; init-my-prog-bug-track-system.el --- init for Bug Tracking System
;;; -*- coding: utf-8 -*-

;;; Commentary:



;;; Code:

;;; [ bts ] -- bug track system

;;; This is a extension of Emacs that provides a unified interface for various
;;; bug tracking systems.
;; - This works using the plugin for target system.
;;
;;; Features:
;;   - Easily and quickly edit ticket of various bug tracking systems using a unified widget interface
;;   - List up ticket summaries with the combination of multiple conditions at one time
;;   - Edit the listed multiple tickets at one time

;;; Usage:
;;
;; Setup project
;;
;; Project means a access configuration for the system stores target tickets data.
;; Create and update project using bts:project-new / bts:project-update.
;; Setup query
;;
;; Query means a configuration detects the fetched tickets in the tickets belongs to the project.
;; Create and update query using bts:query-new / bts:query-update.
;; Create new ticket
;;
;; Create a ticket of the system using bts:ticket-new.
;; Keymap of widget buffer
;;
;; Widget buffer is opened for editing project/query/ticket.
;; The following keymap is defined in the buffer inherits the standard widget keymap (*1).
;;
;; C-n bts:widget-forward … move to forward widget (*2)
;; C-p bts:widget-backward … move to backward widget (*2)
;; C-M-j bts:widget-jump … jump to any widget (*3)
;; M-RET bts:widget-submit … push submit button
;; M-DEL bts:widget-cancel … push cancel button
;;
;; *1 For checking that, see document of widget-keymap / widget-field-keymap / widget-text-keymap
;; *2 If possible, use pophint.el
;; *3 pophint.el is required
;; List up tickets
;;
;; The system tickets are listed up by bts:summary-open.
;; Multiple queries are selectable in a choice of query.
;; Then, the summary buffer is opened inherits tabulated-list-mode.
;; The following keymap is defined in the buffer inherits tabulated-list-mode-map.
;;
;; j / n next-line … move to down entry
;; k / p previous-line … move to up entry
;; h / b bts:summary-left-column … move to left column
;; l / f bts:summary-right-column … move to right column
;; RET bts:summary-view-ticket … open ticket view (*1)
;; m bts:summary-mark-ticket … mark current entry
;; M bts:summary-mark-all-tickets … mark all entries
;; u bts:summary-unmark-ticket … unmark current entry
;; U / M-DEL bts:summary-unmark-all-tickets … unmark all entries
;; t bts:summary-toggle-ticket-marking … toggle current entry mark situation
;; T bts:summary-toggle-all-tickets-marking … toggle all entries mark situation
;; g / r bts:summary-reload-ticket … fetch the latest data and update current entry
;; G / R bts:summary-reload-all … fetch the latest datas and update all entries (*2)
;;
;; *1 If any entries are marked, target are them (*3). Else, it's current entry
;; *2 The buffer is not updated to latest automatically
;; *3 If target is multiple and the system has the function, open multi view (*4)
;; *4 Multi view is able to edit multiple tickets at one time

(require 'bts)

;; Key Binding
(define-key my-prog-bug-bts-map (kbd "b") 'bts:summary-open)
(define-key my-prog-bug-bts-map (kbd "t") 'bts:ticket-new)
(define-key my-prog-bug-bts-map (kbd "P") 'bts:project-new)
(define-key my-prog-bug-bts-map (kbd "p") 'bts:project-update)
(define-key my-prog-bug-bts-map (kbd "r") 'bts:project-remove)
(define-key my-prog-bug-bts-map (kbd "R") 'bts:project-remove-all)
(define-key my-prog-bug-bts-map (kbd "q") 'bts:query-new)
(define-key my-prog-bug-bts-map (kbd "Q") 'bts:query-update)
(define-key my-prog-bug-bts-map (kbd "d") 'bts:query-remove)
(define-key my-prog-bug-bts-map (kbd "D") 'bts:query-remove-all)

;; (global-unset-key (kbd "M-b"))
;; (global-set-key (kbd "M-b n")   'bts:ticket-new)
;; (global-set-key (kbd "M-b s")   'bts:summary-open)
;; (global-set-key (kbd "M-b p n") 'bts:project-new)
;; (global-set-key (kbd "M-b p u") 'bts:project-update)
;; (global-set-key (kbd "M-b p d") 'bts:project-remove)
;; (global-set-key (kbd "M-b p D") 'bts:project-remove-all)
;; (global-set-key (kbd "M-b q n") 'bts:query-new)
;; (global-set-key (kbd "M-b q u") 'bts:query-update)
;; (global-set-key (kbd "M-b q d") 'bts:query-remove)
;; (global-set-key (kbd "M-b q D") 'bts:query-remove-all)

;; TODO:
;; About other config item, see Customization or eval the following sexp.
;; (customize-group "bts")




;; [ bts-github ] -- bts for GitHub

;;; Usage:
;;
;; -

(require 'bts-github)

;; TODO:
;; About config item, see Customization or eval the following sexp.
;; (customize-group "bts-github")



(provide 'init-my-prog-bug-track-system)

;;; init-my-prog-bug-track-system.el ends here
