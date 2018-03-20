;;----------------------------------------------------------------------------
;; Set font
;;----------------------------------------------------------------------------
;;(set-language-environment 'UTF-8)
;;(set-locale-environment "UTF-8")
;;(set-keyboard-coding-system 'utf-8)
;;(set-clipboard-coding-system 'euc-cn)
;;(set-terminal-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'euc-cn)
;;(set-selection-coding-system 'euc-cn)
;;(modify-coding-system-alist 'process "*" 'utf-8)
;;(setq default-process-coding-system '(euc-cn . euc-cn))
;;(setq-default pathname-coding-system 'utf-8)

;; (set-language-environment 'utf-8)
;; (set-locale-environment "utf-8")
;; (set-keyboard-coding-system 'utf-8-unix)
;; (set-clipboard-coding-system 'utf-8-unix)
;; (set-terminal-coding-system 'utf-8-unix)
;; (set-buffer-file-coding-system 'utf-8-unix)
;; (set-selection-coding-system 'utf-8-unix)
;; (modify-coding-system-alist 'process "*" 'utf-8-unix)
;; (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
;; (setq-default pathname-coding-system 'utf-8-unix)


(setq default-buffer-file-coding-system 'utf-8)
(setq current-language-environment "UTF-8")
(set-language-environment "UTF-8")
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-w32-system-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;;   支持从外部粘贴中文
;; MS Windows clipboard is UTF-16LE
(set-clipboard-coding-system 'utf-16le-dos)


;; (when *is-a-windows*
;;   (set-frame-font "Consolas 14")
;;   ;;Set Chinese-fonts
;;   (set-fontset-font "fontset-default" 'unicode "Microsoft YaHei 15"))

(when (display-graphic-p)
  (setq fonts
        (cond (*is-a-mac*     '("Monaco"              "STHeiti"))
              (*is-a-linux*   '("Menlo"     "WenQuanYi Zen Hei"))
              (*is-a-windows* '("Consolas"  "Microsoft YaHei UI"))))

  (setq face-font-rescale-alist '(("STHeiti" . 1.2) ("Microsoft YaHei UI" . 1.1) ("微软雅黑" . 1.1) ("WenQuanYi Zen Hei" . 1.2)))  ;; ("微软雅黑 or Microsoft Yahei" . 1.2)

  (set-face-attribute 'default nil :font
                      (cond (*is-a-mac*       (format "%s:pixelsize=%d" (car fonts) 14))
                            (*is-a-windows* (format "%s:pixelsize=%d" (car fonts) 16))))

  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family (car (cdr fonts))))))



;; 外观设置

;;禁用工具栏
(tool-bar-mode -1)

;;禁用菜单栏，F10 开启关闭菜单
(menu-bar-mode -1)

;;禁用滚动栏，用鼠标滚轮代替
;; (scroll-bar-mode nil)

;;禁用启动画面
(setq inhibit-startup-message t)

;;打开org模式根据大纲缩进内容
(setq org-startup-indented t)
;;使用org-mode打开txt文档
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;;----------------------------------------------------------------------------
;; 缓冲区
;;----------------------------------------------------------------------------

;;设定行距
(setq line-spacing 0)

;; line wrap
(setq-default fill-column 120)

;;缺省模式 text-mode
(setq major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;设置删除纪录
(setq kill-ring-max 200)

;;以空行结束
(setq require-final-newline t)

;;语法高亮
(global-font-lock-mode t)

;;高亮显示区域选择
(transient-mark-mode t)

;;高亮显示当前行
(global-hl-line-mode t)

;; 全局显示行号
(global-linum-mode 1)

;;页面平滑滚动， scroll-margin 5 靠近屏幕边沿3行时开始滚动，可以很好的看到上下文。
(setq scroll-margin 5
      scroll-conservatively 10000)

;;高亮显示成对括号时，但不来回弹跳
(setq show-paren-style 'parentheses)

;;鼠标指针规避光标
(mouse-avoidance-mode 'animate)


;;----------------------------------------------------------------------------
;; 回显区
;;----------------------------------------------------------------------------

;;闪屏报警
(setq visible-bell t)

;;使用 y or n 提问
(fset 'yes-or-no-p 'y-or-n-p)

;;锁定行高
(setq resize-mini-windows nil)

;;递归 minibuffer
(setq enable-recursive-minibuffers t)

;; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键。
;; (setq suggest-key-bindings 1)



;; 状态栏 mode-line

;;----------------------------------------------------------------------------
;; 时间格式
;;----------------------------------------------------------------------------
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
;; (setq display-time-interval 10)

;; 显示时间
;; (display-time)
;; (display-time-mode 1)

;;显示行号和列号
;;(setq column-number-mode t)
;;(setq line-number-mode t)

;; buffer 显示文件size
(size-indication-mode t)



;;标题栏
;;%f 缓冲区完整路径 %p 页面百分数 %l 行号 %I 文件大小
;;================   (setq frame-title-format "%f %I")
;; emacs , 下面的代码可以在frame title 上
;; 区分不同的主机和用户名称。

(setq frame-title-format '((:eval (if *is-a-windows*
                                      (getenv-internal "USERNAME")
                                    (getenv-internal "USER"))) ;;显示登陆名称LOGNAME
                           "@"
                           (:eval (system-name));;显示主机名称
                           "    "
                           (:eval (or (buffer-file-name) (buffer-name)))
                           ;;                           "    %I"
                           ) )



;; 编辑器设定

;;关闭响铃
(setq visible-bell t)

;;备份文件放在backup目录下
(defun make-backup-file-name (file-name)
  "define backup directory"
  (if (not (file-exists-p "~/.emacs.d/backup"))
      (make-directory "~/.emacs.d/backup"))
  (concat (expand-file-name "~/.emacs.d/backup/")
          (file-name-nondirectory file-name)
          ""))

;;自动生成备份文件
(setq make-backup-files t)

;;不生成名为#filename#的临时文件
(setq auto-save-default nil)

;;只渲染当前屏幕语法高亮，加快显示速度
(setq font-lock-maximum-decoration t)

;;让Emacs可以直接打开、显示图片
(auto-image-file-mode t)

;;支持和外部程序的拷贝
(setq select-enable-clipboard t)

;;设置宽和高
;;(setq default-frame-alist
;;'((height . 48) (width . 200) (top . 20) (left . 20)))
;;started maximize
(when *is-a-windows*
  (run-with-idle-timer 0.0 nil 'w32-send-sys-command 61488))


;;----------------------------------------------------------------------------
;;将错误信息显示在回显区
;;----------------------------------------------------------------------------
;; (condition-case err
;;     (progn
;;       (require 'xxx) )
;;   (error
;;    (message "Can't load xxx-mode %s" (cdr err))))


;;----------------------------------------------------------------------------
;; 使用空格缩进,indent-tabs-mode; t 使用 TAB 作格式化字符, nil 使用空格作格式化字符
;;----------------------------------------------------------------------------
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)
;;将一个Tab键转成4个空格键
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)



;; 颜色设置

;; 指针颜色
;; (set-cursor-color "black")

;; 鼠标颜色
;; (set-mouse-color "black")


(provide 'init-local)
