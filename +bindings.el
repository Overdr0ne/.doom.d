;;; config/default/+bindings.el -*- lexical-binding: t; -*-

;; This file defines a Spacemacs-esque keybinding scheme

;; Don't let evil-collection interfere with certain keys
(setq evil-collection-key-blacklist
      (list "gd" "gf" "K" "[" "]" "gz" "<escape>"
            doom-leader-key doom-localleader-key
            doom-leader-alt-key doom-localleader-alt-key))

;; (defadvice! +default-evil-collection-disable-blacklist-a (orig-fn)
;;   :around #'evil-collection-vterm-toggle-send-escape  ; allow binding to ESC
;;   (let (evil-collection-key-blacklist)
;;     (apply orig-fn)))

(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "M-p") 'term-primary-yank)))

;; (evil-define-key '(normal insert) lispyville-mode-map
;;   (kbd "M-(") 'lispy-wrap-round
;;   (kbd "M-[") 'lispy-wrap-brackets
;;   (kbd "M-{") 'lispy-wrap-braces
;;   (kbd "C-)") 'lispy-forward-slurp-sexp
;;   (kbd "A-)") 'lispy-forward-barf-sexp
;;   (kbd "C-(") 'lispy-backward-slurp-sexp
;;   (kbd "A-(") 'lispy-backward-barf-sexp
;;   (kbd "A-j") 'evil-scroll-line-down
;;   (kbd "A-k") 'evil-scroll-line-up)

;; (general-define-key
;;  :states 'normal
;;  :keymaps 'Info-mode-map
;;  )

(general-define-key
 :states 'normal
 "C-e" #'+eval-this-sexp
 )

(defun swap-num-keys ()
  (general-define-key
   :states '(normal visual)
   "1" #'rotate-text
   "2" #'evil-execute-macro
   "3" #'evil-ex-search-word-backward
   "4" #'evil-end-of-line
   "5" #'evil-jump-item
   "6" #'evil-first-non-blank
   "7" #'evil-ex-repeat-substitute
   "8" #'evil-ex-search-word-forward
   "9" #'evil-backward-sentence-begin
   "0" #'evil-forward-sentence-begin
   )
  (general-define-key
   :states 'normal
   :keymaps 'evil-cleverparens-mode-map
   "9" #'evil-cp-backward-up-sexp
   "0" #'evil-cp-up-sexp
   )
  )
(swap-num-keys)

;;
;;; Global keybindings
(map!
 (:map override
  "A-b"  #'persp-ibuffer
  "A-p"  #'sam-projectile-ibuffer
  ;; A little sandbox to run code in
  "C-w" #'evil-window-left
  "M-j" 'evil-scroll-line-down
  "M-k" 'evil-scroll-line-up
  "A-j" 'evil-scroll-line-down
  "A-k" 'evil-scroll-line-up
  "A-s" #'shell-command)

 "A-;" #'eval-expression
 "M-;" #'eval-expression
 :v    "C-e" #'eval-region
 :n    "C-u"    #'universal-argument
 ;; :nv [return] #'evil-commentary-line

 (:map evil-normal-state-map
  ;; ")"   #'evil-digit-argument-or-evil-beginning-of-line
  "j"   #'evil-next-visual-line
  "J"   #'evil-jump-item
  "k"   #'evil-previous-visual-line
  "-"   #'neotree
  "`"   #'sr-speedbar-toggle
  "C-d" #'dired-jump
  "C-/" #'counsel-grep-or-swiper
  ;; "C-;" #'evil-commentary-line
  ;; "C-m" #'evil-commentary-line
  "C-]" #'+lookup/definition
  "M-]" #'+lookup/references
  "C"   #'+multiple-cursors/evil-mc-toggle-cursors
  "C-k" #'insert-line-above
  "C-j" #'insert-line-below
  "A-k" #'evil-scroll-line-up
  "A-j" #'evil-scroll-line-down
  "A-w" #'window-configuration-to-register
  "A-e" #'jump-to-register
  "<mouse-2>" #'evil-paste-after
  ;; "A-1" #'(lambda () (interactive) (window-configuration-to-register 1))
  ;; (defmacro create-j2r-keybinding (reg)
  ;;   `(,(concat "A-" (number-to-string reg))
  ;;     #'(lambda () (interactive) (jump-to-register ,reg))))
  ;; (create-j2r-keybinding 4)
  "A-!" #'(lambda () (interactive) (jump-to-register 1))
  "A-1" #'(lambda () (interactive) (window-configuration-to-register 1))
  "A-@" #'(lambda () (interactive) (jump-to-register 2))
  "A-2" #'(lambda () (interactive) (window-configuration-to-register 2))
  "A-#" #'(lambda () (interactive) (jump-to-register 3))
  "A-3" #'(lambda () (interactive) (window-configuration-to-register 3))
  "A-$" #'(lambda () (interactive) (jump-to-register 4))
  "A-4" #'(lambda () (interactive) (window-configuration-to-register 4))
  "A-%" #'(lambda () (interactive) (jump-to-register 5))
  "A-5" #'(lambda () (interactive) (window-configuration-to-register 5))
  "A-^" #'(lambda () (interactive) (jump-to-register 6))
  "A-6" #'(lambda () (interactive) (window-configuration-to-register 6))
  "A-&" #'(lambda () (interactive) (jump-to-register 7))
  "A-7" #'(lambda () (interactive) (window-configuration-to-register 7))
  "A-*" #'(lambda () (interactive) (jump-to-register 8))
  "A-8" #'(lambda () (interactive) (window-configuration-to-register 8))
  "A-(" #'(lambda () (interactive) (jump-to-register 9))
  "A-9" #'(lambda () (interactive) (window-configuration-to-register 9))
  "A-)" #'(lambda () (interactive) (jump-to-register 0))
  "A-0" #'(lambda () (interactive) (window-configuration-to-register 0)))

 (:map evil-visual-state-map
  "v"   'er/expand-region
  "C-j" 'evil-join
  "A-s" #'shell-command-on-region
  "x" '+multiple-cursors/evil-mc-make-cursor-here)

 (:map evil-insert-state-map
  ;; Smarter newlines
  [remap newline] #'newline-and-indent  ; auto-indent on newline
  "C-j"           #'+default/newline    ; default behavior
  "C-h" 'evil-delete-backward-char
  "C-v" 'evil-paste-after
  "<mouse-2>" 'evil-paste-after)

 ;; Smart tab, these will only work in GUI Emacs
 :i [tab] (general-predicate-dispatch nil ; fall back to nearest keymap
            (and (featurep! :editor snippets)
                 (bound-and-true-p yas-minor-mode)
                 (yas-maybe-expand-abbrev-key-filter 'yas-expand))
            'yas-expand
            (and (featurep! :completion company +tng)
                 (+company-has-completion-p))
            '+company/complete)
 :n [tab] (general-predicate-dispatch nil
            (and (featurep! :editor fold)
                 (save-excursion (end-of-line) (invisible-p (point))))
            '+fold/toggle
            (fboundp 'evil-jump-item)
            'evil-jump-item)
 :v [tab] (general-predicate-dispatch nil
            (and (bound-and-true-p yas-minor-mode)
                 (or (eq evil-visual-selection 'line)
                     (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
            'yas-insert-snippet
            (fboundp 'evil-jump-item)
            'evil-jump-item)

 (:after vc-annotate
  :map vc-annotate-mode-map
  [remap quit-window] #'kill-current-buffer)

 ;; misc
 :n "C-S-f"  #'toggle-frame-fullscreen
 :n "C-+"    #'doom/reset-font-size
 :n "C-="    #'doom/increase-font-size
 :n "C--"    #'doom/decrease-font-size

 ;; ported from vim
 :m  "]m"    #'+evil/next-beginning-of-method
 :m  "[m"    #'+evil/previous-beginning-of-method
 :m  "]M"    #'+evil/next-end-of-method
 :m  "[M"    #'+evil/previous-end-of-method
 :m  "]#"    #'+evil/next-preproc-directive
 :m  "[#"    #'+evil/previous-preproc-directive
 :m  "]*"    #'+evil/next-comment
 :m  "[*"    #'+evil/previous-comment
 :m  "]\\"   #'+evil/next-comment
 :m  "[\\"   #'+evil/previous-comment
 :nv "z="    #'flyspell-correct-word-generic
 :v  "@"     #'+evil:apply-macro

 ;; ported from vim-unimpaired
 :n  "] SPC" #'+evil/insert-newline-below
 :n  "[ SPC" #'+evil/insert-newline-above
 :n  "]b"    #'next-buffer
 :n  "[b"    #'previous-buffer
 :n  "]f"    #'+evil/next-file
 :n  "[f"    #'+evil/previous-file
 :m  "]u"    #'+evil:url-encode
 :m  "[u"    #'+evil:url-decode
 :m  "]y"    #'+evil:c-string-encode
 :m  "[y"    #'+evil:c-string-decode
 ;; NOTE hl-todo-{next,previous} have ]t/[t, use ]F/[F instead
 ;; NOTE {next,previous}-error have ]e/[e, use ddp/ddP or gx instead
 (:when (featurep! :lang web)
  :m "]x" #'+web:encode-html-entities
  :m "[x" #'+web:decode-html-entities)

 ;; custom vim-unmpaired-esque keys
 :m  "]a"    #'evil-forward-arg
 :m  "[a"    #'evil-backward-arg
 :m  "]e"    #'next-error
 :m  "[e"    #'previous-error
 :n  "]F"    #'+evil/next-frame
 :n  "[F"    #'+evil/previous-frame
 :m  "]h"    #'outline-next-visible-heading
 :m  "[h"    #'outline-previous-visible-heading
 :n  "[o"    #'+evil/insert-newline-above
 :n  "]o"    #'+evil/insert-newline-below
 :n  "gp"    #'+evil/reselect-paste
 :v  "gp"    #'+evil/paste-preserve-register
 :nv "g@"    #'+evil:apply-macro
 :nv "gc"    #'evil-commentary
 :nv "gx"    #'evil-exchange
 :n  "g="    #'evil-numbers/inc-at-pt
 :n  "g-"    #'evil-numbers/dec-at-pt
 :v  "g="    #'evil-numbers/inc-at-pt-incremental
 :v  "g-"    #'evil-numbers/dec-at-pt-incremental
 :v  "g+"    #'evil-numbers/inc-at-pt
 :m  "gf"    #'find-file-in-project-at-point

 ;; custom evil keybinds
 :n  "zx"    #'kill-current-buffer
 :n  "ZX"    #'bury-buffer
 ;; repeat in visual mode (FIXME buggy)
 :v  "."     #'+evil:apply-macro
 ;; don't leave visual mode after shifting
 :v  "<"     #'+evil/visual-dedent       ; vnoremap < <gv
 :v  ">"     #'+evil/visual-indent      ; vnoremap > >gv

 ;; window management
 

 ;; Plugins
 ;; evil-easymotion
 :m  "gs"    #'+evil/easymotion         ; lazy-load `evil-easymotion'
 (:after evil-easymotion
  :map evilem-map
  "a" (evilem-create #'evil-forward-arg)
  "A" (evilem-create #'evil-backward-arg)
  "s" (evilem-create #'evil-snipe-repeat
                     :name 'evil-easymotion-snipe-forward
                     :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
                     :bind ((evil-snipe-scope 'buffer)
                            (evil-snipe-enable-highlight)
                            (evil-snipe-enable-incremental-highlight)))
  "S" (evilem-create #'evil-snipe-repeat
                     :name 'evil-easymotion-snipe-backward
                     :pre-hook (save-excursion (call-interactively #'evil-snipe-S))
                     :bind ((evil-snipe-scope 'buffer)
                            (evil-snipe-enable-highlight)
                            (evil-snipe-enable-incremental-highlight)))
  "SPC" (λ!! #'evil-avy-goto-char-timer t)
  "/" #'evil-avy-goto-char-timer)

 ;; text object plugins
 :textobj "x" #'evil-inner-xml-attr               #'evil-outer-xml-attr
 :textobj "a" #'evil-inner-arg                    #'evil-outer-arg
 :textobj "B" #'evil-textobj-anyblock-inner-block #'evil-textobj-anyblock-a-block
 :textobj "i" #'evil-indent-plus-i-indent         #'evil-indent-plus-a-indent
 :textobj "k" #'evil-indent-plus-i-indent-up      #'evil-indent-plus-a-indent-up
 :textobj "j" #'evil-indent-plus-i-indent-up-down #'evil-indent-plus-a-indent-up-down

 ;; evil-snipe
 (:after evil-snipe
  :map evil-snipe-parent-transient-map
  "C-;" (λ! (require 'evil-easymotion)
            (call-interactively
             (evilem-create #'evil-snipe-repeat
                            :bind ((evil-snipe-scope 'whole-buffer)
                                   (evil-snipe-enable-highlight)
                                   (evil-snipe-enable-incremental-highlight))))))

 ;; evil-surround
 :v "S" #'evil-surround-region
 :o "s" #'evil-surround-edit
 :o "S" #'evil-Surround-edit)

;;
;;; Evil override keybindings
(evil-define-key 'normal magit-mode-map (kbd "C-d") 'dired-jump)

;;
;;; Module keybinds

;;; :completion
(map! (:when (featurep! :completion company)
       :i "C-@"      #'+company/complete
       :i "C-SPC"    #'+company/complete
       (:prefix "C-x"
        :i "C-l"    #'+company/whole-lines
        :i "C-k"    #'+company/dict-or-keywords
        :i "C-f"    #'company-files
        :i "C-]"    #'company-etags
        :i "s"      #'company-ispell
        :i "C-s"    #'company-yasnippet
        :i "C-o"    #'company-capf
        :i "C-n"    #'+company/dabbrev
        :i "C-p"    #'+company/dabbrev-code-previous)

       (:after company
        (:map company-active-map
         "C-w"     nil        ; don't interfere with `evil-delete-backward-word'
         "C-n"     #'company-select-next
         "C-p"     #'company-select-previous
         "C-j"     #'company-select-next
         "C-k"     #'company-select-previous
         "C-h"     #'company-show-doc-buffer
         "C-u"     #'company-previous-page
         "C-d"     #'company-next-page
         "C-s"     #'company-filter-candidates
         "C-S-s"   (cond ((featurep! :completion helm) #'helm-company)
                         ((featurep! :completion ivy)  #'counsel-company))
         "C-SPC"   #'company-complete-common
         "TAB"     #'company-complete-common-or-cycle
         [tab]     #'company-complete-common-or-cycle
         [backtab] #'company-select-previous)
        (:map company-search-map        ; applies to `company-filter-map' too
         "C-n"     #'company-select-next-or-abort
         "C-p"     #'company-select-previous-or-abort
         "C-j"     #'company-select-next-or-abort
         "C-k"     #'company-select-previous-or-abort
         "C-s"     (λ! (company-search-abort) (company-filter-candidates))
         "ESC"     #'company-search-abort)
        ;; TAB auto-completion in term buffers
        (:map comint-mode-map
         "TAB" #'company-complete
         [tab] #'company-complete)))

      (:map dired-mode-map
       "<normal-state> yy"     #'dired-ranger-copy
       "<normal-state> ym"     #'dired-ranger-move
       "<normal-state> yp"     #'dired-ranger-paste
       ;; "<normal-state> C-c"  #'sam-dired-copy
       ;; "<normal-state> C-x"  #'sam-dired-cut
       ;; "<normal-state> C-v"  #'sam-dired-paste
       "<normal-state> C-l"    #'dired-do-symlink
       "<normal-state> h"    #'dired-up-directory
       "<normal-state> l"    #'dired-find-file)

      (:map evil-cleverparens-mode-map
       :n "H"  #'sp-beginning-of-sexp
       :n "J"  #'sp-beginning-of-next-sexp
       :n "K"  #'sp-beginning-of-previous-sexp
       :n "L"  #'sp-end-of-sexp
       )

      (:when (featurep! :completion ivy)
       (:map (help-mode-map helpful-mode-map)
        :n "Q" #'ivy-resume)
       (:after ivy
        :map ivy-minibuffer-map
        "C-SPC" #'ivy-call-and-recenter ; preview file
        "M-h"   #'ivy-backward-kill-word
        "C-h"   #'ivy-backward-delete-char
        "C-l"   #'ivy-alt-done
        "C-v"   #'yank)
       (:after counsel
        :map counsel-ag-map
        "C-SPC"    #'ivy-call-and-recenter ; preview
        "C-l"      #'ivy-done))


      (:when (featurep! :completion helm)
       (:after helm
        (:map helm-map
         [left]     #'left-char
         [right]    #'right-char
         "C-S-n"    #'helm-next-source
         "C-S-p"    #'helm-previous-source
         "C-j"      #'helm-next-line
         "C-k"      #'helm-previous-line
         "C-S-j"    #'helm-next-source
         "C-S-k"    #'helm-previous-source
         "C-f"      #'helm-next-page
         "C-S-f"    #'helm-previous-page
         "C-u"      #'helm-delete-minibuffer-contents
         "C-w"      #'backward-kill-word
         "C-h"      #'backward-kill-word
         "C-r"      #'evil-paste-from-register ; Evil registers in helm! Glorious!
         "C-s"      #'helm-minibuffer-history
         "C-b"      #'backward-word
         ;; Swap TAB and C-z
         "TAB"      #'helm-execute-persistent-action
         [tab]      #'helm-execute-persistent-action
         "C-z"      #'helm-select-action)
        (:after helm-ag
         :map helm-ag-map
         "C--"      #'+helm-do-ag-decrease-context
         "C-="      #'+helm-do-ag-increase-context
         [left]     nil
         [right]    nil)
        (:after helm-files
         :map (helm-find-files-map helm-read-file-map)
         [C-return] #'helm-ff-run-switch-other-window
         "C-w"      #'helm-find-files-up-one-level)
        (:after helm-locate
         :map helm-generic-files-map
         [C-return] #'helm-ff-run-switch-other-window)
        (:after helm-buffers
         :map helm-buffer-map
         [C-return] #'helm-buffer-switch-other-window)
        (:after helm-occur
         :map helm-occur-map
         [C-return] #'helm-occur-run-goto-line-ow)
        (:after helm-grep
         :map helm-grep-map
         [C-return] #'helm-grep-run-other-window-action)))

      (:map sclang-mode-map
       :n "C-e" #'+sclang-eval-this-expression))


;;; :ui
(map! (:when (featurep! :ui hl-todo)
       :m "]t" #'hl-todo-next
       :m "[t" #'hl-todo-previous)

      (:when (featurep! :ui neotree)
       :after neotree
       :map neotree-mode-map
       :n "g"      nil
       :n "TAB"    #'neotree-quick-look
       :n "RET"    #'neotree-enter
       :n [tab]    #'neotree-quick-look
       :n [return] #'neotree-enter
       :n "DEL"    #'evil-window-prev
       :n "c"      #'neotree-create-node
       :n "r"      #'neotree-rename-node
       :n "d"      #'neotree-delete-node
       :n "j"      #'neotree-next-line
       :n "k"      #'neotree-previous-line
       :n "n"      #'neotree-next-line
       :n "p"      #'neotree-previous-line
       :n "h"      #'+neotree/collapse-or-up
       :n "l"      #'+neotree/expand-or-open
       :n "J"      #'neotree-select-next-sibling-node
       :n "K"      #'neotree-select-previous-sibling-node
       :n "H"      #'neotree-select-up-node
       :n "L"      #'neotree-select-down-node
       :n "G"      #'evil-goto-line
       :n "gg"     #'evil-goto-first-line
       :n "v"      #'neotree-enter-vertical-split
       :n "s"      #'neotree-enter-horizontal-split
       :n "q"      #'neotree-hide
       :n "R"      #'neotree-refresh)

      (:when (featurep! :ui popup)
       :n "C-`"   #'+popup/toggle
       :n "C-~"   #'+popup/raise
       :g "C-x p" #'+popup/other)

      (:when (featurep! :ui vc-gutter)
       :m "]d"    #'git-gutter:next-hunk
       :m "[d"    #'git-gutter:previous-hunk)

    ;;; <leader> w --- windowing
      (:map evil-window-map
       ;; Navigation
       "C-h"     #'evil-window-left
       "C-j"     #'evil-window-down
       "C-k"     #'evil-window-up
       "C-l"     #'evil-window-right
       "C-w"     #'other-window
       "C-n"     #'evil-window-vnew
       "C-q"     #'evil-quit-all
       ;; Swapping windows
       "H"       #'+evil/window-move-left
       "J"       #'+evil/window-move-down
       "K"       #'+evil/window-move-up
       "L"       #'+evil/window-move-right
       "C-S-w"   #'ace-swap-window
       ;; Window undo/redo
       (:prefix "m"
        "m"       #'doom/window-maximize-buffer
        "v"       #'doom/window-maximize-vertically
        "s"       #'doom/window-maximize-horizontally)
       (:prefix "C-m"
        "m"       #'doom/window-maximize-buffer
        "v"       #'doom/window-maximize-vertically
        "s"       #'doom/window-maximize-horizontally)
       "u"       #'winner-undo
       "C-u"     #'winner-undo
       "C-r"     #'winner-redo
       ;; "o"       #'doom/window-enlargen
       "o"       #'delete-other-windows
       ;; Delete window
       "C-C"     #'ace-delete-window)
      )

;;; :editor
(map! (:when (featurep! :editor fold)
       :nv "M-SPC" #'(lambda () (interactive) (toggle-fold-lines))
       :nv "C-SPC" #'+fold/toggle)

      (:when (featurep! :editor format)
       :n "gQ"    #'+format:region)

      (:when (featurep! :editor multiple-cursors)
       ;; evil-mc
       (:prefix "gz"
        :nv "d" #'evil-mc-make-and-goto-next-match
        :nv "D" #'evil-mc-make-and-goto-prev-match
        :nv "j" #'evil-mc-make-cursor-move-next-line
        :nv "k" #'evil-mc-make-cursor-move-prev-line
        :nv "m" #'evil-mc-make-all-cursors
        :nv "n" #'evil-mc-make-and-goto-next-cursor
        :nv "N" #'evil-mc-make-and-goto-last-cursor
        :nv "p" #'evil-mc-make-and-goto-prev-cursor
        :nv "P" #'evil-mc-make-and-goto-first-cursor
        :nv "q" #'evil-mc-undo-all-cursors
        :nv "t" #'+multiple-cursors/evil-mc-toggle-cursors
        :nv "u" #'evil-mc-undo-last-added-cursor
        :nv "z" #'+multiple-cursors/evil-mc-make-cursor-here)
       (:after evil-mc
        :map evil-mc-key-map
        :nv "C-n" #'evil-mc-make-and-goto-next-cursor
        :nv "C-N" #'evil-mc-make-and-goto-last-cursor
        :nv "C-p" #'evil-mc-make-and-goto-prev-cursor
        :nv "C-P" #'evil-mc-make-and-goto-first-cursor)
       ;; evil-multiedit
       :v  "R"     #'evil-multiedit-match-all
       :n  "M-d"   #'evil-multiedit-match-symbol-and-next
       :n  "M-D"   #'evil-multiedit-match-symbol-and-prev
       :v  "M-d"   #'evil-multiedit-match-and-next
       :v  "M-D"   #'evil-multiedit-match-and-prev
       :nv "C-M-d" #'evil-multiedit-restore
       (:after evil-multiedit
        (:map evil-multiedit-state-map
         "M-d"    #'evil-multiedit-match-and-next
         "M-D"    #'evil-multiedit-match-and-prev
         "RET"    #'evil-multiedit-toggle-or-restrict-region
         [return] #'evil-multiedit-toggle-or-restrict-region)
        (:map (evil-multiedit-state-map evil-multiedit-insert-state-map)
         "C-n" #'evil-multiedit-next
         "C-p" #'evil-multiedit-prev)))

      (:when (featurep! :editor rotate-text)
       :n "!" #'rotate-text)

      (:when (featurep! :editor snippets)
       ;; auto-yasnippet
       :i  [C-tab] #'aya-expand
       :nv [C-tab] #'aya-create
       ;; yasnippet
       (:after yasnippet
        (:map yas-keymap
         "C-e"         #'+snippets/goto-end-of-field
         "C-a"         #'+snippets/goto-start-of-field
         [M-right]     #'+snippets/goto-end-of-field
         [M-left]      #'+snippets/goto-start-of-field
         [M-backspace] #'+snippets/delete-to-start-of-field
         [backspace]   #'+snippets/delete-backward-char
         [delete]      #'+snippets/delete-forward-char-or-field))))

(when (featurep! :editor evil)
  ;; Add vimish-fold, outline-mode & hideshow support to folding commands
  (define-key! 'global
    [remap evil-toggle-fold]   #'+fold/toggle
    [remap evil-close-fold]    #'+fold/toggle
    [remap evil-open-fold]     #'+fold/open
    [remap evil-open-fold-rec] #'+fold/open
    [remap evil-close-folds]   #'+fold/close-all
    [remap evil-open-folds]    #'+fold/open-all)
  (evil-define-key* 'motion 'global
    "zm" #'toggle-fold-lines))

;;; :emacs
(map! (:when (featurep! :emacs vc)
       :after git-timemachine
       :map git-timemachine-mode-map
       :n "C-p" #'git-timemachine-show-previous-revision
       :n "C-n" #'git-timemachine-show-next-revision
       :n "[["  #'git-timemachine-show-previous-revision
       :n "]]"  #'git-timemachine-show-next-revision
       :n "q"   #'git-timemachine-quit
       :n "gb"  #'git-timemachine-blame)
      (:when (featurep! :emacs dired +ranger)
       :after ranger
       :map ranger-mode-map "C-w" nil))

;;; :tools
(map! (:when (featurep! :tools eval)
       :g  "M-r" #'+eval/buffer
       :nv "gr"  #'+eval:region
       :n  "gR"  #'+eval/buffer
       :v  "gR"  #'+eval:replace-region)

      (:when (featurep! :tools spell)
       ;; Keybinds that have no Emacs+evil analogues (i.e. don't exist):
       ;;   zq - mark word at point as good word
       ;;   zw - mark word at point as bad
       ;;   zu{q,w} - undo last marking
       ;; Keybinds that evil define:
       ;;   z= - correct flyspell word at point
       ;;   ]s - jump to previous spelling error
       ;;   [s - jump to next spelling error
       (:map flyspell-mouse-map
        "RET"     #'flyspell-correct-word-generic
        [return]  #'flyspell-correct-word-generic
        [mouse-1] #'flyspell-correct-word-generic))

      ;;      (:when (featurep! :checkers syntax)
      ;;        (:after flycheck
      ;;          :map flycheck-error-list-mode-map
      ;;          :n "C-n"    #'flycheck-error-list-next-error
      ;;          :n "C-p"    #'flycheck-error-list-previous-error
      ;;          :n "j"      #'flycheck-error-list-next-error
      ;;          :n "k"      #'flycheck-error-list-previous-error
      ;;          :n "RET"    #'flycheck-error-list-goto-error
      ;;          :n [return] #'flycheck-error-list-goto-error))

      (:when (featurep! :tools gist)
       :after gist
       :map gist-list-menu-mode-map
       :n "go"  #'gist-browse-current-url
       :n "gr"  #'gist-list-reload
       :n "c"   #'gist-add-buffer
       :n "d"   #'gist-kill-current
       :n "e"   #'gist-edit-current-description
       :n "f"   #'gist-fork
       :n "q"   #'kill-current-buffer
       :n "s"   #'gist-star
       :n "S"   #'gist-unstar
       :n "y"   #'gist-print-current-url)

      (:when (featurep! :tools lookup)
       :nv "K"  #'+lookup/documentation
       :nv "gd" #'+lookup/definition
       :nv "gD" #'+lookup/references
       :nv "gf" #'+lookup/file)

      (:when (featurep! :tools magit)
       (:after evil-magit
        ;; fix conflicts with private bindings
        :map (magit-mode-map magit-status-mode-map magit-revision-mode-map)
        "k"   'magit-checkout
        "C-d" 'dired-jump
        "C-j" nil
        "C-k" nil)
       (:map transient-map
        "q" #'transient-quit-one))

      ;; (:map package-menu-mode-map
      ;;  )
      )

;;; :lang
;; (general-define-key
;;  :states 'normal
;;  :keymaps 'prog-mode-map
;;  "RET" #'evil-commentary-line
;;  )
(map!
 (:map prog-mode-map
  :nv [return] #'evil-commentary-line)

 (:map evil-cleverparens-mode-map
  :n "M-9"      #'lispy-parens-auto-wrap
  :n "S"      #'evil-snipe-S
  :n "s"      #'evil-snipe-s)

 (:when (featurep! :lang markdown)
  :after markdown-mode
  :map markdown-mode-map
  ;; fix conflicts with private bindings
  [backspace] nil)

 (:map evil-org-mode-map
  :n "t" #'org-set-tags-command
  :n "pp" #'evil-paste-after
  :n "pl" #'org-insert-link))

;;
;;; <leader>
(map! :leader
      :desc "ranger"                       "-"    #'ranger
      :desc "Eval expression"              ";"    #'execute-extended-command
      :desc "M-x"                          ":"    #'eval-expression
      :desc "Toggle last popup"            "~"    #'+popup/toggle
      :desc "Switch buffer"                ","    #'switch-to-buffer
      :desc "Find file"                    "."    #'find-file
      :desc "Switch to last buffer"        "`"    #'evil-switch-to-windows-last-buffer
      :desc "Resume last search"           "'"    (cond ((featurep! :completion ivy)   #'ivy-resume)
                                                        ((featurep! :completion helm)  #'helm-resume))
      :desc "search web"                   "/"    #'web-search
      :desc "Search for symbol in project" "*" #'+default/search-project-for-symbol-at-point

      :desc "Blink cursor line"     "DEL" #'+nav-flash/blink-cursor
      :desc "Jump to bookmark"      "RET" #'bookmark-jump
      :desc "Switch project"        "SPC" #'projectile-persp-switch-project
      :desc "switch other buffer"   "TAB" #'mode-line-other-buffer

      :desc "help"        "h"    help-map
      :desc "imenu"       "i"    #'imenu
      :desc "ace-jump"    "j"    #'(lambda () (interactive) (avy-goto-word-or-subword-1))
      :desc "window"      "w"    evil-window-map
      :desc "Org Capture" "x"    #'org-capture

    ;;; <leader a --- admin
      (:prefix-map ("a" . "admin")
       :desc "arch packages"  "a"   #'helm-system-packages
       :desc "daemons"        "d"   #'daemons
       :desc "emacs packages" "e"   #'counsel-package
       :desc "list-packages"  "l"   #'list-packages
       :desc "proced"         "p"   #'proced
       :desc "systemd"        "s"   #'helm-systemd)

    ;;; <leader> b --- buffer
      (:prefix-map ("b" . "buffer")
       :desc "Toggle narrowing"            "-"   #'doom/clone-and-narrow-buffer
       :desc "Previous buffer"             "["   #'previous-buffer
       :desc "Next buffer"                 "]"   #'next-buffer
       :desc "Switch workspace buffer"     "b"   #'persp-ivy-switch-buffer
       :desc "Switch buffer"               "B"   #'switch-to-buffer
       :desc "Kill deer buffers"           "d"   #'ranger-kill-buffers-without-window
       :desc "Kill buffer"                 "k"   #'kill-current-buffer
       :desc "Switch to last buffer"       "l"   #'evil-switch-to-windows-last-buffer
       :desc "Next buffer"                 "n"   #'next-buffer
       :desc "New empty buffer"            "N"   #'evil-buffer-new
       :desc "Kill other buffers"          "o"   #'doom/kill-other-buffers
       :desc "Previous buffer"             "p"   #'previous-buffer
       :desc "Save buffer"                 "s"   #'save-buffer
       :desc "Sudo edit this file"         "S"   #'doom/sudo-this-file
       :desc "Swipe"                       "w"   #'counsel-grep-or-swiper
       :desc "Pop up scratch buffer"       "x"   #'doom/open-scratch-buffer
       :desc "Switch to scratch buffer"    "X"   #'doom/switch-to-scratch-buffer
       :desc "Bury buffer"                 "z"   #'bury-buffer)

    ;;; <leader> c --- code
      (:prefix-map ("c" . "code")
       :desc "Compile"                     "c"   #'sam-compile
       :desc "Jump to definition"          "d"   #'+lookup/definition
       :desc "Jump to references"          "D"   #'+lookup/references
       :desc "Evaluate buffer/region"      "e"   #'+eval/buffer-or-region
       :desc "Evaluate & replace region"   "E"   #'+eval:replace-region
       :desc "Format buffer/region"        "f"   #'+format/region-or-buffer
       :desc "Jump to documentation"       "k"   #'+lookup/documentation
       :desc "Open REPL"                   "r"   #'+eval/open-repl-other-window
       :desc "Delete trailing whitespace"  "w"   #'delete-trailing-whitespace
       :desc "Delete trailing newlines"    "W"   #'doom/delete-trailing-newlines
       :desc "List errors"                 "x"   #'flycheck-list-errors)

    ;;; <leader> d --- debug
      (:prefix-map ("d" . "debug")
       :desc "gdb"                    "d"   #'gdb
       :desc "gdb many windows"       "m"   #'gdb-many-windows
       :desc "serial terminal"        "s"   #'serial-term)

      (:prefix-map ("e" . "edit")
       :desc "bindings"             "b"   #'(lambda () (interactive) (find-file "~/.doom.d/+bindings.el"))
       :desc "bindings"             "z"   #'(lambda () (interactive) (find-file "~/.zshrc"))
       :desc "http.conf"            "h"   #'(lambda () (interactive) (find-file "/etc/httpd/conf/httpd.conf"))
       :desc "i3"                   "i"   #'(lambda () (interactive) (find-file "~/.config/i3/config")))

    ;;; <leader> f --- file
      (:prefix-map ("f" . "file")
       :desc "Find file"                   "d"   #'counsel-file-jump
       ;;        (if (featurep! :completion ivy)
       ;;            #'counsel-file-jump
       ;;          (λ! (doom-project-find-file default-directory)))
       :desc "Open project editorconfig"   "c"   #'editorconfig-find-current-editorconfig
       :desc "Find file in emacs.d"        "e"   #'+default/find-in-emacsd
       :desc "Browse emacs.d"              "E"   #'+default/browse-emacsd
       :desc "Find file from here"         "f"   #'find-file
       :desc "lookup file below directory" "l"   #'projectile-find-file-in-directory
       :desc "Move/rename file"            "m"   #'doom/move-this-file
       :desc "Find project file"           "p"   #'counsel-projectile-find-file
       :desc "Browse private config"       "P"   #'doom/open-private-config
       :desc "Recent files"                "r"   #'recentf-open-files
       :desc "Recent project files"        "R"   #'projectile-recentf
       :desc "Sudo find file"              "s"   #'doom/sudo-find-file
       :desc "treemacs"                    "t"   #'+treemacs/toggle
       :desc "Delete this file"            "X"   #'doom/delete-this-file
       :desc "Yank filename"               "y"   #'+default/yank-buffer-filename)

      (:prefix-map ("g" . "go")
       :desc "current dir"            "."   #'(lambda () (interactive) (find-file "."))
       :desc "doom"                   "d"   #'(lambda () (interactive) (find-file "~/.doom.d"))
       :desc "home"                   "h"   #'(lambda () (interactive) (find-file "~"))
       :desc "local source"           "l"   #'(lambda () (interactive) (find-file "~/src"))
       :desc "notes"                  "n"   #'(lambda () (interactive) (find-file "~/notes"))
       :desc "sites"                  "s"   #'(lambda () (interactive) (find-file "~/sites"))
       :desc "test"                   "t"   #'(lambda () (interactive) (find-file "~/test")))

    ;;; <leader> i --- insert

      ;; (:prefix-map ("i" . "insert")
      ;;   :desc "Insert from clipboard"         "y"   #'+default/yank-pop
      ;;   :desc "Insert from evil register"     "r"   #'evil-ex-registers
      ;;   :desc "Insert snippet"                "s"   #'yas-insert-snippet)

    ;;; <leader> k --- toggle
      (:prefix-map ("k" . "toggle")
       :desc "Big mode"                     "b" #'doom-big-font-mode
       :desc "Flycheck"                     "f" #'flycheck-mode
       :desc "Frame fullscreen"             "F" #'toggle-frame-fullscreen
       :desc "Evil goggles"                 "g" #'evil-goggles-mode
       :desc "Indent guides"                "i" #'highlight-indent-guides-mode
       :desc "Indent style"                 "I" #'doom/toggle-indent-style
       :desc "Line numbers"                 "l" #'doom/toggle-line-numbers
       :desc "Word-wrap mode"               "w" #'+word-wrap-mode
       :desc "org-tree-slide mode"          "p" #'+org-present/start
       :desc "Flyspell"                     "s" #'flyspell-mode
       :desc "Zen"                          "z" #'writeroom-mode)

    ;;; <leader> l --- search
      (:prefix-map ("l" . "lookup")
       :desc "Jump to link"                  "a" #'ace-link
       :desc "Search buffer"                 "b" #'swiper
       :desc "Search current directory"      "d" #'+default/search-cwd
       :desc "Search other directory"        "D" #'+default/search-other-cwd
       :desc "Find file in current dir"      "f" #'counsel-file-jump
       :desc "Jump to symbol"                "i" #'imenu
       :desc "search at point"               "l" #'swiper
       :desc "Look up online"                "o" #'+lookup/online
       :desc "Look up online (w/ prompt)"    "O" #'+lookup/online-select
       :desc "Look up in local docsets"      "k" #'+lookup/in-docsets
       :desc "Look up in all docsets"        "K" #'+lookup/in-all-docsets
       :desc "Search project"                "p" #'+default/search-project-for-symbol-at-point
       :desc "Search other project"          "P" #'+default/search-other-project
       :desc "Search buffer"                 "s" #'swiper
       :desc "lookup in wordnet"             "w" #'wordnut-lookup-current-word
       :desc "Search stackexchange"          "x" #'sx-search)

    ;;; <leader> m --- bookmarks
      (:prefix-map ("m" . "bookmarks")
       :desc "set"                  "s"   #'bookmark-set)

    ;;; <leader> n --- notes
      (:prefix-map ("n" . "notes")
       :desc "Browse notes"                  "." #'+default/browse-notes
       :desc "Search notes"                  "/" #'+default/org-notes-search
       :desc "Search notes for symbol"       "*" #'+default/search-notes-for-symbol-at-point
       :desc "Org agenda"                    "a" #'org-agenda
       :desc "Org capture"                   "c" #'org-capture
       :desc "Open deft"                     "d" #'deft
       :desc "Search org agenda headlines"   "h" #'+default/org-notes-headlines
       :desc "Org store link"                "l" #'org-store-link
       :desc "Find file in notes"            "n" #'+default/find-in-notes
       :desc "Browse notes"                  "N" #'+default/browse-notes
       :desc "Tags search"                   "m" #'org-tags-view
       :desc "View search"                   "v" #'org-search-view
       :desc "Todo list"                     "t" #'org-todo-list)

    ;;; <leader> o --- open
      (:prefix-map ("o" . "open")
       :desc "Default browser"              "b" #'browse-url-of-file
       :desc "date"                         "d" #'calendar
       :desc "eww"                          "e" #'eww
       :desc "gnus"                         "g" #'gnus
       :desc "Find file in project sidebar" "P" #'+treemacs/find-file
       (:when (featurep! :tools docker)
        :desc "Docker" "D" #'docker))

    ;;; <leader> p --- project
      (:prefix-map ("p" . "project")
       :desc "Repeat last external command" ";" #'projectile-repeat-last-command
       ;; :desc "Browse other project"         ">" #'doom/browse-in-other-project
       :desc "Find file in project"         "f" #'projectile-find-file
       :desc "Find file in other project"   "?" #'doom/find-file-in-other-project
       :desc "Run cmd in project root"      "!" #'projectile-run-shell-command-in-root
       :desc "Add new project"              "a" #'projectile-add-known-project
       :desc "Switch to project buffer"     "b" #'projectile-switch-to-buffer
       :desc "Compile in project"           "c" #'projectile-compile-project
       :desc "Configure project"            "C" #'projectile-configure-project
       :desc "Remove known project"         "d" #'projectile-remove-known-project
       :desc "Edit project .dir-locals"     "e" #'projectile-edit-dir-locals
       :desc "Find project file at point"   "f" #'find-file-in-project-at-point
       :desc "Invalidate project cache"     "i" #'projectile-invalidate-cache
       :desc "Kill project buffers"         "k" #'projectile-kill-buffers
       :desc "Browse project"               "l" #'+default/browse-project
       :desc "next persp"                   "n" #'persp-next
       :desc "Find other file"              "o" #'projectile-find-other-file
       :desc "previous persp"               "p" #'persp-prev
       :desc "go to project root"           "r" #'(lambda () (interactive) (find-file (projectile-project-root)))
       :desc "Run project"                  "R" #'projectile-run-project
       :desc "Pop up scratch buffer"        "x" #'doom/open-project-scratch-buffer
       :desc "Switch to scratch buffer"     "X" #'doom/switch-to-project-scratch-buffer
       :desc "List project tasks"           "t" #'+default/project-tasks
       :desc "Test project"                 "T" #'projectile-test-project)

    ;;; <leader> q --- session
      (:prefix-map ("q" . "session")
       :desc "Quit Emacs"                   "q" #'save-buffers-kill-terminal
       :desc "Quit Emacs without saving"    "Q" #'evil-quit-all-with-error-code
       :desc "Quick save current session"   "S" #'doom/quicksave-session
       :desc "Restore last session"         "L" #'doom/quickload-session
       :desc "Save session to file"         "s" #'doom/save-session
       :desc "Restore session from file"    "l" #'doom/load-session
       :desc "Restart & restore Emacs"      "r" #'doom/restart-and-restore
       :desc "Restart Emacs"                "R" #'doom/restart)

    ;;; <leader> r --- remote
      (:when (featurep! :tools upload)
       (:prefix-map ("r" . "remote")
        :desc "Upload local"               "u" #'ssh-deploy-upload-handler
        :desc "Upload local (force)"       "U" #'ssh-deploy-upload-handler-forced
        :desc "Download remote"            "d" #'ssh-deploy-download-handler
        :desc "Diff local & remote"        "D" #'ssh-deploy-diff-handler
        :desc "Browse remote files"        "." #'ssh-deploy-browse-remote-handler
        :desc "Detect remote changes"      ">" #'ssh-deploy-remote-changes-handler))

    ;;; <leader> s --- snippets
      (:when (featurep! :editor snippets)
       (:prefix-map ("s" . "snippets")
        :desc "View snippet for mode"      "/" #'+snippets/find-for-current-mode
        :desc "View snippet (global)"      "?" #'+snippets/find
        :desc "Edit snippet"               "c" #'+snippets/edit
        :desc "View private snippet"       "f" #'+snippets/find-private
        :desc "Insert snippet"             "i" #'yas-insert-snippet
        :desc "New snippet"                "n" #'+snippets/new
        :desc "New snippet alias"          "N" #'+snippets/new-alias
        :desc "Reload snippets"            "r" #'yas-reload-all
        :desc "Create temporary snippet"   "s" #'aya-create
        :desc "Expand temporary snippet"   "e" #'aya-expand))

    ;;; <leader> t --- terminal
      (:prefix-map ("t" . "terminal")
       :desc "next"               "j" #'(lambda () (interactive) (multi-term-next))
       :desc "previous"           "k" #'(lambda () (interactive) (multi-term-prev))
       :desc "new"                "n" #'(lambda () (interactive) (multi-term))
       :desc "REPL"               "r" #'+eval/open-repl-other-window
       :desc "REPL (same window)" "R" #'+eval/open-repl-same-window
       :desc "toggle dedicated"   ";" #'(lambda () (interactive) (multi-term-dedicated-toggle)))

    ;;; <leader> u --- utilities
      (:prefix-map ("u" . "utilities")
       :desc "calc"                  "c" #'calc
       :desc "dictionary"            "d" #'wordnut-search
       :desc "browse kill ring"      "k" #'browse-kill-ring)

    ;;; <leader> v --- version control
      (:prefix-map ("v" . "version control")
       :desc "Git revert file"             "R"   #'vc-revert
       (:when (featurep! :ui vc-gutter)
        :desc "Git revert hunk"           "r"   #'git-gutter:revert-hunk
        :desc "Git stage hunk"            "s"   #'git-gutter:stage-hunk
        :desc "Git time machine"          "t"   #'git-timemachine-toggle
        :desc "Jump to next hunk"         "]"   #'git-gutter:next-hunk
        :desc "Jump to previous hunk"     "["   #'git-gutter:previous-hunk)
       (:when (featurep! :tools magit)
        :desc "Magit dispatch"            "/"   #'magit-dispatch
        :desc "Forge dispatch"            "'"   #'forge-dispatch
        :desc "Magit switch branch"       "b"   #'magit-branch-checkout
        :desc "Magit clone"               "n"   #'magit-clone
        :desc "Magit status"              "v"   #'magit-status
        :desc "Magit file delete"         "x"   #'magit-file-delete
        :desc "Magit blame"               "B"   #'magit-blame-addition
        :desc "Magit fetch"               "F"   #'magit-fetch
        :desc "Magit buffer log"          "L"   #'magit-log
        :desc "Git stage file"            "S"   #'magit-stage-file
        :desc "Git unstage file"          "U"   #'magit-unstage-file
        (:prefix ("f" . "find")
         :desc "Find file"                 "f"   #'magit-find-file
         :desc "Find gitconfig file"       "g"   #'magit-find-git-config-file
         :desc "Find commit"               "c"   #'magit-show-commit
         :desc "Find issue"                "i"   #'forge-visit-issue
         :desc "Find pull request"         "p"   #'forge-visit-pullreq)
        (:prefix ("o" . "open in browser")
         :desc "Browse region or line"     "."   #'+vc/git-browse-region-or-line
         :desc "Browse remote"             "r"   #'forge-browse-remote
         :desc "Browse commit"             "c"   #'forge-browse-commit
         :desc "Browse an issue"           "i"   #'forge-browse-issue
         :desc "Browse a pull request"     "p"   #'forge-browse-pullreq
         :desc "Browse issues"             "I"   #'forge-browse-issues
         :desc "Browse pull requests"      "P"   #'forge-browse-pullreqs)
        (:prefix ("l" . "list")
         (:when (featurep! :tools gist)
          :desc "List gists"              "g"   #'+gist:list)
         :desc "List repositories"         "r"   #'magit-list-repositories
         :desc "List submodules"           "s"   #'magit-list-submodules
         :desc "List issues"               "i"   #'forge-list-issues
         :desc "List pull requests"        "p"   #'forge-list-pullreqs
         :desc "List notifications"        "n"   #'forge-list-notifications)
        (:prefix ("c" . "create")
         :desc "Initialize repo"           "r"   #'magit-init
         :desc "Clone repo"                "R"   #'+magit/clone
         :desc "Commit"                    "c"   #'magit-commit-create
         :desc "Fixup"                     "f"   #'magit-commit-fixup
         :desc "Branch"                    "b"   #'magit-branch-and-checkout
         :desc "Issue"                     "i"   #'forge-create-issue
         :desc "Pull request"              "p"   #'forge-create-pullreq)))

    ;;; <leader> z --- scratch
      (:prefix-map ("z" . "scratch")
       :desc "C"       "c" #'(lambda () (interactive) (find-file "~/scratch/c/test.c"))
       :desc "Elisp"   "l" #'(lambda () (interactive) (find-file "~/scratch/elisp/test.el"))
       :desc "text"    "t" #'(lambda () (interactive) (find-file "~/scratch/text/generic.txt"))
       :desc "generic" "z" #'doom/open-scratch-buffer))

;;
;;; Universal motion repeating keys

(defvar +default-repeat-keys (cons ";" ",")
  "The keys to use for repeating motions.

This is a cons cell whose CAR is the key for repeating a motion forward, and
whose CDR is for repeating backward. They should both be kbd-able strings.")

(when +default-repeat-keys
  (defmacro set-repeater! (command next-func prev-func)
    "Makes ; and , the universal repeat-keys in evil-mode.
To change these keys see `+default-repeat-keys'."
    (let ((fn-sym (intern (format "+default/repeat-%s" (doom-unquote command)))))
      `(progn
         (defun ,fn-sym (&rest _)
           (evil-define-key* 'motion 'local
             (kbd (car +default-repeat-keys)) #',next-func
             (kbd (cdr +default-repeat-keys)) #',prev-func))
         (advice-add #',command :after-while #',fn-sym))))

  ;; n/N
  (set-repeater! evil-ex-search-next evil-ex-search-next evil-ex-search-previous)
  (set-repeater! evil-ex-search-previous evil-ex-search-next evil-ex-search-previous)
  (set-repeater! evil-ex-search-forward evil-ex-search-next evil-ex-search-previous)
  (set-repeater! evil-ex-search-backward evil-ex-search-next evil-ex-search-previous)

  ;; f/F/t/T/s/S
  (after! evil-snipe
    (setq evil-snipe-repeat-keys nil
          evil-snipe-override-evil-repeat-keys nil) ; causes problems with remapped ;
    (set-repeater! evil-snipe-f evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-F evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-t evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-T evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-s evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-S evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-x evil-snipe-repeat evil-snipe-repeat-reverse)
    (set-repeater! evil-snipe-X evil-snipe-repeat evil-snipe-repeat-reverse))

  ;; */#
  (set-repeater! evil-visualstar/begin-search-forward
                 evil-ex-search-next evil-ex-search-previous)
  (set-repeater! evil-visualstar/begin-search-backward
                 evil-ex-search-previous evil-ex-search-next))


;;
;;; Universal evil integration

(when (featurep! :editor evil +everywhere)
  ;; Have C-u behave similarly to `doom/backward-to-bol-or-indent'.
  ;; NOTE SPC u replaces C-u as the universal argument.
  (map! :gi "C-u" #'doom/backward-kill-to-bol-and-indent
        :gi "C-w" #'backward-kill-word
        ;; Vimmish ex motion keys
        :gi "C-b" #'backward-word
        :gi "C-f" #'forward-word)

  (after! view
    (define-key view-mode-map [escape] #'View-quit-all))
  (after! man
    (evil-define-key* 'normal Man-mode-map "q" #'kill-current-buffer))

  ;; Minibuffer
  (define-key! evil-ex-completion-map
    "C-a" #'move-beginning-of-line
    "C-b" #'backward-word
    "C-s" (if (featurep! :completion ivy)
              #'counsel-minibuffer-history
            #'helm-minibuffer-history))

  (define-key! :keymaps +default-minibuffer-maps
    [escape] #'abort-recursive-edit
    "C-v"    #'yank
    "C-z"    (λ! (ignore-errors (call-interactively #'undo)))
    "C-a"    #'move-beginning-of-line
    "C-b"    #'backward-word
    "C-r"    #'evil-paste-from-register
    ;; "C-n"    #'next-history-element
    ;; "C-p"    #'previous-history-element
    ;; Scrolling lines
    "C-j"    #'next-line
    "C-k"    #'previous-line
    "C-S-j"  #'scroll-up-command
    "C-S-k"  #'scroll-down-command)

  (define-key! read-expression-map
    "C-j" #'next-line-or-history-element
    "C-k" #'previous-line-or-history-element))

(define-key! help-map
  ;; new keybinds
  "'"    #'describe-char
  "D"    #'doom/help
  "E"    #'doom/sandbox
  "M"    #'doom/describe-active-minor-mode
  "O"    #'+lookup/online
  "R"    #'doom/reload
  "T"    #'doom/toggle-profiler
  "V"    #'set-variable
  "W"    #'+default/man-or-woman
  "C-k"  #'describe-key-briefly
  "C-l"  #'describe-language-environment
  "C-m"  #'info-emacs-manual

  ;; Unbind `help-for-help'. Conflicts with which-key's help command for the
  ;; <leader> h prefix. It's already on ? and F1 anyway.
  "C-h"  nil

  ;; replacement keybinds
  ;; replaces `info-emacs-manual' b/c it's on C-m now
  "r"    nil
  "rr"   #'doom/reload
  "rt"   #'doom/reload-theme
  "rp"   #'doom/reload-packages
  "rf"   #'doom/reload-font
  "re"   #'doom/reload-env

  ;; replaces `apropos-documentation' b/c `apropos' covers this
  "d"    nil
  "d/"   #'doom/help-search
  "da"   #'doom/help-autodefs
  "db"   #'doom/report-bug
  "dd"   #'doom/toggle-debug-mode
  "df"   #'doom/help-faq
  "dh"   #'doom/help
  "dm"   #'doom/help-modules
  "dn"   #'doom/help-news
  "dN"   #'doom/help-news-search
  "dp"   #'doom/help-packages
  "dP"   #'doom/help-package-homepage
  "dc"   #'doom/help-package-config
  "ds"   #'doom/sandbox
  "dt"   #'doom/toggle-profiler
  "dv"   #'doom/version

  ;; replaces `apropos-command'
  "a"    #'apropos
  ;; replaces `describe-copying' b/c not useful
  "C-c"  #'describe-coding-system
  ;; replaces `Info-got-emacs-command-node' b/c redundant w/ `Info-goto-node'
  "F"    #'describe-face
  ;; replaces `view-hello-file' b/c annoying
  "h" #'helpful-at-point
  ;; replaces `describe-language-environment' b/c remapped to C-l
  "L"    #'global-command-log-mode
  ;; replaces `view-emacs-news' b/c it's on C-n too
  "n"    #'doom/help-news
  ;; replaces `finder-by-keyword'
  "o"    #'ace-link-help
  ;; "p"    #'doom/help-packages
  "p"    #'describe-package
  ;; replaces `describe-package' b/c redundant w/ `doom/describe-package'
  "P"    #'find-library)
