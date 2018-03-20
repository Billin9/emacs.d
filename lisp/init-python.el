(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

(when (maybe-require-package 'anaconda-mode)
  (after-load 'python
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
    (remove-hook 'anaconda-mode-response-read-fail-hook
                 'anaconda-mode-show-unreadable-response))
  (when (maybe-require-package 'company-anaconda)
    (after-load 'company
      (add-hook 'python-mode-hook
                (lambda () (sanityinc/local-push-company-backend 'company-anaconda))))))

;; Embedding in python @Bailm
(require-package 'mmm-mode)
(after-load 'mmm-vars
  (mmm-add-group
   'embedded-html
   '(;; html mode ----------------------------------------------------
     (html
      :submode html-mode
      :face mmm-code-submode-face
      :front "<html[^>]*>[ \t]*\n?"
      :back "[ \t]*</html>"
      :include-front t
      :include-back t)
     ;; css mode ----------------------------------------------------
     (css-cdata
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style[^>]*>[ \t\n]*\\(//\\)?<!\\[CDATA\\[[ \t]*\n?"
      :back "[ \t]*\\(//\\)?]]>[ \t\n]*</style>"
      :insert ((?j js-tag nil @ "<style type=\"text/css\">"
                   @ "\n" _ "\n" @ "</style>" @)))
     (css
      :submode css-mode
      :face mmm-code-submode-face
      :front "<style[^>]*>[ \t]*\n?"
      :back "[ \t]*</style>"
      :insert ((?j js-tag nil @ "<style type=\"text/css\">"
                   @ "\n" _ "\n" @ "</style>" @)))
     (css-inline
      :submode css-mode
      :face mmm-code-submode-face
      :front "style=\""
      :back "\"")
     ;; javascript mode ----------------------------------------------------
     (js-script-cdata
      :submode js-mode
      :face mmm-code-submode-face
      :front "<script[^>]*>[ \t\n]*\\(//\\)?<!\\[CDATA\\[[ \t]*\n?"
      :back "[ \t]*\\(//\\)?]]>[ \t\n]*</script>")
     (js-script
      :submode js-mode
      :face mmm-code-submode-face
      :front "<script[^>]*>[ \t]*\n?"
      :back "[ \t]*</script>"
      :insert ((?j js-tag nil @ "<script type=\"text/javascript\">\n"
                   @ "" _ "" @ "\n</script>" @)))
	))
  (dolist (mode (list 'python-mode))
    (mmm-add-mode-ext-class mode "\\.py\\'" 'embedded-html)))


(provide 'init-python)
