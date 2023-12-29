;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq
  user-full-name "Russell Helmstedter"
  user-mail-address "rhelmstedter@gmail.com")

(add-to-list 'initial-frame-alist '(fullscreen . fullscreen))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(setq doom-theme 'doom-one )

(setq
   evil-shift-width 4
   global-hl-line-modes 'nil)

(setq
    doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15)
    doom-variable-pitch-font (font-spec :family "Source Serif Pro" :size 15)
    doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 36))
(setq +zen-text-scale 1)

(after! org
  (setq
   display-line-numbers-type 'nil
   visual-line-mode 't
   evil-shift-width 5
   global-hl-line-modes 'nil
   org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\\.org$")
   org-cycle-emulate-tab '(white)
   org-directory "~/Dropbox/org"
   org-mobile-directory "~/Dropbox/Apps/MobileOrg"
   org-ellipsis " ▾ "
   org-hide-emphasis-markers 't
   org-log-done 'time
   org-superstar-headline-bullets-list '("⁖" "◈" "◇" "◉" "○")
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-todo-keywords
   '((sequence "TODO(t)" "WAIT(w)" "STRT(s)" "|" "DONE(d)" "CANCELLED(c)"))
   org-todo-keywords-for-agenda
   '((sequence "TODO(t)" "WAIT(w)" "STRT(s)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-todo-keyword-faces
      '(("TODO" . org-warning)))
  (setq
   org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)
  (setq org-agenda-custom-commands
        '(("n" "A better agenda view"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-overriding-header "High-priority tasks:")))
            (tags "PRIORITY=\"B\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo '("TODO")))
                   (org-agenda-overriding-header "Medium-priority tasks:")))
            (tags "PRIORITY=\"C\""
                  ((org-agenda-overriding-header "Low-priority tasks:")))
            (tags "IDEA"
                  ((org-agenda-overriding-header "IDEA Academy tasks:")))

            (agenda "")
            (alltodo ""))))))

;; org-export timestamps
(custom-theme-set-faces
 'user
 '(org-date ((t (font-spec :family "JetBrainsMono Nerd Font" :size 12)))));
;; custom format to 'euro' timestamp
(setq org-time-stamp-custom-formats '("<%m/%d/%Y>" . "<%m/%d/%Y %a %H:%M>"))
;; function with hook on export
(defun my-org-export-ensure-custom-times (backend)
  (setq-local org-display-custom-times t))
(add-hook 'org-export-before-processing-functions 'my-org-export-ensure-custom-times)
;; remove brackets on export
(defun org-export-filter-timestamp-remove-brackets (timestamp backend info)
  "removes relevant brackets from a timestamp"
  (cond
   ((org-export-derived-backend-p backend 'latex)
    (replace-regexp-in-string "[<>]\\|[][]" "" timestamp))
   ((org-export-derived-backend-p backend 'html)
    (replace-regexp-in-string "&[lg]t;\\|[][]" "" timestamp))))
(eval-after-load 'ox '(add-to-list
                       'org-export-filter-timestamp-functions
                       'org-export-filter-timestamp-remove-brackets))
(after! org
  (set-face-attribute 'org-level-1 nil
                      :height 1.07
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      :height 1.05
                      :weight 'bold)
  (set-face-attribute 'org-level-3 nil
                      :height 1.025
                      :weight 'bold)
  (set-face-attribute 'org-document-title nil
                      :height 1.10
                      :weight 'bold))

;; custom time stamp heading
;; ====================
;; insert date and time

;; (defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
;;   "Format of date to insert with `insert-current-date-time' func
;; See help of `format-time-string' for possible replacements")

(defvar current-time-format "%H:%M"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

;; (defun insert-current-date-time ()
;;   "insert the current date and time into current buffer.
;; Uses `current-date-time-format' for the formatting the date/time."
;;        (interactive)
;;        (insert "*** ")
;; ;       (insert (let () (comment-start)))
;;        (insert (format-time-string current-date-time-format (current-time)))
;;        (insert "\n")
;;        )

(defun insert-current-time ()
  (interactive)
  (insert "**** ")
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n")
  )
;; (global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key (kbd "\C-c t") 'insert-current-time)
(map! :after org
      :map org-mode-map
      :n "<backspace>" #'org-mark-ring-goto)

(setq org-roam-directory "~/Dropbox/org/roam")
;; Roam Graph
(use-package! websocket
  :after org-roam)
(use-package! org-roam-ui
  :after org-roam
  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

;; (org-roam-capture-templates
;;  '(("d" "default" plain
;;     "%?"
;;     :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;     :unnarrowed t)
;;  ("p" "python" plain
;;   "%?\n#+BEGIN_SRC python\n\n\n#+END_SRC"
;;   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;   :unnarrowed t))))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq projectile-project-search-path '("~/code"))

(pyenv-mode)
(use-package! python-pytest)
(use-package! pyimport)

(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "python %s" (file-name-nondirectory buffer-file-name)))))

;; Use IPython for REPL
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;; You can use this hydra menu that have all the commands
(map! :n "C-SPC" 'harpoon-quick-menu-hydra)
(map! :n "C-s" 'harpoon-add-file)

;; And the vanilla commands
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)

(map! :leader "fg" #'deadgrep)
(map! "C-l" #'org-next-link)
(map! "C-k" #'org-previous-link)
