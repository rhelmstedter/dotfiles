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

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(setq
    doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15)
    doom-variable-pitch-font (font-spec :family "Source Serif Pro" :size 15)
    doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 36))
(setq +zen-text-scale 1)
(setq-default fill-column 100)

(after! org
  (setq
   display-line-numbers-type 'nil
   visual-line-mode 't
   evil-shift-width 4
   global-hl-line-modes 'nil
   org-cycle-emulate-tab '(white)
   org-directory "~/Dropbox/org/"
   org-mobile-directory "~/Dropbox/Apps/MobileOrg"
   org-ellipsis " ▾ "
   org-hide-emphasis-markers 't
   org-log-done 'time
   org-superstar-headline-bullets-list '("⁖" "◈" "◇" "◉" "○"))
  (setq-default indent-tabs-mode nil))
(setq ispell-personal-dictionary "~/.emacs.d/.local/etc/ispell/.pws")
(setq ispell-program-name "/opt/homebrew/bin/aspell")
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)

(after! org
  (setq
   org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\\.org$")
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-todo-keywords
   '((sequence "TODO(t)" "WAIT(w@/!)" "PROJ(p)" "MEET(m)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)"))
   ;; org-todo-keywords-for-agenda
   ;; '((sequence "TODO(t)" "WAIT(w)" "PROJ(p)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)"))
   )
  (setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("WAIT" . (:foreground "#e45649" :weight bold))))
  (setq
   org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)
  (setq org-agenda-custom-commands
        '(("n" "Custom Agenda View"
           ((tags "IDEA"
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "IDEA Academy Tasks:")))
            (tags "WORK"
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Work Tasks:")))
            (tags "VUEA"
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "VUEA Tasks:")))
            (tags "PYBITES"
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "PYBITES Tasks:")))
            (alltodo ""))))))

(setq org-refile-targes '((org-agenda-files :maxlevel . 3)))
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (ipython . t)
   (emacs-lisp . t)))

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

