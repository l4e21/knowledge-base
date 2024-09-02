(setq debug-on-error nil)
(setq split-width-threshold 1) ;; Vertical split by default pls

;; Initialization of packages
 
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
 
(package-initialize)
(package-refresh-contents)
 
;; ;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (require 'use-package))
 
(setq use-package-always-defer t)
 
(display-battery-mode t)
(global-display-line-numbers-mode t)
 
;;  ;;; This fixed garbage collection, makes emacs start up faster ; ; ; ; ; ; ;
 
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
 
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
 
(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))
 
(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
	gc-cons-percentage 0.1))
 
(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
 
;; ;; Get rid of gross stuff
 
(if (boundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (boundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
 
(display-line-numbers-mode nil)
(column-number-mode nil)
(set-face-attribute 'default nil :height 180)
(set-face-attribute 'line-number-current-line nil :background "#3B4252")
(set-face-attribute 'line-number-current-line nil :foreground "#81A1C1")
 
;; ;;
;; ;; MOUSE STUFF
;; ;;
 
(setq scroll-preserve-screen-position 1)
 
;; ;; Use spaces, not tabs.
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
 
;; ;; Start a server upon startup
(server-start)
 
;; ;; 
;; ;;MODELINE
;; ;; 
 
(use-package doom-modeline
  :ensure t
  :defer nil
  :config
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-height 0.5)
  (doom-modeline-mode 1))

(use-package which-key
  :ensure t
  :defer nil
  :config
  (which-key-mode 1))
 
(use-package nyan-mode
  :ensure t
  :defer nil
  :config
  (setq nyan-animate-nyancat t)
  (setq nyan-wavy-trail t)
  (nyan-mode 1))
 
;; ;; 
;; ;; VISUALS
;; ;;
 
 
(use-package rainbow-delimiters
  :defer nil
  :ensure t
  :config
  (rainbow-delimiters-mode 1))
 
(load-theme 'doom-material-dark t)
(doom-themes-visual-bell-config)
(global-prettify-symbols-mode +1)
 
;; ;; 
;; ;; IVY
;; ;;
 
(use-package ivy
  :defer nil
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))
 
(use-package ivy-posframe
  :after (:all ivy)
  :defer nil
  :ensure t
  :config
  (ivy-posframe-mode t)
  (ivy-posframe-display-at-frame-center t))
 
 
;; ;; 
;; ;; COMMON LISP AND CLOJURE
;; ;; 
 
(setq inferior-lisp-program "sbcl")
(add-to-list 'slime-contribs 'slime-repl)
 
 
;; ;; ADJUST PARENS
 
(use-package paredit
  :ensure t
  :defer nil)
 
(use-package lispy
  :ensure t
  :defer nil)
 
(use-package flycheck
  :ensure t)
 
(use-package company
  :ensure t)
 
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))
 
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
 
 
(add-to-list 'load-path "")
 
(use-package cider
  :ensure t)
 
(use-package lsp-treemacs
  :ensure t)
 
(use-package lsp-mode
  :ensure t)

(use-package flycheck-clj-kondo
  :ensure t)
 
 
(add-hook 'clojure-mode-hook (lambda ()
                               (lsp)
                               (cider-mode 1)
                               (lispy-mode 1)
                               (paredit-mode 1)
                               (rainbow-delimiters-mode 1)))


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil
      lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
      ;; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
      )

;; ;;
;; ;; JS/TS
;; ;;
 
;; (require 'web-mode)
;; (require 'typescript-mode)
 
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (flycheck-add-next-checker 'typescript-tide '(warning . javascript-eslint) 'append)
;;   (setq flycheck-check-syntax-automatically '(save-mode-enabled))
;;   (setq typescript-indent-level 2)
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   (company-mode +1)
;;   (electric-pair-mode +1))
 
;; (setq company-tooltip-align-annotations t)
 
;; (defun eslint-fix-file ()
;;   (interactive)
;;   (message "eslint --fix the file" (buffer-file-name))
;;   (call-process-shell-command
;;    (concat "yarn eslint --fix " (buffer-file-name))
;;    nil "*Shell Command Output*" t)
;;   (revert-buffer t t))
 
;; (add-hook 'web-mode-hook #'setup-tide-mode)
;; ;; (add-hook 'before-save-hook #'eslint-fix-file)
;; (setq web-mode-markup-indent-offset 2
;;       web-mode-css-indent-offset 2
;;       web-mode-code-indent-offset 2
;;       web-mode-block-padding 2
;;       web-mode-comment-style 2
 
;;       web-mode-enable-css-colorization t
;;       web-mode-enable-auto-pairing t
;;       web-mode-enable-comment-keywords t
;;       web-mode-enable-current-element-highlight t
;;       )
 
;; (add-hook 'web-mode-hook
;;           (lambda () (pcase (file-name-extension "tsx") (typescript-mode))))
 
;; ;; 
;; ;; SHELL, KEYS AND INIT PROGRAMS
;; ;;
 
(defun efs/display-start-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
	           (float-time
	            (time-subtract after-init-time before-init-time)))
           gcs-done))
 
;; (setq-default explicit-shell-file-name "/bin/bash")
 
(add-hook 'after-init-hook (lambda ()
                             (shell)
			     (delete-other-windows)
			     (interactive)
			     (start-process-shell-command "xinput --set-prop 12 'libinput Accel Speed' 0.8" nil "xinput --set-prop 12 'libinput Accel Speed' 0.8")
			     (efs/display-start-time)
			     (global-prettify-symbols-mode +1)))
 
(add-hook 'shell-mode-hook (lambda ()
			     display-line-numbers-mode 0))
 

;; ;; 
;; ;; BACKUPS
;; ;;

(setq backup-directory-alist `(("." . "~/.saves")))
 
(setq backup-by-copying t)
 
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
 
(setq create-lockfiles nil)
 
(use-package erc-goodies
  :defer nil :after erc
  :config
  (setq erc-interpret-mirc-color t)
  (setq erc-controls-highlight-regexp
        (concat
         "\\(\\|\\|\\|\x1e\\|\\|\\|\\|\\|"
         "\\([0-9][0-9]?\\)?\\(,\\([0-9][0-9]?\\)\\)?\\)"
         "\\([^\x1e]*\\)")))
 
 
 
 
 
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(latex-preview-pane emojify unicode-emoticons alchemist eradio evil kotlin-mode vagrant-tramp cider yaml-mode yaml which-key wgrep web-mode use-package tide terraform-mode smartparens slime rainbow-delimiters paredit nyan-mode magit lsp-treemacs lispy ivy-posframe impatient-mode grip-mode graphql-mode flymake-flycheck flycheck-clj-kondo ediprolog doom-themes doom-modeline docker company)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package tide :ensure t)
(use-package company :ensure t)
(use-package flycheck :ensure t)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (eldoc-mode)
  (tide-hl-identifier-mode +1)
  (setq web-mode-enable-auto-quoting nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-attr-value-indent-offset 2))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

  ;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'typescript-mode-hook #'rainbow-delimiters-mode)


(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (progn
                (setup-tide-mode)
                (typescript-mode)))))

(add-hook 'web-mode-hook #'turn-on-smartparens-mode t)

;; enable typescript - tslint checker
;; (flycheck-add-mode 'typescript-tslint 'web-mode)


;; (setq cider-clojure-cli-global-options "-A:dev:test:scripts")

;; (define-key paredit-mode-map (kbd "RET") nil)
;; (define-key paredit-mode-map (kbd "C-j") 'paredit-newline)

;; Acl2 mode
(load "~/common-lisp/acl2/emacs/emacs-acl2.el")



;;
;; ORG
;;

(require 'ob)
(require 'ob-ref)
(require 'comint)
(require 'ob-comint)
(require 'ob-eval)

(defvar org-babel-default-header-args:acl2 '())

(defun org-babel-expand-body:acl2 (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  (require 'inf-template nil t)
  (let ((vars (org-babel--get-vars (or processed-params (org-babel-process-params params)))))
    (concat
     (mapconcat ;; define any variables
      (lambda (pair)
        (format "%s=%S"
                (car pair) (org-babel-template-var-to-template (cdr pair))))
      vars "\n")
     "\n" body "\n")))

;; specified by the user will be available in the PARAMS variable.
(defun org-babel-execute:acl2 (body params)
  "Execute a block of Template code with org-babel.
This function is called by `org-babel-execute-src-block'"
  (message "executing Template source code block")
  (let* ((processed-params (org-babel-process-params params))
         ;; set the session if the value of the session keyword is not the
         ;; string `none'
         (session (org-babel-template-initiate-session
                   (cdr (assq :session processed-params))))
         ;; variables assigned for use in the block
         (vars (org-babel--get-vars processed-params))
         (result-params (assq :result-params processed-params))
         ;; either OUTPUT or VALUE which should behave as described above
         (result-type (assq :result-type processed-params))
         ;; expand the body with `org-babel-expand-body:acl2'
         (full-body (org-babel-expand-body:acl2
                     body params processed-params)))

    (let* ((buffer (get-buffer-create "*acl2-babel*"))
           (acl2-process (make-comint-in-buffer "ACL2" buffer "~/common-lisp/acl2/saved_acl2" nil)))

      (org-babel-comint-in-buffer buffer
        ;; Wait for process to initialise
        (while (progn (goto-char (point-min))
                      (not (search-forward-regexp "ACL2 !>" nil t)))
          (accept-process-output (get-buffer-process buffer)))
        (goto-char (process-mark (get-buffer-process buffer)))
        (insert body)
        (comint-send-input)
        ;; Wait for process to end
        (while (progn
                 (goto-char comint-last-input-end)
                 (not (search-forward-regexp "ACL2 !>" nil t)))
          (accept-process-output (get-buffer-process buffer)))

        ;; Retrieve output between last input and current point
        (buffer-substring (+ 1 comint-last-input-end) (- (point-max) 7))))
    ))

(defun org-babel-template-initiate-session (&optional session)
  "If there is not a current inferior-process-buffer in SESSION then create.
Return the initialized session."
  (unless (string= session "none")
    ))

(setf org-support-shift-select t)
