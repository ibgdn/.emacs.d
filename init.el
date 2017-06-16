;;; ================================ version check begin ================================
(let ((minven "25.1"))	;11:13 2017/1/24
  (when (version<= emacs-version "25.1")
    (error "All of the configurations is requires v%s. Please update your Emacs." minven)))
;;; ================================= version check end =================================

;;; =================================== custom  begin ===================================
;; --------------------------------- GC
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(add-hook 'after-init-hook
	  (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;; the frequent(more times in short time) garbage collection lead to run caton：https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/?st=ixl6iw4r&sh=256da377
(setq gc-cons-threshold (* 1024 1024 1024)) ; lead to GC if excess data capacity. earlier 14:56 2017/1/24
(setq gc-cons-percentage 0.8) ; Set percent
(run-with-idle-timer 10 t #'garbage-collect) ; Once the emacs is complete, the GC-function will be called after ten seconds free.
(setq garbage-collection-messages t)
(let ((file-name-handler-alist nil)) "~/init.el") ; Start files to match regular expressions, 'file-name-handler-alist' default value is: (("\\`/[^/]*\\'" . tramp-completion-file-name-handler) ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler) ("\\`/:" . file-name-non-special))


;; --------------------------------- Bootstarp config
(setq custom-file (expand-file-name "customize.el" user-emacs-directory)) ; not working


;; --------------------------------- Load init files
(add-to-list 'load-path (expand-file-name "lisp/init-file" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/custom" user-emacs-directory))

(require 'init-purcell-utils) ; 9:59 2017/1/25 ; after-load inside, dependence on init-packages.
(require 'init-purcell-site-lisp) ; 9:35 2017/2/17 ; Must come before customize-package-repository, as it may provide package.el
(require 'init-packages-repository) ; Load packages repository.
(require 'init-packages-function) ; Defun after-load/require-package/maybe-require-package
;;; Calls (package-initialize)
(require 'init-window-display) ; Screen.

;;(require 'purcell-exec-path) ;;Set up $PATH
(require 'init-purcell-benchmarking) ;; Measure startup time	14:48 2017/1/24
;; (defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
;; (defconst *is-a-mac* (eq system-type 'darwin))
(require 'custom-operate-habit) ; Some operate configs for startup,package and so on. 11:18 2017/2/17
;; (require 'custom-modes-settings) ; Default turn on some modes. 2017/06/15
(require 'custom-key-bind) ; Keys bind on function. 2017/06/15


;; ----------------------------- load packages configs -----------------------------
(add-to-list 'load-path (expand-file-name "lisp/purcell" user-emacs-directory))
(require 'purcell-ibuffer)
(require 'custom-smex) ;; it provides a convenient interface to your recently and most frequently used commands.And to all the other commands, too.
(require 'custom-auto-complete) ; TODO:set variable of 'ac-dictionary-directories' for '~\.emacs.d\lisp\dict' or other value. WASTE TIME H ; 11:38 2017/2/17
(require 'purcell-windows) ; switch-windows ; golden-ratio、window-numbering replaced by purcell-windows'. WASTE TIME M 11:36 2017/2/17
(require 'purcell-sessions) ; save a list of open files in ~/.emacs.d/.emacs.desktop or save some configs had been changed like themes/color/font and so on. 11:23 2017/1/25
;; (require 'customize-fonts)

;; (require 'purcell-editing-utils) ; undo-tree、scope-line and key-tip; dependence on diminish	11:38 2017/1/25
(require 'purcell-whitespace) ; space-block 10:37 2017/2/7

					;(require-package 'wgrep) ; 15:43 2017/1/24
					;(require-package 'project-local-variables)
					;(require-package 'diminish) ; Diminished modes are minor modes with no modeline display ;  diminish,highlight-symbol,browse-kill-ring,expand-region,avy,multiple-cursors,page-break,move-dup,whole-line-or-region,highlight-escape-sequences,popwin,guide-key
					;(require-package 'scratch) ; Mode-specific scratch buffers
					;(require-package 'mwe-log-commands) ; Add-on to log keyboard commands into a buffer. NOT NECESSARY 17:47 2017/1/24
;; (require-package 'mwe-cambridge-permute) ; Transforms text into gibberish which still can be understood amazingly well. NOT NECESSARY	17:51 2017/1/24

;;(require 'purcell-frame-hooks) not found function. ;10:27 2017/2/17
;;;(require 'purcell-xterm) ;;not found function. dependence on purcell-frame-hooks 10:38 2017/2/17

;; ------------------------------ system setting begin ------------------------------
(set-language-environment 'Chinese-GB)
(setq default-buffer-file-coding-system 'utf-8) ;Default coding system (for new files)
(prefer-coding-system 'utf-8) ; buffer新建和读取都默认是utf-8
;; (set-keyboard-coding-system 'euc-cn)
;; (set-clipboard-coding-system 'euc-cn)
;; (set-terminal-coding-system 'euc-cn)
;; (set-buffer-file-coding-system 'euc-cn)
;; (set-selection-coding-system 'euc-cn)
;; (modify-coding-system-alist 'process "*" 'euc-cn)
;; (setq default-process-coding-system
      ;; '(euc-cn . euc-cn))
;; (setq-default pathname-coding-system 'euc-cn)

;; --------------------------------- default load path
;; (setq default-directory "~/Workspaces")
(setq default-directory "E:/daily/Workspaces/")  ; must use "/" in the path, or you will see messy code.

;; ================================ custom end ==========================================

(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
