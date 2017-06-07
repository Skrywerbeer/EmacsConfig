(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:background "dark slate gray"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orchid"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark cyan"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "lawn green"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "gold"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orange red"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "dim gray"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "black")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(minimap-mode t)
 '(minimap-width-fraction 0.05)
 '(minimap-window-location (quote right))
 '(package-selected-packages
   (quote
	(drag-stuff company-irony irony cmake-ide whitespace-cleanup-mode indent-guide rainbow-delimiters rainbow-mode yasnippet smartparens company company-c-headers nyan-mode minimap sr-speedbar auto-complete))))
 '(sr-speedbar-right-side nil)

;; Own customiziations.
(defun my-insert-tab-char ()
  "Insert a tab char. (ASCII 9, \t)"
  (interactive)
  (insert "\t"))
(global-set-key (kbd "TAB") 'my-insert-tab-char)
(setq-default tab-width 4
			  c-basic-offset 4
			  indent-tabs-mode t)

(global-linum-mode t)

(tool-bar-mode -1)

(add-hook 'c-mode-common-hook
	  (lambda () (subword-mode 1)))
;; End personal customizations.

;; Package related.
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Speedbar
(require 'sr-speedbar)

;; Package: smartparens
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; When you press RET, the curly braces automatically
;; add another newline.
(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("\t|\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

;; Package: semantic
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)

;; Package: company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/usr/include/c++/6")

;; Package: rainbow-delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Package: indent-guide
(require 'indent-guide)
(add-hook 'prog-mode-hook 'indent-guide-mode)

;; Package: nyan-mode
(require 'nyan-mode)
(nyan-mode)
(nyan-toggle-wavy-trail)
(nyan-start-animation)
(setq nyan-minimum-window-width 32
      nyan-bar-length 20)

;; Package: WhiteSpace
(require 'whitespace)
(global-whitespace-mode)
  (setq whitespace-display-mappings
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [8629 10]) ; LINE FEED,
          (tab-mark 9 [187 9] [92 9]) ; tab
          ))

;; Package: irony
;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'objc-mode-hook 'irony-mode)
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Package: company-irony
;;(eval-after-load 'company
;;  '(add-to-list 'company-backends 'company-irony))

;; Package: minimap
(minimap-mode)

;; Package: yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Package: drag-stuff
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)
