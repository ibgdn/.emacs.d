;; ------------------------- custom-operate-habit start -------------------------

;; Turn off the sound warning of error.
(setq visible-bell t)
;; Answer y-or-n instead of yes-or-no.
(fset 'yes-or-no-p 'y-or-n-p)

;; 对内嵌的括号等pair符号加不同颜色
(require-package 'rainbow-delimiters)
(rainbow-delimiters-mode t)

;; use smartparens
(require-package 'smartparens)
;; global enabled, and use strict mode
(smartparens-global-strict-mode +1)

;; To prevent the scrolling of the whole page, scroll-margin 2 left two lines to see the context very well. conservatively(carefully)
(setq scroll-margin 2 scroll-conservatively 99999)

;; Remove whitespace and empty lines at the end of the line or file automatically.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Add an empty line at the end of file. invalid if remove whitespace.
					;  (setq require-final-newline t)


;;当你在shell、telnet、w3m等模式下时，必然碰到过要输入密码的情况,此时加密显出你的密码
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; --------------------------------------------------
;; which-key
;; Displays available keybindings in popup.(The guide-key has the same functionality.)
;; https://github.com/justbur/emacs-which-key
;; --------------------------------------------------
(require-package 'which-key)
(which-key-mode)
(setq which-key-popup-type 'side-window)
;; location of which-key window. valid values: top, bottom, left, right,
;; or a list of any of the two. If it's a list, which-key will always try
;; the first location first. It will go to the second location if there is
;; not enough room to display any keys in the first location
(setq which-key-side-window-location 'right)
;; max width of which-key window, when displayed at left or right.
;; valid values: number of columns (integer), or percentage out of current
;; frame's width (float larger than 0 and smaller than 1)
(setq which-key-side-window-max-width 0.50)
;; max height of which-key window, when displayed at top or bottom.
;; valid values: number of lines (integer), or percentage out of current
;; frame's height (float larger than 0 and smaller than 1)
; (setq which-key-side-window-max-height 0.65)





;; 使用语法显示的大文件在移动时如此之慢（缓解办法）
                                        ; (setq lazy-lock-defer-on-scrolling t)
                                        ; (setq font-lock-support-mode 'lazy-lock-mode)
                                        ; (setq font-lock-maximum-decoration t)

;;设置打开文件的缺省路径
                                        ; (setq default-directory "~/Workspaces/")
                                        ; (setq default-directory "E:/daily/Workspaces/")  ; 目录一定要使用“/”，不然会出现乱码。

;;	在标题栏显示buffer的名字和大小，而不是默认的没用的显示
                                        ; (setq frame-title-format "emacs@%b %I")
                                        ; (setq frame-title-format "%b %I") ;显示文件名和大小
;; 标题栏	就可以显示当前项目名，当前编辑文件的完整路径。
                                        ; (setq frame-title-format
                                        ; (list "[" '(:eval (projectile-project-name)) "]" "emacs@"
                                        ; '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;设置有用的个人信息,这在很多地方有用。
                                        ; (setq user-full-name "XXXXXX")
                                        ; (setq user-mail-address "XXXXXX@163.com")

;; Doing package-list-packages will also update the list of packages.
					;(when (not package-archive-contents)
					;  (package-refresh-contents))

                                        ; --------------------------customize-operate-habit-keybord--------------------------
;;; ------------------------------------------------------------

;; Following on from my post on using C-x k to kill the current buffer, why not bind C-x w to delete-frame in order close the current emacs “window” (remember, in Emacs-speak, a frame is what most other apps would call a window). This is way better than the default C-x 5 0	(Not yet used)
                                        ;(global-set-key (kbd "C-x w") 'delete-frame)

;;; =================================================================================
                                        ; it is come from purcell's init-grep
(setq-default grep-highlight-matches t
              grep-scroll-output t)

					;(when *is-a-mac*
					;  (setq-default locate-command "mdfind"))

(when (executable-find "ag")
  (require-package 'ag)
  (require-package 'wgrep-ag)
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'ag-project))


                                        ; it is come from purcell's init-flycheck. has add in init.el
                                        ; (when (maybe-require-package 'flycheck)
                                        ; (add-hook 'after-init-hook 'global-flycheck-mode)
                                        ; (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))


                                        ; it is come from purcell's init-recentf
                                        ; (recentf-mode 1)
                                        ; (setq-default
                                        ; recentf-max-saved-items 1000
                                        ; recentf-exclude '("/tmp/" "/ssh:"))



                                        ; it is come from purcell's init-mmm
                                        ; Multiple major modes
                                        ; (require-package 'mmm-mode)
                                        ; (require 'mmm-auto)
                                        ; (setq mmm-global-mode 'buffers-with-submode-classes)
                                        ; (setq mmm-submode-decoration-level 2)

                                        ; it is come from purcell's init-

;; -------------------------- customize-operate-habit end --------------------------

(provide 'custom-operate-habit)
