;; ------------------------------ window-display begin ------------------------------

;; Turn off boot screen when boot on.
(setq inhibit-startup-message t)
;; Turn off boot screen when boot on. invalid
					;  (setq gnus-inhibit-startup-message t)

;; --------------------------------- title bar
;; display buffer's name and path in the title bar.
;; (setq frame-title-format "emacs@%b %I")  ; display buffer's name and size.
;; display the name of current project and the full path of edit file.
(setq frame-title-format
      (list "emacs@"
            '(buffer-file-name "%f" (dired-directory dired-directory "%b %I"))))

;; Display line numbers.
(global-linum-mode 'linum-mode)

;; no scroll
(set-scroll-bar-mode nil)

;; no tool bar
;; (tool-bar-mode nil) ;; not work

;; fullscreen when start
;; (custom-set-variables
;; '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; --------------------------------- window size
(setq default-frame-alist
      '((vertical-scroll-bars)
        (width . 110)
        (height . 38)
	(tool-bar-lines . 0)
        ))

;; --------------------------------- Location
;; Display the cursor of (row,column) number on Minibuffer.
(column-number-mode t)

;; --------------------------------- Time line
(display-time-mode t) ; display time
(setq display-time-24hr-format t) ; 24 hour system
;; (setq display-time-day-and-date t);;时间显示包括日期和具体时间
;; (setq display-time-use-mail-icon t);;时间栏旁边启用邮件设置
(setq display-time-interval 100) ; refresh interval

;; --------------------------------- Mode
;; Show match paren,like "()".
(show-paren-mode t)

;; Highlight the current line of cursor moved.
(global-hl-line-mode t)

;; Word wrap automatically in org-mode.(There is not word-wrap function in org-mode)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))


;; ------------------------------ window-display begin ------------------------------
(provide 'init-window-display)
