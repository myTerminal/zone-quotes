;;; zone-quotes.el --- A zone program to display quotes from a specific collection -*- lexical-binding: t; -*-

;; This file is not part of Emacs

;; Author: Mohammed Ismail Ansari <team.terminal@gmail.com>
;; Version: 1.0
;; Keywords: games
;; Maintainer: Mohammed Ismail Ansari <team.terminal@gmail.com>
;; Created: 2017/09/11
;; Package-Requires: ((emacs "24") (cl-lib "0.5"))
;; Description: A zone program to display quotes from a specific collection
;; URL: http://ismail.teamfluxion.com
;; Compatibility: Emacs24


;; COPYRIGHT NOTICE
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;; for more details.
;;

;;; Install:

;; Put this file on your Emacs-Lisp load path and add the following to your
;; ~/.emacs startup file
;;
;;     (require 'zone-quotes)
;;
;; Specify the quotes you want, to be shown while zoning out
;;
;;     (zone-quotes-set-quotes (list "'I don't need luck. I have ammo.' - Grunt"
;;                                   "'Is submission not preferable to extinction?' - Saren"
;;                                   "'Having a bad day Shepard?' - Liara"))
;;
;; Set 'zone-pgm-quotes' as one of the zone programs
;;
;;     (setq zone-programs
;;           [zone-pgm-quotes])
;;
;; and activate zoning by specifying a delay
;;
;;     (zone-when-idle 30)
;;
;; Alternatively, you can run 'zone-quotes' directly
;;
;;     (zone-quotes)
;;

;;; Commentary:

;;     A zone program to display quotes from a specific collection
;;
;;  Overview of features:
;;
;;     o   Specify a set of quotes to zone out with
;;

;;; Code:

(require 'cl-lib)

(defvar zone-quotes-quotes
  (list "Emacs"))

;;;###autoload
(defun zone-quotes-set-quotes (quotes)
  "Sets quotes to be used."
  (setq zone-quotes-quotes
        quotes))

;;;###autoload
(defun zone-pgm-quotes ()
  "Zone out with quotes."
  (cl-flet* ((get-splitted-string (input-string string-width offset-width)
                                  (let* ((splitted-string '()))
                                    (if (> (length input-string)
                                           (- string-width
                                              offset-width))
                                        (progn
                                          (add-to-list 'splitted-string
                                                       (substring input-string
                                                                  0
                                                                  (- string-width
                                                                     offset-width))
                                                       t)
                                          (setq input-string
                                                (substring input-string
                                                           (- string-width
                                                              offset-width)))))
                                    (while (> (length input-string)
                                              string-width)
                                      (add-to-list 'splitted-string
                                                   (substring input-string
                                                              0
                                                              string-width)
                                                   t)
                                      (setq input-string
                                            (substring input-string
                                                       string-width)))
                                    (add-to-list 'splitted-string
                                                 input-string
                                                 t)
                                    splitted-string))
             (get-formatted-string (splitted-string)
                                   (cl-reduce (lambda (a c)
                                                (concat a
                                                        "\n"
                                                        c))
                                              splitted-string))
             (render-string (string-to-be-rendered offset-x offset-y currentp)
                            (beginning-of-buffer)
                            (forward-line offset-y)
                            (forward-char offset-x)
                            (delete-char (length string-to-be-rendered))
                            (cond (currentp (insert (propertize string-to-be-rendered
                                                                'face
                                                                '(:inverse-video t))))
                                  (t (insert (propertize string-to-be-rendered
                                                         'face
                                                         '(:strike-through t)))))))
    (delete-other-windows)
    (erase-buffer)
    (zone-fill-out-screen (window-width) (window-height))
    (while (not (input-pending-p))
      (let* ((current-quote (nth (random (length zone-quotes-quotes))
                                 zone-quotes-quotes))
             (quote-length (length current-quote))
             (screen-character-count (* (window-width)
                                        (1- (window-height))))
             (current-position (random (- screen-character-count
                                          quote-length)))
             (y-position (/ current-position
                            (window-width)))
             (x-position (% current-position
                            (window-width)))
             (splitted-string (qget-splitted-string current-quote
                                                                (- (window-width)
                                                                   0)
                                                                x-position))
             (string-to-be-printed (get-formatted-string splitted-string)))
        (render-string string-to-be-printed
                                    x-position
                                    y-position
                                    t)
        (sit-for 7)
        (render-string string-to-be-printed
                                    x-position
                                    y-position
                                    nil)))))

;;;###autoload
(defun zone-quotes ()
  "Zone out with quotes."
  (interactive)
  (let ((zone-programs [zone-pgm-quotes]))
    (zone)))

(provide 'zone-quotes)

;;; zone-quotes.el ends here
