(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(setq inhibit-splash-screen t)

;; Keybindings.
(global-set-key (kbd "<f6>") 'compile)

;; Own customiziations.
(c-add-style "my-style"
			 '("stroustrup"
			   (c-basic-offset . 4)
			   (tab-width . 4)
			   (c-offsets-alist . ((case-label . +)
					       (inclass . ++)
					       (access-label . -)))))

(setq c-default-style "my-style")
;; Use C++ sytle comments in c-mode.
(add-hook 'c-mode-hook (lambda() (setq comment-start "// "
				       comment-end "")))
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
(global-set-key (kbd "C-`") 'sr-speedbar-toggle)
(global-set-key (kbd "C-c C-c") `sr-speedbar-toggle)

;; Package: smartparens
(require 'smartparens)
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; When you press RET, the curly braces automatically
;; add another newline.
(sp-with-modes '(c-mode c++-mode cc-mode go-mode ld-script-mode qml-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))
(sp-local-pair `bison-mode "%{" "%}" :post-handlers `(("||\n[i]" "RET")))
;; Might be need as a bug fix, comment out in future to check.
(sp-pair "'" "'")

;; Package: semantic
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)
(global-semantic-decoration-mode 1)
;; C++ related.
;; Embedded related.
;;(semantic-add-system-include "/usr/avr/include" 'c-mode)
;;(semantic-add-system-include "/usr/avr/include" 'c++-mode)
(semantic-add-system-include "/home/liquidsquid/x-tools/avr/avr/include/" 'c-mode)
(semantic-add-system-include "/home/liquidsquid/x-tools/avr/avr/include/" 'c++-mode)
(semantic-add-system-include "/opt/microchip/xc8/v2.00/pic/include" 'c-mode)

;; Project mangement system.
(global-ede-mode 1)

;; Package: company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-[") 'company-complete)
(defun my/c-mode-hook ()
  (require 'company-c-headers)
  (add-to-list 'company-backends 'company-c-headers)
  ;; C++ headers.
  ;; Emedded related headers.
  ;;(add-to-list 'company-c-headers-path-system "/usr/avr/include")
  (add-to-list 'company-c-headers-path-system "/home/liquidsquid/x-tools/avr/avr/include/avr")
  )
(add-hook 'c-mode-common-hook 'my/c-mode-hook)
(defun my/go-mode-hook ()
  (require 'company-go)
  (add-to-list 'company-backends 'company-go))
(add-hook 'go-mode-hook 'my/go-mode-hook)
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)
(defun my/qml-mode-hook ()
  (add-to-list 'company-backends 'company-qml))
(add-hook 'qml-mode-hook 'my/qml-mode-hook)

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
;; When in GUI.
(if (display-graphic-p)
    (setq whitespace-style '(face tabs spaces trailing lines-tail space-before-tab
				  newline indentation empty space-after-tab
				  space-mark tab-mark newline-mark)))
;; When in terminal.
(if (not (display-graphic-p))
    (setq  whitespace-style '(face space-mark tab-mark newline-mark
				   lines-tail trailing)))
(setq whitespace-display-mappings
      '(
	(space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
	(newline-mark 10 [8629 10]) ; LINE FEED,
	(tab-mark 9 [187 9] [92 9]) ; tab
	))

;; Package: yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
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

;; Package: bison-mode
(require 'bison-mode)
(setq bison-decl-token-column 0)
(setq bison-rule-enumeration-column 12)
(put 'upcase-region 'disabled nil)

;; Package: ruler-mode
(require 'ruler-mode)
(add-hook 'window-configuration-change-hook (lambda () (ruler-mode 1)))

;; Package: srefactor
(require 'srefactor)
(require 'srefactor-lisp)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
