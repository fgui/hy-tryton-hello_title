(import [trytond.pool [PoolMeta]])
(import [trytond.model [fields ModelSQL ModelView Unique]])
(def --all-- ["Hello" "HelloTitle"])

(defclass HelloTitle [ModelSQL ModelView]
  "Hello Title"
  [--name-- "hello.title"
   name (.Char fields "Name")]

  (with-decorator classmethod   
    (defn --setup-- [cls]
      (.--setup-- (super HelloTitle cls))
      (setv t (.--table-- cls))
      (.append cls.-sql-constraints
               (, "name_uniq" (Unique t t.name)
                  "Name must be unique"))
      ))
  )

(defclass Hello []
  "Hello Title"
  [--name-- "hello"
   --metaclass-- PoolMeta
   title (.Many2One fields "hello.title" "Title")]


  (with-decorator (fields.depends "title" "name" "surname")
    (defn on-change-with-greeting [self]
      (.get-greeting self "on_change_with")))
  
  (defn get-greeting [self name]
    (setv su (super Hello self))
    (setv res (.get_greeting su name))
    (if self.title
      (+ self.title.name " " res)
      res)))
