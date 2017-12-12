;;=========================       sr-speedbar      ==========================
(require-package 'sr-speedbar)
(require 'sr-speedbar)

;;关闭图标
(setq speedbar-use-images nil)

;;左边显示
(setq sr-speedbar-right-side nil)

;;开启自动刷新
(setq sr-speedbar-auto-refresh t)

;;不自动刷新
;;(setq dframe-update-speed nil)

;;"*Verbosity level of the speedbar.  0 means say nothing.
;;1 means medium level verbosity.  2 and higher are higher levels of
;;verbosity."
(setq speedbar-verbosity-level 0)

;;宽度
(setq sr-speedbar-width 30)

;;显示所有文件
(setq speedbar-show-unknown-files t)

;;prevent the speedbar to update the current state, since it is always changing
(setq dframe-update-speed t)

;;多窗口切换时跳过speedbar窗口
(setq sr-speedbar-skip-other-window-p t)

;;turnoff linum-mode
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))

(provide 'init-sr-speedbar)
