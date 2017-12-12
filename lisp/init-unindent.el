;;; init-unindent.el --- indent and unindent functions  -*- lexical-binding: t; -*-

;; Copyright (C) 2016

;; Author:  <Bailm@ourgame-work>
;; Keywords: unindent

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


;; turn on transient mark mode
;;(that is, we highlight the selected text)
(transient-mark-mode t)

(setq my-tab-width 4)

(defun indent-block()
  (shift-region my-tab-width)
  (setq deactivate-mark nil))

(defun unindent-block()
  (shift-region (- my-tab-width))
  (setq deactivate-mark nil))

(defun shift-region(numcols)
  " my trick to expand the region to the beginning and end of the area selected
 much in the handy way I liked in the Dreamweaver editor."
  (if (< (point)(mark))
      (if (not(bolp))    (progn (beginning-of-line)(exchange-point-and-mark) (end-of-line)))
    (progn (end-of-line)(exchange-point-and-mark)(beginning-of-line)))
  (setq region-start (region-beginning))
  (setq region-finish (region-end))
  (save-excursion
    (if (< (point) (mark)) (exchange-point-and-mark))
    (let ((save-mark (mark)))
      (indent-rigidly region-start region-finish numcols))))

(defun indent-or-complete ()
  "Indent region selected as a block; if no selection present either indent according to mode,
or expand the word preceding point. "
  (interactive)
  (if  mark-active
      (indent-block)
    (if (looking-at "\\>")
        (hippie-expand nil)
      (insert "\t"))))

(defun my-unindent()
  "Unindent line, or block if it's a region selected"
  (interactive)
  (if mark-active
      (unindent-block)
    (if(not(bolp))(delete-backward-char 4 ))))

;; (global-set-key (kbd "M-i") 'my-unindent)
(global-set-key (kbd "M-i") 'decrease-left-margin)

(add-hook 'find-file-hooks (function (lambda ()
                                       (unless (eq major-mode 'org-mode)
                                         (local-set-key (kbd "<tab>") 'indent-or-complete)))))

(if (not (eq  major-mode 'org-mode))
    (progn
      ;; (define-key global-map "\t" 'indent-or-complete) ;; with this you have to force tab (C-q-tab) to insert a tab after a word
      (define-key global-map [S-tab] 'my-unindent)
      (define-key global-map [C-S-tab] 'my-unindent)))

;; mac and pc users would like selecting text this way
(defun dave-shift-mouse-select (event)
  "Set the mark and then move point to the position clicked on with
 the mouse. This should be bound to a mouse click event type."
  (interactive "e")
  (mouse-minibuffer-check event)
  (if mark-active (exchange-point-and-mark))
  (set-mark-command nil)
  ;; Use event-end in case called from mouse-drag-region.
  ;; If EVENT is a click, event-end and event-start give same value.
  (posn-set-point (event-end event)))

;; be aware that this overrides the function for picking a font. you can still call the command
;; directly from the minibufer doing: "M-x mouse-set-font"
(define-key global-map [S-down-mouse-1] 'dave-shift-mouse-select)

;; to use in into emacs for  unix I  needed this instead
                                        ; define-key global-map [S-mouse-1] 'dave-shift-mouse-select)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; this final line is only necessary to escape the *scratch* fundamental-mode
;; and let this demonstration work
;; (text-mode)


(provide 'init-unindent)
;;; init-unindent.el ends here
