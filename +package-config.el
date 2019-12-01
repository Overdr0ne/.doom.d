;;; ~/.doom.d/+package-config.el -*- lexical-binding: t; -*-

(use-package! dts-mode)

(use-package! lsp-mode :commands lsp)
(use-package! lsp-ui :commands lsp-ui-mode)
(use-package! company-lsp :commands company-lsp)

(use-package! ccls
  :init
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp))

(use-package! company
  :config
  (add-to-list 'company-backends 'company-files))
(use-package! yasnippet
  :config
  (yas-global-mode))

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

(use-package! projectile
  :config
  (add-to-list 'projectile-globally-ignored-directories "build"))

(use-package! multiple-cursors)

(use-package! cyberpunk-2019-theme
  :config
  (load-theme 'cyberpunk-2019 t)
  )

(use-package! cider)

(use-package! sclang-extensions)
(use-package! sclang-snippets)

(use-package! w3m)

;; (use-package! lsp
;;   :config
;;   (setq lsp-ui-doc-enable t))
