(require-package 'evil)

;;设置启动emacs载入evil
(require 'evil)

(evil-mode 1)
;; 这个是打开文件后默认进入emacs模式
;; (setq evil-default-state 'emacs)

;; 下面4行是设置使用C-d作为ESC按键，这个自己看吧
;; (define-key evil-insert-state-map (kbd "ESC") 'evil-change-to-previous-state)
;; (define-key evil-normal-state-map (kbd "ESC") 'evil-force-normal-state)
;; (define-key evil-replace-state-map (kbd "ESC") 'evil-normal-state)
;; (define-key evil-visual-state-map (kbd "ESC") 'evil-exit-visual-state)

;; 以下设置时使用t作为多剪贴板的起始按键，比如 tay(不是 "ay哦) tap(就是"ap啦)~
;; (define-key evil-normal-state-map "t" 'evil-use-register)


;;完全模拟 Vim，除去 Ctr-z 切换模式。调整为 Insert 模式下恢复 Emacs 键绑定，用 Esc 退到 Normal 模式

;;----------------------------------------------------------------------------
;; remove default evil-toggle-key C-z, manually setup later
;;----------------------------------------------------------------------------
(setq evil-toggle-key "")

;;----------------------------------------------------------------------------
;; remove all keybindings from insert-state keymap, use emacs-state when editing
;;----------------------------------------------------------------------------
(setcdr evil-insert-state-map nil)

;;----------------------------------------------------------------------------
;; ESC to switch back normal-state
;;----------------------------------------------------------------------------
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;;----------------------------------------------------------------------------
;; TAB to indent in normal-state
;;----------------------------------------------------------------------------
(define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)

;;----------------------------------------------------------------------------
;; C-o按键调用vim功能（就是临时进入normal模式，然后自动回来）
;;----------------------------------------------------------------------------
(define-key evil-insert-state-map (kbd "C-o") 'evil-execute-in-normal-state)
;; 比如，你要到第一行，可以使用emacs的 M-<，也可以使用evil的C-o gg
;; 其中C-o是进入vim模式 gg是去第一行，命令之后自动还原emacs模式！
;; "Fuck you!" 如何删除""里面的内容呢？Emacs的话，默认文本对象能力不强
;; 有了evil的拓展 C-o di" 轻轻松松搞定~
;; 比如C-o 3dd C-o dib C-o yy C-o p C-o f * 舒服啊~发挥想象力吧

;; Use j/k to move one visual line insted of gj/gk
;; (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

;;----------------------------------------------------------------------------
;; vim 的自动补全
;;----------------------------------------------------------------------------
(define-key evil-insert-state-map (kbd "C-n") 'evil-complete-next)
(define-key evil-insert-state-map (kbd "C-p") 'evil-complete-previous)


(provide 'init-evil-mode)
