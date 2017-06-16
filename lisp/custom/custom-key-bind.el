;; ------------------------- custom-key-bind start -------------------------

;; C-return --------------------------------
;; Set-mark, Key-binding: C-return.
;; C-SPACE 被输入法占用，C-@ 又太难按，于是把 set mark 绑定到 C-return
(define-key global-map [C-return] 'set-mark-command)


;; C-cm --------------------------------
;; Emacs has a function that moves the cursor to the current line of the line (the move - begining-of-line) and the line-end-of-line, but does not move the function in the middle of the current line
;; (暂未绑定快捷键) emacs里有将光标移动到当前行的行头(move-beginning-of-line)和行尾(move-end-of-line)的函数,但没有移动到当前行中间的函数
(defun move-middle-of-line ()
  "Move point to the middle of line current displayed"
  (interactive)
  (message "move to middle of line, cur=%d." (current-column))
  (end-of-line)
  (backward-char (/ (current-column) 2)))
(global-set-key "\C-cm" 'move-middle-of-line)


;; S-5 or % --------------------------------
;; press '%' will point the other paren, otherwise insert '%'.	11:09 2017/1/24
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)

;; C-xd --------------------------------
;; Insert-current-date
(defun insert-current-date ()
  "Insert the current date"
  (interactive "*")
  ;;(insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))))
  (insert (format-time-string "%Y/%m/%d" (current-time))))
(global-set-key "\C-xd" 'insert-current-date)

;; C-xt --------------------------------
;; Insert-current-time
(defun insert-current-time ()
  "Insert the current time"
  (interactive "*")
  ;;(insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))))
  (insert (format-time-string "%H:%M:%S" (current-time))))
(global-set-key "\C-xt" 'insert-current-time)


;; C-M-\ --------------------------------
;; Formatting region codes, Key-binding: Ctrl-Alt-\ , F7 is also work.
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode
                     lisp-mode
                     clojure-mode
                     scheme-mode
                     ;; haskell-mode
                     ;; ruby-mode
                     ;; rspec-mode
                     python-mode
                     ;; c-mode
                     java-mode
                     ;; c++-mode
                     ;; objc-mode
                     latex-mode
                     js-mode
                     js2-mode
                     js3-mode
                     html-mode
                     css-mode
		     sql-mode
                     plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

;; F7 --------------------------------
;; Formatting the whole file.
(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))
;; Key-binding: F7.
(global-set-key [f7] 'indent-whole)


;; C-w --------------------------------
;; When you do not select an area, the c-w will cut the cursor, no matter where the cursor is located. When using M - w, the cursor is copied, regardless of whether the cursor is at the top or the end of the line. When you have a selected area, the functions of c-w and m-w are the same as those of Emacs.
;; 当你没有选中一个区域的时候，C-w 会剪切光标所在行，不管光标的位置在哪里；而用 M-w 的时候，则会复制光标所在的行，不管光标的位置在行首还是行尾还是行中间的任意位置。当你有选中区域的时候，C-w 和 M-w 的功能和 Emacs 自带的没啥两样。
(defadvice kill-ring-save (before slickcopy activate compile)
                                        ; "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
                                        ; "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))


;; M-; --------------------------------
;; Emacs's default setting, M -; It can be annotated, but it is inconvenient: you must be able to annotate a portion of the area. With the following configuration, you can achieve the following effect: when the cursor is at the end of the line, M -; Comment at the end of the line; When the cursor is located in another location, M -; To comment on the role of the bank; In part of the election, M -; To comment on the role of the region.
;; Emacs的默认设置中，M-;可以起到注释的作用，但是有不方便的地方：必须在选中一部分区域后才能进行注释。通过如下配置，可以达到以下效果：当光标位于行尾时，M-;在行尾进行注释；当光标位于其他位置时，M-;起到注释该行的作用；当选中一部分区域时，M-;起到注释该区域的作用。
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.If no region is selected and current line is not blank and we are not at the end of the line,then comment current line.Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)


;; M-k --------------------------------
;; 把 Alt-k 设成复制光标所在处到行尾。与 kill-line 的 Ctrl-k 对应。这样一来，如果是要拷贝一整行的话，只要将光标移动到该行任意位置，按下 Alt-w 就行了。如果是复制某个位置到行尾的文字的话，就把光标移到起始位置处，按 Alt-k 。
;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))


(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-k") 'qiang-copy-line)



;; ------------------------- custom-key-bind end -------------------------

(provide 'custom-key-bind)
