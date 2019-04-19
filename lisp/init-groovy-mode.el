;;; init-groovy-mode.el --- Jenkinsfile and Groovy syntax highlight  -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Bai

;; Author: Bai <Bai@Dolores>

;;; Commentary:

;;

;;; Code:


(require-package 'groovy-mode)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'auto-mode-alist '("^.enkinsfile" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))


(provide 'init-groovy-mode)
;;; init-groovy-mode.el ends here