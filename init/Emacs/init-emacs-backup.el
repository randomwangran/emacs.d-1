;;; init-emacs-backup.el --- init for Emacs backup

;;; Commentary:

;;; Usage:

;; - `recover-file' :: recover file from file~.


;;; Code:


(setq make-backup-files t
      backup-by-copying t
      backup-by-copying-when-mismatch t
      backup-by-copying-when-privileged-mismatch t
      backup-by-copying-when-linked t
      version-control t ; use versioned backups.
      vc-make-backup-files nil ; do not backup files in vc.
      ;; backup-inhibited t ; do not generate backup
      delete-old-versions t             ; auto delete old versions.
      kept-new-versions 3               ; number of new versions.
      kept-old-versions 3               ; number of old versions.
      )

(setq backup-directory-alist
      `(("." . ,(expand-file-name "~/.emacs.d/.backups")))
      ;; `((".*" . ,temporary-file-directory)) ; put all under directory /tmp.
      )


;;; [ auto-save-mode ] -- toggle auto-saving in the current buffer.

(setq auto-save-default t               ; create #autosave# files
      auto-save-list-file-prefix "~/.emacs.d/.auto-save-list/saves-"
      auto-save-interval 0)
(auto-save-visited-mode t)

;;; [ snapshot-timemachine ] -- provides a interface for snapshot or backup facility, e.g. Btrfs, ZFS, etc.

(use-package snapshot-timemachine
  :ensure t
  :commands (snapshot-timemachine snapshot-timeline))


(provide 'init-emacs-backup)

;;; init-emacs-backup.el ends here
