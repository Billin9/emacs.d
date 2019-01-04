;;; init-hot-key.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2015

;; Author: <Bailm@ourgame-work>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

;;----------------------------------------------------------------------------
;; 多窗口相关操作
;;----------------------------------------------------------------------------

;;切换到其它window f1 ;; c-x o
(global-set-key (kbd "<f1>") 'switch-window)
;;
;; (global-set-key (kbd "<M-f1>") 'sanityinc/split-window)

;; 切换到dired模式 F2
(global-set-key [(f2)] 'dired)

;;查找并打开文件 F3
(global-set-key [(f3)] 'find-file)
;;以分割缓冲区打开文件 M-F3
(global-set-key [(M-f3)] 'ido-find-file-other-window)

;; switch buffer
(global-set-key [(f8)] 'ivy-switch-buffer)
;; 以分割缓冲区打开buffer M-B
;; (global-set-key "\C-xB" 'ido-switch-buffer-other-window)
(global-set-key [(M-f8)] 'ido-switch-buffer-other-window)

;;kill current window, kill buffer if current window is only one
(global-set-key [(f4)] 'delete-window-maybe-kill-buffer)
;;关闭当前window M-F4  ;; C-x 0
;; (global-set-key [(M-f4)] 'delete-window)

;;关闭其它window Alt+1  ;; C-x 1
(global-set-key "\M-1" 'delete-other-windows)
;;水平分割缓冲区 Alt+2  ;; C-x 2
(global-set-key "\M-2" (split-window-func-with-other-buffer 'split-window-vertically))
;;垂直分割缓冲区 Alt+3  ;; C-x 3
(global-set-key "\M-3" (split-window-func-with-other-buffer 'split-window-horizontally))



;; Global Hot Key

;;F1:切换buffer
;;(global-set-key [(f1)] 'other-window)

;; F2：切换到dired模式
;;(global-set-key [(f2)] 'dired)

;; F3：切换到shell模式
;;(global-set-key [(f3)] 'ansi-term)

;; F4:关闭buffer和同一buffer内的所有window (old)
;;(global-set-key [(f4)] 'kill-buffer-and-window)

;; F5：打开speedbar
;;(global-set-key [(f5)] 'sr-speedbar-toggle)
;;(global-set-key (kbd "<f5>") (lambda()
;;          (interactive)
;;          (sr-speedbar-toggle)))

;; F6: 跳到另一个窗口
;;(global-set-key [(f6)] 'other-window)

;; F7：编译
;;(global-set-key [(f7)] 'compile)

;; F9:gdb
;;(global-set-key [(f9)] 'gdb)

;; F10: gdb:next
;;(global-set-key [(f10)] 'gud-next)

;; F11: gdb:step
;;(global-set-key [(f11)] 'gud-step)

;;重新绑定C-z到撤销
;;(global-set-key (kbd "C-z") 'undo)

;;设置M-<SPC>作为标志位，默认C-@来setmark,C-@不太好用
;;(global-set-key (kbd "M-<SPC>") 'set-mark-command)

;; M-g跳到指定行
;; (global-set-key (kbd "M-g") 'goto-line)
;; (global-set-key [(meta g)] 'goto-line)



;; Define my mouse

;;左键的拖拉，可以选择一片区域，这片选择的region 就自动拷贝起来，  * Emacs默认配置
;; (global-set-key (kbd "<mouse-1>") 'mouse-set-point)
;; (global-set-key (kbd "<down-mouse-1>") 'mouse-drag-region)
;;鼠标右键粘贴
;;(global-set-key (kbd "<mouse-3>") 'mouse-yank-primary)
(global-set-key (kbd "<mouse-3>") 'yank)


;;===============       用鼠标快速 copy ,cut , paste           ===============
;;使用方法，把光标移动到要粘贴的地方，然后用按住 Alt + 拖 拉鼠标, 选择要拷贝的部分, 抬起鼠标,选择的部分就粘贴到了光 标所在位置.也就是说,一个动作完成 copy & paste 的工作,而 且不改变 kill ring 的内容, 用 windows 的术语是剪切板. 和 上面的方法类似,如果按住 Alt + Shift + 拖动鼠标,那么就会 完成 cut & paste 的功能.
;;前面介绍过用鼠标双击可以选择单词(根据字母的语法性质),可以 按照词语边界选择(双击+拖动), 可以选择多行 (三击+ 拖动),这些选择方式在这里都是一样的工作.
;;这个功能在编写程序的时候十分有用,我们经常需要移动一块代码, 而且移动到的位置也是很近的地方. 或者拷贝附近的一段代码.
(require 'mouse-copy)
(global-set-key [M-down-mouse-1] 'mouse-drag-secondary-pasting)
(global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)



;; 键绑定

;; C-x b => CRM bufer list
;;(global-set-key "\C-xb" 'electric-buffer-list)


;;F10 显示/隐藏菜单栏 ;; M-x menu-bar-open
(define-key global-map (kbd "<f10>") 'menu-bar-mode)


;;----------------------------------------------------------------------------
;; WIN+s 进入 Shell ;; M-x shell
;;----------------------------------------------------------------------------
;;(global-set-key (kbd "M-s") 'shell)
;;(define-key ctl-x-map "\M-s" 'shell)


;;----------------------------------------------------------------------------
;; wcy-swbuff.el  用 <C-M-s-left> <C-M-s-right> 来切换窗口
;;----------------------------------------------------------------------------
;; then you can use <C-tab> and <C-S-kp-tab> to switch buffer.
(global-set-key (kbd "<C-M-s-left>") 'wcy-switch-buffer-forward)
(global-set-key (kbd "<C-M-s-right>") 'wcy-switch-buffer-backward)


;;----------------------------------------------------------------------------
;; 使用%号跳转到括号的另一边
;;----------------------------------------------------------------------------
;; (global-set-key "" 'match-parena)

;; (defun match-paren (arg)
;;   "Go to the matching paren if on a paren; otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;         ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;         (t (self-insert-command (or arg 1)))))


;;----------------------------------------------------------------------------
;; 默认注释单行也需要选中区域，这个函数是如果没有选中区域直接注释当前行
;;----------------------------------------------------------------------------
(defun my-comment-or-uncomment-region (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'my-comment-or-uncomment-region)


;;----------------------------------------------------------------------------
;; Mac meta key set
;;----------------------------------------------------------------------------
(when *is-a-mac*
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta))



;; Define my functions

;;----------------------------------------------------------------------------
;; dos to unix,    M-x dos2unix
;;----------------------------------------------------------------------------
(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix 't) )

;; (global-set-key (kbd "C-x C-s")
;;                 (lambda ()
;;                   (interactive)
;;                   (set-buffer-file-coding-system 'unix 't)
;;                   (save-buffer)))


;;----------------------------------------------------------------------------
;; remove ^M
;;----------------------------------------------------------------------------
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))


;;----------------------------------------------------------------------------
;; 快速打开配置文件
;;----------------------------------------------------------------------------
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;;----------------------------------------------------------------------------
;; Create-scratch-buffer
;;----------------------------------------------------------------------------
(defun create-scratch-buffer nil
  "create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (org-mode))


;;----------------------------------------------------------------------------
;; 在括号内时就高亮包含内容的两个括号.
;;----------------------------------------------------------------------------
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))


;;----------------------------------------------------------------------------
;; 删除 buffer 和 window.
;;----------------------------------------------------------------------------
(defun delete-window-maybe-kill-buffer ()
  "Delete selected window.
If no other window shows its buffer, kill the buffer too."
  (interactive)
  (let* ((selwin (selected-window))
         (buf (window-buffer selwin)))
    (if (> (length (window-list)) 1)
        (delete-window selwin)
      (unless (get-buffer-window buf 'visible) (kill-buffer buf))
      (kill-buffer buf))))


;;----------------------------------------------------------------------------
;; org-mode 格式化 list
;;----------------------------------------------------------------------------
(defun org-adjust-region (b e)
  "Re-adjust stuff in region according to the preceeding stuff."
  (interactive "r") ;; current region
  (save-excursion
    (let ((e (set-marker (make-marker) e))
          (_indent (lambda ()
                     (insert ?\n)
                     (backward-char)
                     (org-indent-line)
                     (delete-char 1)))
          last-item-pos)
      (goto-char b)
      (beginning-of-line)
      (while (< (point) e)
        (indent-line-to 0)
        (cond
         ((looking-at "[[:space:]]*$")) ;; ignore empty lines
         ((org-at-heading-p)) ;; just leave the zero-indent
         ((org-at-item-p)
          (funcall _indent)
          (let ((struct (org-list-struct))
                (mark-active nil))
            (ignore-errors (org-list-indent-item-generic -1 t struct)))
          (setq last-item-pos (point))
          (when current-prefix-arg
            (fill-paragraph)))
         ((org-at-block-p)
          (funcall _indent)
          (goto-char (plist-get (cadr (org-element-special-block-parser e nil)) :contents-end))
          (org-indent-line))
         (t (funcall _indent)))
        (forward-line))
      (when last-item-pos
        (goto-char last-item-pos)
        (org-list-repair)
        ))))

(after-load 'org
  (define-key org-mode-map (kbd "C-+") 'org-adjust-region))


;;----------------------------------------------------------------------------
;; 保存文本时自动更新 buffer 头部的版本日期
;;----------------------------------------------------------------------------
(defun update-version ()
  "更新脚本头部的版本日期"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^\\(#*Version:    \\).*" nil t)
    (replace-match (format "\\1%s" (format-time-string "%Y.%m.%d")))))

(defun my-after-save-actions ()
  "Used in `before-save-hook'."
  (when '(save-buffer save-some-buffers)
    (if (member (file-name-extension (buffer-file-name)) '("sh" "py"))
        (if (yes-or-no-p "Update Version?")
            (update-version)))))

(add-hook 'before-save-hook 'my-after-save-actions)
;; (add-hook 'after-save-hook 'my-after-save-actions)


(provide 'init-hot-key)
;;; init-hot-key.el ends here
