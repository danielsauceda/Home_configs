(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes (quote ("0f2411f632019ef9fb71a14a84eaaf00407feba56ae1f6840f7915beecbe1a40" "54e437ebedac98418d42a6dc87390f25b1448f2807272915616b7889bb3edad7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq inhibit-startup-message t)
;; basic configs
(setq column-number-mode t)
(global-set-key [(control h)] 'delete-backward-char)
(setq standard-indent 2)
(local-set-key [tab] 'tab-to-tab-stop)

;; below this is paragraph is where we add any and 
;; all package repositories

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))


;;screen appearance settings

;;python autocomplete hook for jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)



(put 'upcase-region 'disabled nil)
;;test comment

;; org mode dot
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot


;; ;; org mode --> latex Export
;; (require 'ox-latex)
;; (unless (boundp 'org-latex-classes)
;;   (setq org-latex-classes nil))
;; (add-to-list 'org-latex-classes
;;              '("article"
;;                "\\documentclass{article}"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))




;; org mode hooks
(add-hook 'org-mode-hook 
          (lambda ()
            (local-set-key "\M-n" 'outline-next-visible-heading)
            (local-set-key "\M-p" 'outline-previous-visible-heading)
            ;; table
            (local-set-key "\C-\M-w" 'org-table-copy-region)
            (local-set-key "\C-\M-y" 'org-table-paste-rectangle)
            (local-set-key "\C-\M-l" 'org-table-sort-lines)
            ;; display images
            (local-set-key "\M-I" 'org-toggle-iimage-in-org)
            ;; fix tab
            (local-set-key "\C-y" 'yank)))


;; tab autocomplete emacs Lisp
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)


;;USER DEFINED FUNCTIONS

;; (defun function-name (arguments…)
;;   "optional-documentation…"
;;   (interactive argument-passing-info)     ; optional
;;   body…)

;; python workspace


(defun python-workspace ()
  "opens up my personal emacs workspace
____________________________________
|      TEXT.py     | python terminal  | 
|                  |                  |
|                  |                  |
|                  |                  |
|                  |                  | 
|                  |                  |
|                  |                  |
|                  |------------------|
|                  | shell terminal   |
|                  |                  |
|                  |                  |
|                  |                  |
|                  |                  |
|                  |                  |
|                  |                  |
|__________________|__________________|
"
  (interactive)
  (split-window-right)
  (next-multiframe-window)
  (shell"python_shell")
  (insert "python")
  (execute-kbd-macro "\r")
  (split-window-below)
  (next-multiframe-window)
  (shell "bash_shell")
)

(defun python-template()
  (interactive)
  (insert "#############################")
  (insert "\n")
  (insert (getenv "USER"))
  (insert (format-time-string "%Y-%m-%d"))
  (insert "\n")
  (insert "#################################")

)

