; (add-to-list 'load-path "~/.emacs.d/lisp/auto-complete")
	(require-package 'auto-complete)
	(require 'auto-complete-config)
	;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/dict")
	;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete-master/ac-dict")
	(ac-config-default)

;; ------------------------- custom-auto-complete start -------------------------

;; 把自定义的dict加到auto-complete的字典中去
	(add-to-list 'ac-dictionary-directories (expand-file-name "lisp/dicts" user-emacs-directory))
;; 按下TAB时首先缩进所在行，然后尝试补全
	(setq tab-always-indent 'complete)
;; 阻止自动触发补全动作
	(setq-default ac-expand-on-auto-complete nil)
	(setq-default ac-auto-start nil)
;; 用TAB作为手动触发补全动作的快捷键
	(ac-set-trigger-key "TAB")

;; 一个是与linum共用时，每当出现补全菜单，linum会更新(增加)行号，虽不影响使用但很不美观而且晃眼，解决办法如下：
	(defun ac-linum-workaround ()
		"linum-mode tries to display the line numbers even for the completion menu. This workaround stops that annoying behavior."
		(interactive)
		(defadvice linum-update (around ac-linum-update-workaround activate)
			(unless ac-completing ad-do-it)))
	(ac-linum-workaround) ;开启linum时调用
;; 另一个问题是当(setq ac-auto-start nil)，手动启动auto-complete出现补全菜单时会开住(无法上/下移动选择补全项)，没找到具体原因，反复尝试后加入如下设置可以解决之：
	; (setq ac-expand-on-auto-complete nil)

;;添加ac补全源
	(set-default 'ac-sources
		'(ac-source-semantic ;;ac使用semantic的分析结果
			ac-source-yasnippet
			ac-source-abbrev
			ac-source-words-in-buffer
			ac-source-words-in-all-buffer
			ac-source-words-in-same-mode-buffers
			ac-source-functions
			ac-source-imenu
			ac-source-files-in-current-dir
			ac-source-filename))

	(setq ac-use-quick-help nil)
	(setq ac-auto-start 2) ;; 输入2个字符才开始补全
	(global-set-key "\M-/" 'auto-complete)  ;; 补全的快捷键，用于需要提前补全
	; (setq ac-auto-show-menu 0.8) ;; Show menu 0.8 second later
	(setq ac-use-menu-map t) ;; 选择菜单项的快捷键
	(define-key ac-menu-map "\C-n" 'ac-next)
	(define-key ac-menu-map "\C-p" 'ac-previous)
	; (setq ac-menu-height 12) ;; menu设置为12 lines

;; -------------------------- custom-auto-complete end --------------------------

(provide 'custom-auto-complete)
