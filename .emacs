
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-enabled-themes (quote (wheatgrass)))
;;  '(custom-safe-themes (quote ("0f2411f632019ef9fb71a14a84eaaf00407feba56ae1f6840f7915beecbe1a40" "54e437ebedac98418d42a6dc87390f25b1448f2807272915616b7889bb3edad7" default))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))




(setq inhibit-startup-message t)
;; basic configs

(setq column-number-mode t)
(global-set-key [(control h)] 'delete-backward-char)
(setq standard-indent 2)
(local-set-key [tab] 'tab-to-tab-stop)

;; below this is paragraph is where we add any and 
;; all package repositories


; list the packages you want
(setq package-list '(ace-jump-mode auctex company-jedi))

(when (>= emacs-major-version 24)
  ;; package.el
  (require 'package)
  
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives 
	       '("org" . "http://orgmode.org/elpa/") t)
  
  (package-initialize)

)
;; activate all the packages (in particular autoloads)
;; (package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))



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

(global-set-key (kbd "\C-x /") 'python-workspace)
(global-set-key (kbd "\C-x #") 'comment-region)
(global-set-key (kbd "\C-x ,") 'code-block)
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
  (next-multiframe-window)
)

;; (defun python-template()
;;   (interactive)
;;   (insert "#############################")
;;   (insert "#\n")
;;   (insert "#\n")
;;   (insert "#")
;;   (insert (getenv "USER"))
;;   (insert "#\n")
;;   (insert "#")
;;   (insert (format-time-string "%Y-%m-%d"))
;;   (insert "\n")
;;   (insert "#################################")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "#start code here")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "def function_1(arg):")
;;   (insert "\n")
;;   (insert "    \"\"\"")
;;   (insert "\n")
;;   (insert "    \"\"\"")
;;   (insert "\n")
;;   (insert "    #some code")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "def main():")
;;   (insert "\n")
;;   (insert "    \"\"\"")
;;   (insert "    Main block of code for workflow")
;;   (insert "\n")
;;   (insert "    \"\"\"")
;;   (insert "\n")
;;   (insert "    #some code")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "\n")
;;   (insert "if __name__==\"__main__\":")
;;   (insert "\n")
;;   (insert "    main()")
;; )

;; (load-file "~/.emacs.d/emacs_ext/templates.el")


(defun code-block()
  (interactive)
  (insert "#+BEGIN_SRC bash\n\n")
  (insert "#+END_SRC")
  )


;; Planner setup
(condition-case nil


(add-to-list 'load-path "~/.elisp/muse/lisp")
(add-to-list 'load-path "~/.elisp/planner")
(add-to-list 'load-path "~/.elisp/remember")

(setq planner-project "WikiPlanner")
     (setq muse-project-alist
           '(("WikiPlanner"
             ("~/plans"   ;; Or wherever you want your planner files to be
             :default "index"
             :major-mode planner-mode
	          :visit-link planner-visit-link))))
     (require 'planner)

  (error nil))
;; ace jump mode

(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
    (require 'ace-jump-mode)
    (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; set tab stops
(add-hook 'python-mode-hook
      (lambda ()
        (setq-default indent-tabs-mode nil)
        (setq-default tab-width 4)
        (setq-default python-indent 4)))



;;org library
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(setq org-src-fontify-natively t)


(add-to-list 'load-path "~/.emacs.d/Other/")
