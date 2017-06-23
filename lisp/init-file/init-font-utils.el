;; ------------------------- init-font-utils start -------------------------
;;; baohaojun.github.io/perfect-emacs-chinese-font.html  http://zhuoqiang.me/torture-emacs.html


;; In order to adjust the font size in both English and Chinese, you need to adjust the scaling ratio, not the font size
(setq face-font-rescale-alist '(("Consolas" . 1.2) ("微软雅黑" . 1.2) ("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))



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
