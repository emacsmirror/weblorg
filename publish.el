;;; publish.el --- Static Site Generator for org-mode; -*- lexical-binding: t -*-
;;
;; Author: Lincoln Clarete <lincoln@clarete.li>
;;
;; Copyright (C) 2020  Lincoln Clarete
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; Genenrate static websites off of Org Mode sources.
;;
;;; Code:

;; Initialize package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; Ensure templatel dependency.  I hope you like my directory
;; structure :)
(if (file-directory-p "~/src/github.com/clarete/templatel")
    (add-to-list 'load-path "~/src/github.com/clarete/templatel")
  (unless (package-installed-p 'templatel)
    (package-refresh-contents)
    (package-install 'templatel)))

(unless (package-installed-p 'ox-slimhtml)
    (package-refresh-contents)
    (package-install 'ox-slimhtml))
;; Use latest version of blorg by importing it from the current
;; directory.
(add-to-list 'load-path (file-name-directory load-file-name))

;; Actual publishing rules
(require 'blorg)

(blorg-cli
 :input-pattern "docs/src/index.org"
 :template "index.html"
 :output "docs/index.html")

(blorg-cli
 :input-source (blorg-input-source-autodoc-sections
                `(("Entry Points" . ,(concat "blorg-" (regexp-opt '("gen" "cli"))))
                  ("Filter Functions" . "^blorg-input-filter-")
                  ("Aggregation Functions" . "^blorg-input-aggregate-")
                  ("Input Sources" . "^blorg-input-source-")))
 :template "autodoc.html"
 :output "docs/api.html")

(provide 'publish)
;;; publish.el ends here
