;;; init-awesome-tab.el --- awesometab               -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Bai

;; Author: Bai <Bai@Dolores>

;;; Commentary:

;;

;;; Code:


(require 'awesome-tab)
(awesome-tab-mode t)

(global-set-key (kbd "<C-M-s-left>") 'awesome-tab-backward)
(global-set-key (kbd "<C-M-s-right>") 'awesome-tab-forward)
(global-set-key (kbd "<C-M-s-up>") 'awesome-tab-backward-group)
(global-set-key (kbd "<C-M-s-down>") 'awesome-tab-forward-group)


(provide 'init-awesome-tab)
;;; init-awesome-tab.el ends here
