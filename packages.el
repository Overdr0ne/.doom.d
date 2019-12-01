;; -*- no-byte-compile: t; -*-
;;; config/default/packages.el

(package! avy)
(package! ace-link)
(package! dts-mode)
(package! ctags-update)
(package! sr-speedbar)
(package! evil-commentary)
(package! xcscope)
(package! phpactor)
(package! yasnippet)
(package! yasnippet-snippets)
(package! multi-compile)
(package! browse-kill-ring)
(package! clipmon)
(package! cider)
(package! sclang-extensions)
(package! sclang-snippets)
(package! w3m)
(package! dired-imenu)
(package! cyberpunk-2019-theme)

(package! lsp-mode)
(package! lsp-ui)
(package! company-lsp)

(unless (featurep! :editor evil)
  (package! expand-region))
