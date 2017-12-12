(require-package 'emmet-mode)
(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'nxml-mode-hook 'emmet-mode)

(provide 'init-emmet)