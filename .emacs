(package-initialize)

(setq custom-file "~/.emacs.d/.custom.el")

(add-to-list 'default-frame-alist `(font . "Iosevka-15"))
(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
(load "~/.emacs.rc/autocommit-rc.el")

(load-file custom-file)

(rc/require-theme 'gruber-darker)


(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(show-paren-mode 1)
(setq inhibit-startup-screen t)

(rc/require 'smex 'ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))


;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)


;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 0)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))


(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)


;;; helm
;(rc/require 'helm 'helm-git-grep 'helm-ls-git)

;; (setq helm-ff-transformer-show-only-basename nil)

;; (global-set-key (kbd "C-c h t") 'helm-cmd-t)
;; (global-set-key (kbd "C-c h g g") 'helm-git-grep)
;; (global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
;; (global-set-key (kbd "C-c h f") 'helm-find)
;; (global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
;; (global-set-key (kbd "C-c h r") 'helm-recentf)


;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; yasnippet
(rc/require 'yasnippet)

(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.d/.snippets/"))

(yas-global-mode 1)

;;; Company
(rc/require 'company)
(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

(with-eval-after-load 'company
  (setq company-idle-delay 0.1          ; 稍微给一点延迟 (0.1s)，避免打字太快时闪烁
        company-minimum-prefix-length 2  ; 打两个字母再提示，防止干扰
        company-tooltip-limit 10
        company-require-match nil        ; 允许输入不在列表中的内容
        company-dabbrev-ignore-case t    ; 补全忽略大小写
        company-dabbrev-downcase nil)    ; 保持你输入的大小写，不要强制转小写

  ;; 确保在补全菜单开启时，M-n/M-p 正常工作
  (define-key company-active-map (kbd "M-n") 'company-select-next)
  (define-key company-active-map (kbd "M-p") 'company-select-previous)
  ;; 用 TAB 选下一个，回车确认
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "S-<tab>") 'company-select-previous)
  (define-key company-active-map (kbd "<return>") 'company-complete-selection))

(setq-default company-backends
              '((company-capf             ; 尝试从当前模式的语法中找
                 company-dabbrev-code     ; 从代码块中找单词
                 company-keywords         ; 语言关键字 (if, else, def...)
                 company-files)           ; 补全路径
                (company-dabbrev)))       ; 最后实在找不到，从所有打开的文本里找
;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(require 'compile)

;; pascalik.pas(24,44) Error: Can't evaluate constant expression

compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))




(add-hook 'org-mode-hook 'org-indent-mode)

(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)


(setq ido-auto-merge-work-directories-length -1)

(use-package conda
  :ensure t
  :after (projectile)
  :custom
  (conda-anaconda-home "/home/luke/miniconda3")
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t))

(electric-pair-mode 1)

(defun rc/open-line-below ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(global-set-key (kbd "<C-return>") 'rc/open-line-below)

(defun rc/open-line-above ()
  (interactive)
  (beginning-of-line)
  (open-line 1)
  (indent-according-to-mode))

(global-set-key (kbd "<C-S-return>") 'rc/open-line-above)

;;lsp
;; (rc/require 'lsp-mode)
;; (rc/require 'lsp-pyright)

;; (add-hook 'python-mode-hook #'lsp-deferred)

;; (with-eval-after-load 'company
;;   (setq company-idle-delay nil
;;         company-minimum-prefix-length 1
;;         company-tooltip-limit 10))

;; ;; 配合 Conda 配置
;; (setq lsp-pyright-python-executable-cmd "/home/luke/miniconda3/bin/python")

;; (add-hook 'c-mode-hook #'lsp-deferred)
;; (add-hook 'c++-mode-hook #'lsp-deferred)

;; (rc/require 'lsp-ui)
;; (setq lsp-ui-doc-enable t
;;       lsp-ui-doc-position 'at-point)

;; (with-eval-after-load 'company
;;   (define-key company-active-map (kbd "M-p") #'company-select-previous)
;;   (define-key company-active-map (kbd "M-n") #'company-select-next))

;; (setq lsp-headerline-breadcrumb-enable nil)

;; (defun rc/smart-tab ()

;;   (interactive)
;;   (if (company-manual-begin)
;;       (company-complete-common)
;;     (indent-for-tab-command)))

;; (with-eval-after-load 'python-mode
;;   (define-key python-mode-map (kbd "<tab>") 'rc/smart-tab))

;; (with-eval-after-load 'cc-mode
;;   (define-key c-mode-map (kbd "<tab>") 'rc/smart-tab)
;;   (define-key c++-mode-map (kbd "<tab>") 'rc/smart-tab))
