;;-----------------------------------------------------------------------------
;; Init Stuff
;;-----------------------------------------------------------------------------

;; UTF-8 as default encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Disable GUI Features
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Load Paths
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Package repositories
(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(load-prefer-newer t)
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("elpa" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(magit ccls company-lsp company lsp-dart lsp-mode org-roam ob-nim nim-mode ob-dart org-wiki helm-core async visual-fill-column rainbow-identifiers dart-mode use-package)))

;; Refresh the package list
(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

;; Ensure use-package is installed
(when (not (package-installed-p 'use-package))
    (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Hook to report the start time of Emacs
(add-hook 'emacs-startup-hook
    (lambda ()
    (message "Emacs ready in %s with %d garbage collections."
                (format "%.2f seconds"
                        (float-time
                        (time-subtract after-init-time before-init-time)))
                gcs-done)))

;;-----------------------------------------------------------------------------
;; Generic Packages
;;-----------------------------------------------------------------------------

; Install QUELPA
;(use-package quelpa
;  :ensure t
;  :defer nil
;  :config
;  (quelpa
;    '(quelpa-use-package
;      :fetcher git
;      :url "https://github.com/quelpa/quelpa-use-package.git"))
;  (require 'quelpa-use-package))
;(require 'quelpa)
;(quelpa-use-package-activate-advice)

;; Auto compile files
(use-package auto-compile
    :ensure t
    :defer nil
    :config (auto-compile-on-load-mode))

;; Install which-key to ease the discovery of keybinds
(use-package which-key
    :ensure t
    :defer nil
    :diminish which-key-mode
    :config (which-key-mode))

;; Install Bind Key
(require 'bind-key)

;;-----------------------------------------------------------------------------
;; Emacs Powerline
;;-----------------------------------------------------------------------------

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

;;-----------------------------------------------------------------------------
;; Solarized Theme
;;-----------------------------------------------------------------------------
(use-package solarized-theme
  :ensure t
  :config 
  ;; Don't change size of org-mode headlines (but keep other size-changes)
  (setq solarized-scale-org-headlines nil)
  ;; Don't change the font for some headings and titles
  (setq solarized-use-variable-pitch nil))
  ;; Avoid all font-size changes
  (setq solarized-height-minus-1 1.0)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0)
  (load-theme 'solarized-dark t)

;;-----------------------------------------------------------------------------
;; Dired
;;-----------------------------------------------------------------------------
(eval-after-load "dired" '(progn
	(define-key dired-mode-map [backspace] 'dired-up-directory)))

;;-----------------------------------------------------------------------------
;; Magit
;;-----------------------------------------------------------------------------

(use-package magit
  :ensure t)

;;-----------------------------------------------------------------------------
;; Sunrise-Commander
;;-----------------------------------------------------------------------------

;(require 'sunrise)
;(global-set-key "\C-x\C-f" 'sunrise-cd)

;;-----------------------------------------------------------------------------
;; Visual basic Script Mode
;;-----------------------------------------------------------------------------

(require 'vbs-repl)
(setq auto-mode-alist
      (append '(("\\.\\(vbs\\|wsf\\)$" . vbscript-mode))
	      auto-mode-alist))


;;-----------------------------------------------------------------------------
;; Generic Settings
;;-----------------------------------------------------------------------------

(set-frame-font "DejaVu Sans Mono 12" nil t)
(setq column-number-mode t)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq-default display-line-numbers-width 4)

;;-----------------------------------------------------------------------------
;; Linum
;;-----------------------------------------------------------------------------
;
;(defvar my-linum-current-line-number 0)
;
;(setq linum-format 'my-linum-relative-line-numbers)
;
;(defun my-linum-relative-line-numbers (line-number)
  ;(let ((test2 (- line-number my-linum-current-line-number)))
    ;(propertize
     ;(number-to-string (cond ((<= test2 0) (* -1 test2))
                             ;((> test2 0) test2)))
     ;'face 'linum)))
;
;(defadvice linum-update (around my-linum-update)
  ;(let ((my-linum-current-line-number (line-number-at-pos)))
    ;ad-do-it))
;(ad-activate 'linum-update)
;
;(global-linum-mode t)

;;-----------------------------------------------------------------------------
;; ORG MODE
;;-----------------------------------------------------------------------------
(require 'org)

;; Agenda Files
(setq org-agenda-files '("C:\\Users\\florent.uguet\\OneDrive - VINCI Energies\\Perso\\org\\work"))
(setq org-log-done t)

;; Org Settings
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)

;; All org files
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'org-indent-mode)

;; Org Outlook
(require 'org-outlook)

;; Define the org mode keymaps
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-file-apps '(
    (auto-mode . emacs)
    ("\\.xlsx\\'" . default)
    ("\\.ahk\\'" . default)
    ("\\.vmx\\'" . "vmrun start %s")
    ("\\.pdf\\'" . default)))

;; Hide emphasis markers
(setq org-hide-emphasis-markers t)

;; Org Mode Todo Faces
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "READY(r)" "|" "DONE(d!)" "CANCELLED(c@)" "HOLD(h@)")
        ))

(setq org-todo-keyword-faces
    '(("TODO" . "#FFC0CB")
        ("NEXT" . "#FFFF00")
        ("STARTED" . "#FF0000")
        ("WAITING" . "#FFA500")
        ("READY" . "#FF8000")
        ("DONE" . "#00FF00")
        ("CANCELLED" . "#00FF00")))

;; Enable visual line mode
(add-hook 'org-mode-hook 'visual-line-mode)

;; Set the tags column align right at 80 columns
(setq org-tags-column 80)

;; Set the Agenda Custom Commands
(setq org-agenda-custom-commands
      '(("p" tags-todo "af|prog|tests|syno|mes|")
	 ("s" todo "STARTED")
	 ("n" todo "NEXT")))

;; TaskJuggler
(add-to-list 'org-export-backends 'taskjuggler)
(require 'ox-taskjuggler)
(setq org-taskjuggler-default-reports
'("textreport report \"Plan\" {
formats html
header '== %title =='
center -8<-
[#Plan Plan] | [#Resource_Allocation Resource Allocation]
----
=== Plan ===
<[report id=\"plan\"]>
----
=== Resource Allocation ===
<[report id=\"resourceGraph\"]>
->8-
}
# A traditional Gantt chart with a project overview.
taskreport plan \"\" {
headline \"Project Plan\"
columns bsi, name, start, end, effort, effortdone, effortleft, chart { width 1200 }
loadunit shortauto
hideresource 1
}
# A graph showing resource allocation. It identifies whether each
# resource is under- or over-allocated for.
resourcereport resourceGraph \"\" {
headline \"Resource Allocation Graph\"
columns no, name, effort, weekly { width 1200 }
loadunit shortauto
hidetask ~(isleaf() & isleaf_())
sorttasks plan.start.up
}")
)

;; Org Wiki Publishing
(setq org-publish-project-alist
    '(
        ("wiki-notes"
            :base-directory "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/wiki"
            :base-extension "org"
            :publishing-directory "S:/USERS/Florent.UGUET/wiki_html"
            :recursive t
            :publishing-function org-html-publish-to-html
            :headline-levels 4             ; Just the default for this project.
            :auto-preamble t
            )
        ("wiki-static"
            :base-directory "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/wiki"
            :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
            :publishing-directory "S:/USERS/Florent.UGUET/wiki_html"
            :recursive t
            :publishing-function org-publish-attachment
            )
        ("wiki" :components ("wiki-notes" "wiki-static"))
        
        ("roam-notes"
            :base-directory "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/roam"
            :base-extension "org"
            :publishing-directory "S:/USERS/Florent.UGUET/roam_html"
            :recursive t
            :publishing-function org-html-publish-to-html
            :headline-levels 4             ; Just the default for this project.
            :auto-preamble t
            )
        ("roam-static"
            :base-directory "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/roam"
            :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
            :publishing-directory "S:/USERS/Florent.UGUET/roam_html"
            :recursive t
            :publishing-function org-publish-attachment
            )
        ("roam" :components ("roam-notes" "roam-static"))
        
        ("brain-notes"
            :base-directory "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/brain"
            :base-extension "org"
            :publishing-directory "S:/USERS/Florent.UGUET/brain_html"
            :recursive t
            :publishing-function org-html-publish-to-html
            :headline-levels 4             ; Just the default for this project.
            :auto-preamble t
            )
        ("brain-static"
            :base-directory "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/brain"
            :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
            :publishing-directory "S:/USERS/Florent.UGUET/brain_html"
            :recursive t
            :publishing-function org-publish-attachment
            )
        ("brain" :components ("brain-notes" "brain-static"))
    ))


;;-----------------------------------------------------------------------------
;; Evil
;;-----------------------------------------------------------------------------

;; Download Evil
(unless (package-installed-p 'evil)
    (package-install 'evil))

;; Regain org-mode TAB functionality
(setq evil-want-C-i-jump nil)

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Workaround for the (evil-redirect-digit-argument) bug
; https://github.com/Somelauw/evil-org-mode/issues/93
;; Install Evil Org Mode
(use-package evil-org
    :ensure t
    :after org
    :preface (fset 'evil-redirect-digit-argument 'ignore)
    :hook (org-mode . (lambda () evil-org-mode))
    :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))

;;-----------------------------------------------------------------------------
;; Org Roam
;;-----------------------------------------------------------------------------

(use-package org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :custom
  (org-roam-directory (file-truename "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/roam"))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-db-location "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/roam/org-roam.db")
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  ;; Draft by default
  ;(defun jethro/tag-new-node-as-draft ()
  ;  (org-roam-tag-add '("draft")))
  ;(add-hook 'org-roam-capture-new-node-hook #'jethro/tag-new-node-as-draft)
  ;; Thought Inbox
  (setq org-capture-templates
      ;; other capture templates
      '(("s" "Slipbox" entry  (file "C:/Users/florent.uguet/OneDrive - VINCI Energies/Perso/org/roam/inbox.org")
       "* %?\n")))
  ;; Capture templates
  (setq org-roam-capture-templates
      '(("m" "main" plain
         "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new
         (file+head "reference/${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "article" plain "%?"
         :if-new
         (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t))))

;;-----------------------------------------------------------------------------
;; LSP
;;-----------------------------------------------------------------------------

(use-package flycheck
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook ((nim-mode dart-mode). lsp)
  :commands lsp)

(use-package company
  :ensure t)

;;-----------------------------------------------------------------------------
;; CCLS
;;-----------------------------------------------------------------------------

(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

;;-----------------------------------------------------------------------------
;; Dart Mode
;;-----------------------------------------------------------------------------

(use-package dart-mode
  :ensure t)

(use-package lsp-dart
  :ensure t)

(use-package ob-dart
  :ensure t
  :config (add-to-list 'org-babel-load-languages '(dart . t)))

(add-hook 'dart-mode-hook 'lsp)

;;-----------------------------------------------------------------------------
;; Nim Mode
;;-----------------------------------------------------------------------------

(use-package nim-mode
  :ensure t
  )

(use-package ob-nim
  :ensure t
  :config (add-to-list 'org-babel-load-languages '(nim . t)))

;; Org-Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;;-----------------------------------------------------------------------------
;; Faces
;;-----------------------------------------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 89)) (:foreground "#839496" :background "#002b36"))))
 '(org-level-1 ((t (:foreground "#BF9D7A"))))
 '(org-level-2 ((t (:foreground "#E4E9CD"))))
 '(org-level-3 ((t (:foreground "#EBF2EA"))))
 '(org-level-4 ((t (:foreground "#0ABDA0"))))
 '(org-level-5 ((t (:foreground "#80ADD7")))))
