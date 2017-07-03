;; ------------------------- init-font-utils start -------------------------
;;; baohaojun.github.io/perfect-emacs-chinese-font.html  http://zhuoqiang.me/torture-emacs.html

;; ------------------------------ system setting begin ------------------------------
;; (set-language-environment 'Chinese-GB)
;; (setq default-buffer-file-coding-system 'utf-8) ;Default coding system (for new files)
;; (prefer-coding-system 'utf-8) ; buffer新建和读取都默认是utf-8

;; (set-fontset-font "fontset-default"
                  ;; 'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

;; ============================================================
;; Setting English Font
(set-face-attribute
 'default nil :font "consolas 10")
(set-fontset-font "fontset-default"
                 'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

;; Setting Chinese Font
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;             charset
;;             (font-spec :family "Microsoft Yahei" :size 14)))

;; (set-face-attribute 'default nil :font :font "consolas-10:weight=normal")
;; 这句是配置中文字体并设置中文字体的缩放比例
;; (setq face-font-rescale-alist (list (cons "Microsoft Yahei" 1.2)))

;; 这句是指定行间距
(setq-default line-spacing 1)

;; In order to adjust the font size in both English and Chinese, you need to adjust the scaling ratio, not the font size
;; (setq face-font-rescale-alist '(("Consolas" . 1.2) ("微软雅黑" . 1.2) ("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))



;; On different platforms, I need to set different scaling rate for
;; differnt font size.
(cond
 ((and (boundp '*is-a-mac*) *is-a-mac*)
  (setq chinese-font-size-scale-alist '((10.5 . 1.3) (11.5 . 1.3) (16 . 1.3) (18 . 1.25))))
 ((and (boundp '*is-a-win*) *is-a-win*)
  (setq chinese-font-size-scale-alist '((11.5 . 1.25) (16 . 1.25))))
 (t ;; is a linux
  (setq chinese-font-size-scale-alist '((16 . 1.25)))))


;; ------------------------- init-font-utils end -------------------------
(provide 'init-font-utils)