;; (setq org-element--cache-self-verify 'backtrace)
;; (setq org-element--cache-self-verify-frequency 1.0)

(map! :after org
      :map org-mode-map
      :n "<backspace>" #'org-mark-ring-goto)

(map! :after org
      :map org-mode-map
      :n "SPC d" #'ispell-change-dictionary)

(setq org-roam-directory "~/Dropbox/roam")
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
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(use-package ox-epub
  :demand t)

(require 'ox-org)

(require 'org-auto-tangle)
(add-hook 'org-mode-hook 'org-auto-tangle-mode)

;; (use-package flycheck-languagetool
;;   :ensure t
;;   :hook (text-mode . flycheck-languagetool-setup)
;;   :init
;;   (setq flycheck-languagetool-server-jar "~/LanguageTool-6.4/languagetool-server.jar")
;;   (setq langtool-user-arguments '("--disable" "MORFOLOGIK_RULE_EN_US,WANT,EN_UNPAIRED_QUOTES")))
(use-package languagetool
  :ensure t
  :defer t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :config
  (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "~/LanguageTool-6.4/languagetool-commandline.jar"
        languagetool-server-command "~/LanguageTool-6.4/languagetool-server.jar"))

(use-package org2blog
             :ensure t)
(setq org2blog/wp-blog-alist
      '(("pybit.es"
         :url "https://pybit.es/wordpress/xmlrpc.php"
         :username "russellh")))

(setq projectile-project-search-path '("~/code" "~/Dropbox/org/roam"))

;; (pyenv-mode)
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))
(add-hook 'python-base-mode-hook 'flymake-mode)
(setq python-flymake-command '("ruff" "--quiet" "--stdin-filename=stdin" "-"))
(use-package! python-pytest)
(use-package! pyimport)
(setq python-indent-offset 0)
(setq org-edit-src-content-indentation 0)

;; Replace default (black) to use ruff for sorting import and formatting.
;; (setf (alist-get 'python-mode apheleia-mode-alist)
;;       '(ruff-isort ruff))
;; (setf (alist-get 'python-ts-mode apheleia-mode-alist)
;;       '(ruff-isort ruff))

;; clear code results
(map! :after org
      :map org-mode-map
      :n "SPC r" #'jupyter-org-clear-all-results)
(setq python-shell-completion-native-enable nil)

(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "python3 %s" (file-name-nondirectory buffer-file-name)))))
;; Babel
(setq org-babel-python-command "python3 -i -c \"import sys;sys.stderr=sys.stdout\"")
(add-to-list 'org-structure-template-alist
             '("p" . "src python :results output\n"))

(add-to-list 'org-structure-template-alist
             '("pe" . "src python :exports both :results output\n"))

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

;;;; load mu4e from the installation path.
;;(use-package mu4e
;;  :load-path  "/usr/local/share/emacs/site-lisp/mu/mu4e/")
;;
;;;; for sending mails
;;(require 'smtpmail)
;;;; we installed this with homebrew
;;(setq mu4e-mu-binary (executable-find "/opt/homebrew/bin/mu"))
;;
;;;; this is the directory we created before:
;;(setq mu4e-maildir "~/.maildir")
;;
;;;; this command is called to sync imap servers:
;;(setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))
;;
;;;; how often to call it in seconds:
;;(setq mu4e-update-interval 300)
;;
;;;; save attachment to downloads by default
;;(setq mu4e-attachment-dir "~/Download")
;;
;;;; rename files when moving - needed for mbsync:
;;(setq mu4e-change-filenames-when-moving t)
;;
;;;; list of your email adresses:
;;(setq mu4e-user-mail-address-list '("rhelmstedter@gmail.com"))

;;;; check your ~/.maildir to see how the subdirectories are called
;;;; for the generic imap account:
;;;; e.g `ls ~/.maildir/example'
;;
;;(setq   mu4e-maildir-shortcuts
;;        '(("/gmail/INBOX" . ?g)
;;          ("/gmail/[Gmail]/Sent Mail" . ?G)))
;;
;;;; (add-to-list 'mu4e-bookmarks
;;;;              (make-mu4e-bookmark
;;;;               :name "Inbox - Gmail"
;;;;               :query "maildir:/gmail/INBOX"
;;;;               :key ?g))

;; (setq mu4e-contexts
;;       `(,(make-mu4e-context
;;           :name "gmail"
;;           :enter-func
;;           (lambda () (mu4e-message "Enter rhelmstedter@gmail.com context"))
;;           :leave-func
;;           (lambda () (mu4e-message "Leave rhelmstedter@gmail.com context"))
;;           :match-func
;;           (lambda (msg)
;;             (when msg
;;               (mu4e-message-contact-field-matches msg
;;                                                   :to "rhelmstedter@gmail.com")))
;;           :vars '((user-mail-address . "rhelmstedter@gmail.com")
;;                   (user-full-name . "Russell Helmstedter")
;;                   (mu4e-drafts-folder . "/gmail/Drafts")
;;                   (mu4e-refile-folder . "/gmail/Archive")
;;                   (mu4e-sent-folder . "/gmail/Sent")
;;                   (mu4e-trash-folder . "/gmail/Trash"))))

;; (setq mu4e-context-policy 'pick-first) ;; start with the first (default) context;
;; (setq mu4e-compose-context-policy 'ask) ;; ask for context if no context matches;

;;;; gpg encryptiom & decryption:
;;;; this can be left alone
;;(require 'epa-file)
;;(epa-file-enable)
;;(setq epa-pinentry-mode 'loopback)
;;(auth-source-forget-all-cached)
;;
;;;; don't keep message compose buffers around after sending:
;;(setq message-kill-buffer-on-exit t)
;;
;;;; send function:
;;(setq send-mail-function 'sendmail-send-it
;;      message-send-mail-function 'sendmail-send-it)
;;
;;;; send program:
;;;; this is exeranal. remember we installed it before.
;;(setq sendmail-program (executable-find "msmtp"))
;;
;;;; select the right sender email from the context.
;;(setq message-sendmail-envelope-from 'header)
;;
;;;; chose from account before sending
;;;; this is a custom function that works for me.
;;;; well I stole it somewhere long ago.
;;;; I suggest using it to make matters easy
;;;; of course adjust the email adresses and account descriptions
;;(defun timu/set-msmtp-account ()
;;  (if (message-mail-p)
;;      (save-excursion
;;        (let*
;;            ((from (save-restriction
;;                     (message-narrow-to-headers)
;;                     (message-fetch-field "from")))
;;             (account
;;              (cond
;;               ((string-match "rhelmstedter@gmail.com" from) "gmail"))))
;;          (setq message-sendmail-extra-arguments (list '"-a" account))))))
;;
;;(add-hook 'message-send-mail-hook 'timu/set-msmtp-account)
;;
;;;; mu4e cc & bcc
;;;; this is custom as well
;;(add-hook 'mu4e-compose-mode-hook
;;          (defun timu/add-cc-and-bcc ()
;;            "My Function to automatically add Cc & Bcc: headers.
;;    This is in the mu4e compose mode."
;;            (save-excursion (message-add-header "Cc:\n"))
;;            (save-excursion (message-add-header "Bcc:\n"))))
;;
;;;; mu4e address completion
;;(add-hook 'mu4e-compose-mode-hook 'company-mode)

;;;; store link to message if in header view, not to header query:
;;(setq org-mu4e-link-query-in-headers-mode nil)
;;;; don't have to confirm when quitting:
;;(setq mu4e-confirm-quit nil)
;;;; number of visible headers in horizontal split view:
;;(setq mu4e-headers-visible-lines 20)
;;;; don't show threading by default:
;;(setq mu4e-headers-show-threads nil)
;;;; hide annoying "mu4e Retrieving mail..." msg in mini buffer:
;;(setq mu4e-hide-index-messages t)
;;;; customize the reply-quote-string:
;;(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M :\n")
;;;; M-x find-function RET message-citation-line-format for docs:
;;(setq message-citation-line-function 'message-insert-formatted-citation-line)
;;;; by default do not show related emails:
;;(setq mu4e-headers-include-related nil)
;;;; by default do not show threads:
;;(setq mu4e-headers-show-threads nil)
;;
;;(require 'mu4e-contrib)
;;(setq mu4e-html2text-command 'mu4e-shr2text)
;;;;(setq mu4e-html2text-command "iconv -c -t utf-8 | pandoc -f html -t plain")
;;(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)
