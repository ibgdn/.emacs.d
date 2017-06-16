; (add-to-list 'load-path "~/.emacs.d/lisp/smex-master")
; (load-file "~/.emacs.d/lisp/smex-master/smex.el")
(require-package 'smex)
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay

;; ----------------------------- custom-smex start -----------------------------

;; How to modify smex so that typing a space will insert a hyphen ‘-’ like in normal M-x?
    (defadvice smex (around space-inserts-hyphen activate compile)
        (let ((ido-cannot-complete-command
            '(lambda ()
            (interactive)
            (if (string= " " (this-command-keys))
                (insert ?-)
            (funcall ,ido-cannot-complete-command)))))
			ad-do-it))

;; I install smex with the following code to make emacs startup a little faster. This delays initializing smex until it’s needed. IMO, smex should load without this hack. Just have smex call ‘smex-initialize’ when it’s needed instead of having the user do it. --LeWang
	(global-set-key [(meta x)] (lambda ()
        (interactive)
        (or (boundp 'smex-cache)
			(smex-initialize))
        (global-set-key [(meta x)] 'smex)
        (smex)))
	(global-set-key [(shift meta x)] (lambda ()
        (interactive)
        (or (boundp 'smex-cache)
			(smex-initialize))
        (global-set-key [(shift meta x)] 'smex-major-mode-commands)
        (smex-major-mode-commands)))

;; I don’t like to have smex update every time I run (auto-update is usually good enough, and is noticeably faster). But it’s annoying when I manually load a file and the new commands are not in smex. So I add a smex-update to after-load-functions.
    (defun smex-update-after-load (unused)
		(when (boundp 'smex-cache)
        (smex-update)))
    (add-hook 'after-load-functions 'smex-update-after-load)

;; You can see mnemonical commands (within completion) before the others with this code snippet:

;;; Filters ido-matches setting acronynm matches in front of the results
	(defadvice ido-set-matches-1 (after ido-smex-acronym-matches activate)
		(if (and (fboundp 'smex-already-running) (smex-already-running)
			(> (length ido-text) 1))
			(let ((regex (concat "^" (mapconcat 'char-to-string ido-text "[^-]*-")))
				(acronym-matches (list))
				(remove-regexes '("-menu-")))
        ;; Creating the list of the results to be set as first
        (dolist (item items)
			(if (string-match ido-text item) ;; exact match
				(add-to-list 'acronym-matches item)
            (if (string-match (concat regex "[^-]*$") item) ;; strict match
                (add-to-list 'acronym-matches item)
				(if (string-match regex item) ;; appending relaxed match
					(add-to-list 'acronym-matches item t)))))
	;;; comments 10 (5+5) lines otherwise "Warning (bytecomp): value returned from (reverse ad-return-value) is unused"
        ;; Filtering ad-return-value
        ; (dolist (to_remove remove-regexes)
			; (setq ad-return-value
                ; (delete-if (lambda (item)
					; (string-match to_remove item))
                    ; ad-return-value)))
        ;; Creating resulting list
        ; (setq ad-return-value
            ; (append acronym-matches
				; ad-return-value))
        ; (delete-dups ad-return-value)
        ; (reverse ad-return-value)
		)))


;; ------------------------------ it is come from purcell's init-smex
	(when (maybe-require-package 'smex)
		;; Change path for ~/.smex-items
		(setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
		(global-set-key [remap execute-extended-command] 'smex))
;; ------------------------------ custom-smex end ------------------------------

(provide 'custom-smex)
