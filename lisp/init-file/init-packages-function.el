;; ------------------------- init-packages-function start -------------------------

;; It's like purcell's init-elpa.el
;; defun after-load/require-package/maybe-require-package

;; If gpg cannot be found, signature checking will fail, so we
;; conditionally enable it according to whether gpg is available. We
;; re-run this check once $PATH has been configured
(defun sanityinc/package-maybe-enable-signatures ()
  (setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)))

(sanityinc/package-maybe-enable-signatures)
(after-load 'init-exec-path
	    (sanityinc/package-maybe-enable-signatures))



;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install package `%s': %S" package err)
     nil)))


;;; Fire up package.el

(setq package-enable-at-startup nil)
(package-initialize)



(require-package 'fullframe)
(fullframe list-packages quit-window)


(require-package 'cl-lib)
(require 'cl-lib)

(defun sanityinc/set-tabulated-list-column-width (col-name width)
  "Set any column with name COL-NAME to the given WIDTH."
  (when (> width (length col-name))
    (cl-loop for column across tabulated-list-format
             when (string= col-name (car column))
             do (setf (elt column 1) width))))

(defun sanityinc/maybe-widen-package-menu-columns ()
  "Widen some columns of the package menu table to avoid truncation."
  (when (boundp 'tabulated-list-format)
    (sanityinc/set-tabulated-list-column-width "Version" 13)
    (let ((longest-archive-name (apply 'max (mapcar 'length (mapcar 'car package-archives)))))
      (sanityinc/set-tabulated-list-column-width "Archive" longest-archive-name))))

(add-hook 'package-menu-mode-hook 'sanityinc/maybe-widen-package-menu-columns)

;; ------------------------- init-packages-function end -------------------------
(provide 'init-packages-function)