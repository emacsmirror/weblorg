;;; publish.el --- Publish a blog; -*- lexical-binding: t -*-
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
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; Code for driving blorg into generating a website
;;
;;; Code:

(require 'blorg)

(blorg-gen
 :input-pattern ".*\\.org$"
 :template "post.html"
 :output "{{ slug }}.html")

(blorg-gen
 :input-pattern ".*\\.org$"
 :input-filter (blorg-filter :tags '(published))
 :process (blorg-aggregate :tags '(category))
 :template "category.xml"
 :output "{{ name }}.xml")

(blorg-gen
 :input-pattern ".*\\.org$"
 :input-filter (blorg-filter :tags '(published))
 :input-process (blorg-aggregate)
 :template "tmpl.rss.xml"
 :template-vars '(("title" . "A blorg")
                  ("url" . "http://example.github.io/")
                  ("description" . "a blorg about blorg"))
 :output "rss.xml")

(provide 'publish)
;;; publish.el ends here


