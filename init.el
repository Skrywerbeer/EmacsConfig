(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(setq inhibit-splash-screen t)

;; Own customiziations.
(c-add-style "my-style"
			 '("stroustrup"
			   (c-basic-offset . 4)
			   (tab-width . 4)
			   (c-offsets-alist . ((case-label . +)
					       (inclass . ++)
					       (access-label . -)))))

(setq c-default-style "my-style")
(defun my-c-mode-hook ()
  ;empty for now.
)
;(add-hook 'c-mode-hook 'my-c-mode-hook)
;(add-hook 'c++-mode-hook 'my-c-mode-hook)

;(global-set-key (kbd "<f5>") (lambda ()
;                               (interactive)
;                               (setq-local compilation-read-command nil)
;                               (call-interactively 'compile)))

(setq-default ;tab-width 4
;			  c-basic-offset 4
			  indent-tabs-mode t)

(global-linum-mode t)
(column-number-mode t)

(tool-bar-mode -1)

(add-hook 'c-mode-common-hook
		  (lambda () (subword-mode 1)))

(setq python-shell-interpreter "python3"
	  python-shell-interpreter-args "-i")
;; Readline bug fix
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))
;; End bug fix
;; End personal customizations.

;; Package related.
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Speedbar
(require 'sr-speedbar)
(global-set-key (kbd "C-c `") 'sr-speedbar-toggle)

;; Package: smartparens
(require 'smartparens)
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; When you press RET, the curly braces automatically
;; add another newline.
(sp-with-modes '(c-mode c++-mode cc-mode go-mode, ld-script-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

;; Package: semantic
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)
(global-semantic-decoration-mode 1)
(semantic-add-system-include "/usr/lib/avr/include" 'c-mode)
(semantic-add-system-include "/usr/msp430/include" 'c-mode)
(semantic-add-system-include "/usr/lib/avr/include" 'c++-mode)
(semantic-add-system-include "/usr/msp430/include" 'c++mode)


;; Package: company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-[") 'company-complete)
(defun my/c-mode-hook ()
  (require 'company-c-headers)
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/6")
  (add-to-list 'company-c-headers-path-system "/usr/lib/avr/include")
  (add-to-list 'company-c-headers-path-system "/usr/msp430/include"))
(add-hook 'c-mode-common-hook 'my/c-mode-hook)
(defun my/go-mode-hook ()
  (require 'company-go)
  (add-to-list 'company-backends 'company-go))
(add-hook 'go-mode-hook 'my/go-mode-hook)
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

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
(setq whitespace-style '(face tabs spaces trailing lines-tail space-before-tab
								newline indentation empty space-after-tab
								space-mark tab-mark newline-mark))
;;(setq whitespace-style '(face empty tabs lines-tail trailing))
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
(add-hook 'minimap-sb-mode-hook (lambda () (setq mode-line-format nil)))

;; Package: yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Package: drag-stuff
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

;; Package: smart-mode-line
(require 'smart-mode-line)
(setq sml/theme 'powerline)
(sml/setup)

;; Package: anzu
(global-anzu-mode +1)

;; Package: modern-cpp-font-lock
(add-hook 'c++-mode #'modern-c++-font-lock-mode)
