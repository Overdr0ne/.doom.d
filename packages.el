;; -*- no-byte-compile: t; -*-
;;; config/default/packages.el

(package! avy)
(package! ace-link)
;; (package! ecb)
;; (package! ecb :recipe (:fetcher github :repo "ecb-home/ecb"))
;; (package! speedbar-projectile)
(package! dts-mode)
(package! ctags-update)
(package! taglist)
(package! sr-speedbar)
(package! irony)
(package! rtags)
(package! xcscope)
(package! company-irony)

(unless (featurep! :editor evil)
  (package! expand-region))
