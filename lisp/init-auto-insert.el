;;; init-auto-insert.el ---                          -*- lexical-binding: t; -*-

;; Copyright (C) 2015

;; Author:  <Bailm@ourgame-work>
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

(eval-after-load 'autoinsert
  ;; (defcustom auto-insert-alist
  ;;     '(
  ;;       ;; (define-auto-insert 'sh-mode '(nil "#!/bin/bash\n\n"))
  ;;       ;; sh-mode
  ;;       (("\\.sh\\'" . "Shell-Script skeleton")
  ;;        "Short description: "
  ;;        "#!/bin/sh\n\n"
  ;;        "# ===============================\n"
  ;;        "# Desc:    " str "\n"
  ;;        "# Author:  " (getenv-internal "USERNAME") | (progn user-name) "\n"
  ;;        "# Version: " (format-time-string "%Y.%m.%d") "\n"
  ;;        "# ===============================\n\n\n\n\n\n"
  ;;        "# --- " (file-name-nondirectory (buffer-file-name)) " --- ends here\n")

  ;;       ;; (define-auto-insert 'python-mode '(nil "#!/usr/bin/env python\n# onding=utf-8n\n"))
  ;;       ;; Python-mode
  ;;       ;; "Created on " (format-time-string "%Y-%m-%d %H:%M:%S %a.") "\n\n"
  ;;       (("\\.py\\'" . "Python skeleton")
  ;;        "Short description: "
  ;;        "#!/usr/bin/env python\n"
  ;;        "# coding=utf-8\n\n\"\"\"\n"
  ;;        "Desc:    " str "\n"
  ;;        "Author:  " (getenv-internal "USERNAME") | (progn user-name) "\n"
  ;;        "Version: " (format-time-string "%Y.%m.%d") "\n\"\"\"\n\n\n\n\n\n"
  ;;        "# --- " (file-name-nondirectory (buffer-file-name)) " --- ends here\n")
  ;;       )
  ;;     "A list specifying text to insert by default into a new file.
  ;; Elements look like (CONDITION . ACTION) or ((CONDITION . DESCRIPTION) . ACTION).
  ;; CONDITION may be a regexp that must match the new file's name, or it may be
  ;; a symbol that must match the major mode for this element to apply.
  ;; Only the first matching element is effective.
  ;; Optional DESCRIPTION is a string for filling `auto-insert-prompt'.
  ;; ACTION may be a skeleton to insert (see `skeleton-insert'), an absolute
  ;; file-name or one relative to `auto-insert-directory' or a function to call.
  ;; ACTION may also be a vector containing several successive single actions as
  ;; described above, e.g. [\"header.insert\" date-and-author-update]."
  ;;     :type 'sexp
  ;;     :version "0.1"
  ;;     :group 'auto-insert)
  (defcustom auto-insert-alist
    '((("\\.\\([Hh]\\|hh\\|hpp\\|hxx\\|h\\+\\+\\)\\'" . "C / C++ header")
       (replace-regexp-in-string
        "[^A-Z0-9]" "_"
        (replace-regexp-in-string
         "\\+" "P"
         (upcase (file-name-nondirectory buffer-file-name))))
       "#ifndef " str \n
       "#define " str "\n\n"
       _ "\n\n#endif")

      (("\\.\\([Cc]\\|cc\\|cpp\\|cxx\\|c\\+\\+\\)\\'" . "C / C++ program")
       nil
       "#include \""
       (let ((stem (file-name-sans-extension buffer-file-name))
             ret)
         (dolist (ext '("H" "h" "hh" "hpp" "hxx" "h++") ret)
           (when (file-exists-p (concat stem "." ext))
             (setq ret (file-name-nondirectory (concat stem "." ext))))))
       & ?\" | -10)

      (("[Mm]akefile\\'" . "Makefile") . "makefile.inc")

      (html-mode . (lambda () (sgml-tag "html")))

      (plain-tex-mode . "tex-insert.tex")
      (bibtex-mode . "tex-insert.tex")
      (latex-mode
       ;; should try to offer completing read for these
       "options, RET: "
       "\\documentclass[" str & ?\] | -1
       ?{ (read-string "class: ") "}\n"
       ("package, %s: "
        "\\usepackage[" (read-string "options, RET: ") & ?\] | -1 ?{ str "}\n")
       _ "\n\\begin{document}\n" _
       "\n\\end{document}")

      (("/bin/.*[^/]\\'" . "Shell-Script mode magic number") .
       (lambda ()
         (if (eq major-mode (default-value 'major-mode))
             (sh-mode))))

      (ada-mode . ada-header)

      (("\\.[1-9]\\'" . "Man page skeleton")
       "Short description: "
       ".\\\" Copyright (C), " (format-time-string "%Y") "  "
       (getenv "ORGANIZATION") | (progn user-full-name)
       "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH " (file-name-base)
" " (file-name-extension (buffer-file-name))
" " (format-time-string "%Y-%m-%d ")
"\n.SH NAME\n"
(file-name-base)
" \\- " str
"\n.SH SYNOPSIS
.B " (file-name-base)
"\n"
_
"
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
" (user-full-name)
'(if (search-backward "&" (line-beginning-position) t)
     (replace-match (capitalize (user-login-name)) t t))
'(end-of-line 1) " <" (progn user-mail-address) ">\n")

(("\\.el\\'" . "Emacs Lisp header")
 "Short description: "
 ";;; " (file-name-nondirectory (buffer-file-name)) " --- " str
 (make-string (max 2 (- 80 (current-column) 27)) ?\s)
 "-*- lexical-binding: t; -*-" '(setq lexical-binding t)
 "

;; Copyright (C) " (format-time-string "%Y") ""
                                             (getenv "ORGANIZATION") | (progn user-full-name) "

;; Author: " (user-full-name)
             '(if (search-backward "&" (line-beginning-position) t)
                  (replace-match (capitalize (user-login-name)) t t))
             '(end-of-line 1) " <" (progn user-mail-address) ">
;; Keywords: "
             '(require 'finder)
             ;;'(setq v1 (apply 'vector (mapcar 'car finder-known-keywords)))
             '(setq v1 (mapcar (lambda (x) (list (symbol-name (car x))))
                               finder-known-keywords)
                    v2 (mapconcat (lambda (x) (format "%12s:  %s" (car x) (cdr x)))
                                  finder-known-keywords
                                  "\n"))
             ((let ((minibuffer-help-form v2))
                (completing-read "Keyword, C-h: " v1 nil t))
              str ", ") & -2 "

\;; This program is free software; you can redistribute it and/or modify
\;; it under the terms of the GNU General Public License as published by
\;; the Free Software Foundation, either version 3 of the License, or
\;; (at your option) any later version.

\;; This program is distributed in the hope that it will be useful,
\;; but WITHOUT ANY WARRANTY; without even the implied warranty of
\;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\;; GNU General Public License for more details.

\;; You should have received a copy of the GNU General Public License
\;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

\;;; Commentary:

\;;" _ "

\;;; Code:



\(provide '"
(file-name-base)
")
\;;; " (file-name-nondirectory (buffer-file-name)) " ends here\n")
(("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton")
 "Title: "
 "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename "
 (file-name-base) ".info\n"
 "@settitle " str "
@c %**end of header
@copying\n"
 (setq short-description (read-string "Short description: "))
 ".\n\n"
 "Copyright @copyright{} " (format-time-string "%Y") "  "
 (getenv "ORGANIZATION") | (progn user-full-name) "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{http://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{http://www.texinfo.org/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author " (getenv "ORGANIZATION") | (progn user-full-name)
" <" (progn user-mail-address) ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from http://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye

@c " (file-name-nondirectory (buffer-file-name)) " ends here\n")

;; (define-auto-insert 'sh-mode '(nil "#!/bin/bash\n\n"))
;; sh-mode
(("\\.sh\\'" . "Shell-Script skeleton")
 "Short description: "
 "#!/bin/sh\n\n"
 "# ===============================\n"
 "# Created on  " (format-time-string "%Y-%m-%d %H:%M:%S") "\n"
 "# Author:     " (getenv-internal "USERNAME") | (progn user-name) "\n"
 "# Version:    " (format-time-string "%Y.%m.%d") "\n"
 "# ===============================\n\n\n\n\n\n"
 "# --- " (file-name-nondirectory (buffer-file-name)) " --- ends here\n")

;; (define-auto-insert 'python-mode '(nil "#!/usr/bin/env python\n# onding=utf-8n\n"))
;; Python-mode
;; "Created on " (format-time-string "%Y-%m-%d %H:%M:%S %a.") "\n\n"
(("\\.py\\'" . "Python skeleton")
 "Short description: "
 "#!/usr/bin/env python\n"
 "# coding=utf-8\n\n\"\"\"\n"
 "Created on  " (format-time-string "%Y-%m-%d %H:%M:%S") "\n"
 "Author:     " (getenv-internal "USERNAME") | (progn user-name) "\n"
 "Version:    " (format-time-string "%Y.%m.%d") "\n\"\"\"\n\n\n\n\n\n"
 "# --- " (file-name-nondirectory (buffer-file-name)) " --- ends here\n")
)
"A list specifying text to insert by default into a new file.
Elements look like (CONDITION . ACTION) or ((CONDITION . DESCRIPTION) . ACTION).
CONDITION may be a regexp that must match the new file's name, or it may be
a symbol that must match the major mode for this element to apply.
Only the first matching element is effective.
Optional DESCRIPTION is a string for filling `auto-insert-prompt'.
ACTION may be a skeleton to insert (see `skeleton-insert'), an absolute
file-name or one relative to `auto-insert-directory' or a function to call.
ACTION may also be a vector containing several successive single actions as
described above, e.g. [\"header.insert\" date-and-author-update]."
:type '(alist :key-type
(choice (regexp :tag "Regexp matching file name")
        (symbol :tag "Major mode")
        (cons :tag "Condition and description"
              (choice :tag "Condition"
                      (regexp :tag "Regexp matching file name")
                      (symbol :tag "Major mode"))
              (string :tag "Description")))
;; There's no custom equivalent of "repeat" for vectors.
:value-type (choice file function
                    (sexp :tag "Skeleton or vector")))
:version "2016.12.10"
:group 'auto-insert))


(add-hook 'find-file-hooks 'auto-insert)


(provide 'init-auto-insert)
;;; init-auto-insert.el ends here
