(require-package 'tabbar)
(require 'tabbar)
(tabbar-mode t)
;; 不要分组
(setq tabbar-buffer-groups-function
(lambda ()
(list "All Buffers")))
;; 不显示 Emacs Buffer
(setq tabbar-buffer-list-function
(lambda ()
(remove-if
(lambda(buffer)
(find (aref (buffer-name buffer) 0) " *"))
(buffer-list))))

;; 如果你发现打开 tabbar mode 后，上下滚动页面时觉得不平滑，配置里加上
;; (setq auto-window-vscroll nil)

;;;; 设置tabbar外观
; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "black"
                    :background "#48A4D5"
                    :box '(:line-width 2 :color "#48A4D5")
                    :overline "black"
                    :underline "black"
                    :weight 'bold
                    )

                    
(provide 'init-tabbar)
