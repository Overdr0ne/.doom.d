;;; ~/.doom.d/+use-package.el -*- lexical-binding: t; -*-

;; (use-package! company)
;; (use-package! company-box)

;; (use-package! counsel-dash)
;; (use-package! counsel-projectile)

;; (use-package! all-the-icons-ivy)
;; (use-package! ivy-hydra)
;; (use-package! ivy-rich)
;; (use-package! ivy-xref)
;; (use-package! posframe)
;; (use-package! ivy-posframe)
;; (use-package! amx)

;; (use-package! wgrep)

;; (use-package! anzu)
;; (use-package! evil-anzu)
;; (use-package! doom-modeline)
;; (use-package! shrink-path)

(use-package! dts-mode)

(use-package! lsp-mode :commands lsp)
(use-package! lsp-ui :commands lsp-ui-mode)
;; (use-package! company)
(use-package! company-lsp :commands company-lsp)
(use-package! lsp-ivy)

(use-package! ccls
  :init
  (add-hook 'elisp-mode-hook 'lsp)
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp))

(use-package! yasnippet
  :config
  (yas-global-mode))

(use-package! company
  :config
  (add-to-list 'company-backends 'company-files 'company-yasnippet)
  (load! "company-minibuffer"))

;; (use-package! multi-compile)
(use-package! multi-compile
  :config
  (setq multi-compile-alist '(
	  (c-mode . (("build" . "gcc -g *.c"))))))

(use-package! browse-kill-ring)
(use-package! clipmon
  :init
  (clipmon-mode-start)
  )

(use-package! multiple-cursors)

(use-package! cider)

;; sclang installed with emacs on arch
(use-package! sclang)
(setq sclang-help-path '("/home/sam/.local/share/SuperCollider/Help"))
(use-package! sclang-extensions)
(use-package! sclang-snippets)

(use-package! w3m)

(use-package! interaction-log)

(use-package! evil-commentary
  :config
  (evil-commentary-mode))

(use-package! evil-snipe
  :config
  (push 'ibuffer-mode evil-snipe-disabled-modes))

(use-package! projectile
  :config
  (add-to-list 'projectile-globally-ignored-directories "build")
  (defun sam-projectile-ibuffer-by-project (project-root)
	"Open an IBuffer window showing all buffers in PROJECT-ROOT."
	(let ((project-name (funcall projectile-project-name-function project-root)))
	  (ibuffer t (format "*%s Buffers*" project-name)
			   (list (cons 'projectile-files project-root)) nil t)))

  (defun sam-projectile-ibuffer (prompt-for-project)
	"Open an IBuffer window showing all buffers in the current project.

Let user choose another project when PROMPT-FOR-PROJECT is supplied."
	(interactive "P")
	(let ((project-root (if prompt-for-project
							(projectile-completing-read
							 "Project name: "
							 (projectile-relevant-known-projects))
						  (projectile-project-root))))

	(sam-projectile-ibuffer-by-project project-root))))

(use-package! persp-mode
  :config
  (define-ibuffer-filter persp-files
	  "show ibuffer with buffers in current perspective"
	(:reader nil :description nil)
	(memq buf (persp-buffer-list)))

  (defun persp-ibuffer ()
	(interactive)
	(ibuffer t (format "*%s persp buffers" (persp-name (get-current-persp)))
			 (list (cons 'persp-files ())) nil t))
  (setq wg-morph-on nil) ;; switch off animation
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

(use-package! persp-projectile
  :config
  (setq projectile-switch-project-action #'projectile-vc))

(use-package! visual-fill-column)

(use-package! helm-recoll)

(use-package! find-file-in-project)

(use-package! org-ref)
(use-package! org-roam
  :init
  (setq org-roam-directory "~/notes")
  (add-hook 'after-init-hook 'org-roam-mode))

(use-package! bookmark+)

(use-package! system-packages)
(use-package! helm-system-packages)
;; (use-package! arch-packer)

(use-package! web-search)

(use-package! load-theme-buffer-local)
;; (use-package! nofrils-acme-theme)
;; (use-package! plan9-theme)

(use-package! cyberpunk-2019-theme
  :config
  (load-theme 'cyberpunk-2019 t))

(use-package! evil-cleverparens)

(use-package! lispyville
  :init
  (general-add-hook '(emacs-lisp-mode-hook lisp-mode-hook) #'lispyville-mode)
  (add-hook 'emacs-lisp-mode-hook #'lispyville-mode)
  :config
  (lispyville-set-key-theme
   '(operators
	 c-w
	 additional-insert
	 lispyville-slurp
	 lispyville-barf)))

(use-package! systemd)
(use-package! helm-systemd)

(use-package! dired-rainbow)
(use-package! all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook
			'all-the-icons-dired-mode
			'append))
(use-package! dired-ranger)
(use-package! dired-filter)
(use-package! dired+
  :init
  (setq diredp-hide-details-initially-flag nil))
(use-package! highlight)

;;(use-package! wuxch-dired-copy-paste)
;; (use-package! ranger
;;   :config
;;   (setq ranger-override-dired-mode t)
;;   (setq ranger-cleanup-eagerly t)
;;   (setq ranger-cleanup-on-disable nil))

(use-package! smart-tabs-mode
  :config
  (smart-tabs-insinuate 'c 'python))

(use-package! deft
  :config
  (add-to-list 'evil-insert-state-modes 'deft-mode)
  (setq deft-directory "~/notes"))

(use-package! auto-compile
  :init
  (setq load-prefer-newer t)
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package! all-the-icons-ibuffer
  :config
  (all-the-icons-ibuffer-mode))

(use-package! rcirc
  :config
  (rcirc-track-minor-mode t)
  (add-hook 'rcirc-mode-hook (lambda ()
							   (flyspell-mode 1)
							   (rcirc-omit-mode)
							   ))
  (setq rcirc-server-alist
		'(("irc.freenode.net" :channels ("#emacs" "#rcirc"))))
  (setq rcirc-authinfo
		(quote
		 (("irc.freenode.net" nickserv "USERNAME" "PASSWORD"))))
  (setq rcirc-buffer-maximum-lines 1000)
  (setq rcirc-default-nick "DEFAULTNICK")
  (setq rcirc-default-user-name "DEFAULTUSERNAME")
  (setq rcirc-log-flag t))

(use-package! explain-pause-mode)

(use-package! daemons)

;; (use-package! pretty-mode
;;   :config
;;   (global-pretty-mode t)
;;   (pretty-deactivate-groups
;;    '(:equality :ordering :ordering-double :ordering-triple
;; 			   :arrows :arrows-twoheaded :punctuation
;; 			   :logic :sets))
;;   (pretty-activate-groups
;;    '(:sub-and-superscripts :greek :arithmetic-nary)))

(use-package! names)
