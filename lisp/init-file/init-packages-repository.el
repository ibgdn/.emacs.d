;; ------------------------- init-packages-repository start -------------------------
;; It's like purcell's init-elpa.el

;;; Find and load the correct package.el

;; When switching between Emacs 23 and 24, we always use the bundled package.el in Emacs 24
(let ((package-el-site-lisp-dir
       (expand-file-name "site-lisp/" user-emacs-directory)))
  (when (and (file-directory-p package-el-site-lisp-dir)
             (> emacs-major-version 23))
    (message "Removing local package.el from load-path to avoid shadowing bundled version. custom-packages-repository.el")
    (setq load-path (remove package-el-site-lisp-dir load-path))))

(require 'package)

;;; Standard packages repositories
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)

(when (< emacs-major-version 24)
  ;; Mainly for ruby-mode	15:24 2017/1/24
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))

;; We include the org repository for completeness, but don't normally use it.	15:22 2017/1/24
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(when (< emacs-major-version 24)	; 15:25 2017/1/24
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Also use Melpa for most packages	15:27 2017/1/24
(add-to-list 'package-archives `("melpa" . ,(if (< emacs-major-version 24)
						"http://melpa.org/packages/"
					      "https://melpa.org/packages/")))


;; NOTE: In case of MELPA problems, the official mirror URL is
;; https://www.mirrorservice.org/sites/stable.melpa.org/packages/

;; ------------------------- init-packages-repository end -------------------------

(provide 'init-packages-repository)
