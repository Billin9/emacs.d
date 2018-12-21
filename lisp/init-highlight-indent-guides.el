(require-package 'highlight-indent-guides)
;; (require 'highlight-indent-guides-mode)

(setq highlight-indent-guides-method 'character)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(provide 'init-highlight-indent-guides)
