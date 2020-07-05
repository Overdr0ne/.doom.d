(load! "+base")
(load! "+use-package")
(load! "+bindings")

(set-frame-parameter (selected-frame) 'alpha '(93 . 70))
(add-to-list 'default-frame-alist '(alpha . (93 . 70)))

(defun +default|disable-delete-selection-mode ()
	(delete-selection-mode -1))
(add-hook 'evil-insert-state-entry-hook #'delete-selection-mode)
(add-hook 'evil-insert-state-exit-hook  #'+default|disable-delete-selection-mode)

(setq org-directory "~/notes")
(setq org-agenda-files '("~/notes"))

(setq tags-add-tables nil)
(setq large-file-warning-threshold nil)
(set-face-attribute 'default nil :height 140)
(setq doom-font (font-spec :family "Fira Code" :size 18))
;; (setq doom-font (font-spec :family "Iosevka" :size 18))
(setq display-line-numbers-type nil)
(setq user-mail-address "scmorris.dev@gmail.com")
(turn-off-auto-fill)
(auto-fill-mode -1)
(remove-hook 'text-mode-hook 'auto-fill-mode)
(remove-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

(setq browse-url-browser-function 'eww-browse-url)
;; (add-hook 'eww-mode-hook
;;           (lambda () (load-theme-buffer-local 'plan9 (current-buffer))))

(setq show-trailing-whitespace t)

(setq load-prefer-newer t)

;; don't hide certain astrisked buffers
;; (delete 'doom-special-buffer-p doom-unreal-buffer-functions)
;; (defun test-buf-p ()
;;  (when (buffer-file-name) (string= (file-name-base (buffer-file-name)) "config")))
;; (setq doom-unreal-buffer-functions '(test-buf-p))
(add-hook! '(helpful-mode-hook Info-mode-hook term-mode-hook comint-mode-hook help-mode-hook profiler-report-mode-hook) #'doom-mark-buffer-as-real-h)

(add-hook! (emacs-lisp-mode) #'(lambda () (add-to-list (make-local-variable 'company-backends) 'company-elisp)))
(add-hook 'emacs-lisp-mode-hook #'(lambda () (add-to-list (make-local-variable 'company-backends) 'company-elisp)))
(add-hook 'emacs-lisp-mode-hook #'(lambda () (rainbow-delimiters-mode)))

(setq company-idle-delay 1)
