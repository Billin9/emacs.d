(global-set-key (kbd "M-/") 'hippie-expand)

;; Modify by Bailm
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-expand-whole-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))


(provide 'init-hippie-expand)
