;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Russell Helmstedter"
      user-mail-address "rhelmstedter@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:

;; (setq doom-variable-pitch-font (font-spec :family "EBGaramond" :size 15))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Source Serif Pro" :size 16))
(setq +zen-text-scale 1)
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one )

(setq projectile-project-search-path '("~/code"))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org")
(setq org-hide-emphasis-markers 't)
;; (setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\\.org$"))
(setq default-directory "~/")
(setq org-roam-directory "~/roam")

;; ORG-EXPORT TIMESTAMPS
(custom-theme-set-faces
 'user
  '(org-date ((t (font-spec :family "JetBrainsMono Nerd Font" :size 12)))));
;; custom format to 'euro' timestamp
(setq org-time-stamp-custom-formats '("<%m/%d/%Y>" . "<%m/%d/%Y %a %H:%M>"))
;; function with hook on export
(defun my-org-export-ensure-custom-times (backend)
  (setq-local org-display-custom-times t))
(add-hook 'org-export-before-processing-hook 'my-org-export-ensure-custom-times)
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

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start nil))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
    ;; (org-roam-capture-templates
    ;;  '(("d" "default" plain
    ;;     "%?"
    ;;     :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
    ;;     :unnarrowed t)
    ;;  ("p" "python" plain
    ;;   "%?\n#+BEGIN_SRC python\n\n\n#+END_SRC"
    ;;   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
    ;;   :unnarrowed t))))

(map! :leader
      "fg" #'deadgrep)
(map! "C-l" #'org-next-link)
(map! "C-k" #'org-previous-link)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'nil)
(setq visual-line-mode 't)

;; This creates some nice headlines
(setq
    org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")
)
;; This opens emacs in fullscreen
(add-to-list 'initial-frame-alist '(fullscreen . fullscreen))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package python-pytest)
(use-package pyimport)
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
