(load! "+autoload")
(load! "+base")
(load! "+bindings")

(set-frame-parameter (selected-frame) 'alpha '(93 . 70))
(add-to-list 'default-frame-alist '(alpha . (93 . 70)))

(defun +default|disable-delete-selection-mode ()
  (delete-selection-mode -1))
(add-hook 'evil-insert-state-entry-hook #'delete-selection-mode)
(add-hook 'evil-insert-state-exit-hook  #'+default|disable-delete-selection-mode)

(setq tags-add-tables nil)
(setq large-file-warning-threshold nil)
(set-face-attribute 'default nil :height 140)
(setq doom-font (font-spec :family "fira mono" :size 18))
(setq display-line-numbers-type nil)

(evil-commentary-mode)

(load! "+package-config")
