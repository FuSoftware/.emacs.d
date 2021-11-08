;;-----------------------------------------------------------------------------
;; Init Stuff
;;-----------------------------------------------------------------------------

;; Package repositories
(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(load-prefer-newer t)
 '(package-archives
   (quote
    (("marmalade" . "https://marmalade-repo.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("elpa" . "https://elpa.gnu.org/packages/"))))
 '(package-selected-packages (quote (dart-mode use-package))))

;; Refresh the package list
(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

;; Ensure use-package is installed
(when (not (package-installed-p 'use-package))
    (package-install 'use-package))
(require 'use-package)

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

;; Install QUELPA
;(use-package quelpa
;    :defer nil
;    :config
;    (quelpa
;        '(quelpa-use-package
;            :fetcher git
;            :url "https://github.com/quelpa/quelpa-use-package.git"))
;    (require 'quelpa-use-package))
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
;; Generic Settings
;;-----------------------------------------------------------------------------

(set-frame-font "DejaVu Sans Mono 12" nil t)
(setq column-number-mode t)

;;-----------------------------------------------------------------------------
;; Dart Mode
;;-----------------------------------------------------------------------------

(use-package dart-mode
  :ensure t
  )

;;-----------------------------------------------------------------------------
;; ORG MODE
;;-----------------------------------------------------------------------------
(require 'org)

;; Agenda Files
(setq org-agenda-files '("C:\\Users\\florent.uguet\\OneDrive - VINCI Energies\\Perso\\org\\work"))
(setq org-log-done t)

;; All org files
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'org-indent-mode)

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
    (add-to-list 'evil-digit-bound-motions 'evil-org-beginning-of-line)
    (evil-define-key 'motion 'evil-org-mode
        (kbd "0") 'evil-org-beginning-of-line)
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))

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
