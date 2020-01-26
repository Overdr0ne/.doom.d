;;; ~/.doom.d/+use-package.el -*- lexical-binding: t; -*-

(use-package! dts-mode)

(use-package! lsp-mode :commands lsp)
(use-package! lsp-ui :commands lsp-ui-mode)
(use-package! company-lsp :commands company-lsp)
(use-package! lsp-ivy)

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

(use-package! multiple-cursors)

(use-package! cider)

;; sclang installed with emacs on arch
(use-package! sclang)
(setq sclang-help-path '("/home/sam/.local/share/SuperCollider/Help"))
(use-package! sclang-extensions)
(use-package! sclang-snippets)

(use-package! w3m)

(use-package! interaction-log)

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
  :config
  (lispyville-set-key-theme
   '(operators
     c-w
     additional-insert
     lispyville-slurp
     lispyville-barf)))

(use-package! systemd)
(use-package! helm-systemd)

(use-package! dired+
  :init
  (setq diredp-hide-details-initially-flag nil))
(use-package! all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook
            'all-the-icons-dired-mode
            'append))
;; (use-package! dired-rainbow
;;   :config
;;   (progn
;;     (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
;;     (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
;;     (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
;;     (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
;;     (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
;;     (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
;;     (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
;;     (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
;;     (dired-rainbow-define log "#c17d11" ("log"))
;;     (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
;;     (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
;;     (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
;;     (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
;;     (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
;;     (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
;;     (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
;;     (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
;;     (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
;;     (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
;;     (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
;;     ))
;; (use-package! ranger
;;   :config
;;   (setq ranger-override-dired-mode t)
;;   (setq ranger-cleanup-eagerly t)
;;   (setq ranger-cleanup-on-disable nil))

