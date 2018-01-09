(import [trytond.pool [PoolMeta]])
(import [trytond.model [fields ModelSQL ModelView]])
(def --all-- ["Hello" "HelloTitle"])

(defclass HelloTitle [ModelSQL ModelView]
  "Hello Title"
  [--name-- "hello.title"
   name (.Char fields "Name")])

(defclass Hello []
  "Hello Title"
  [--name-- "hello"
   --metaclass-- PoolMeta
   title (.Many2One fields "hello.title" "Title")])
