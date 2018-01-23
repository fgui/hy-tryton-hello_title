(import [trytond.pool [PoolMeta]])
(import [trytond.pyson [Eval Bool Not]])
(import [trytond.model [fields ModelSQL ModelView Unique]])
(def --all-- ["Hello" "HelloTitle"])

(defclass HelloTitle [ModelSQL ModelView]
  "Hello Title"
  [--name-- "hello.title"
   name (.Char fields "Name")
   important (.Boolean fields "Important")]

  (with-decorator classmethod   
    (defn --setup-- [cls]
      (.--setup-- (super HelloTitle cls))
      (setv t (.--table-- cls))
      (.append cls.-sql-constraints
               (, "name_uniq" (Unique t t.name)
                  "Name must be unique")))))

(defclass Hello []
  "Hello Title"
  [--name-- "hello"
   --metaclass-- PoolMeta
   important (.Boolean fields "Important Title")
   title (.Many2One fields "hello.title" "Title"
                    :domain [(, "important" "=" (Eval "important"))]
                    :depends '("important"))]

  ;; (with-decorator classmethod   
  ;;   (defn --setup-- [cls]
  ;;     (.--setup-- (super Hello cls))
  ;;     (assoc cls.greeting.state "invisible" True ;;(Not (Bool (Eval "important")))
  ;;           )))

  
  (with-decorator (fields.depends "title" "name" "surname" "co_prefix")
    (defn on-change-with-greeting [self]
      (.get-greeting self "on_change_with")))
  
  (defn get-greeting [self name]
    (setv su (super Hello self))
    (setv res (.get_greeting su name))
    (if self.title
      (+ self.title.name " " res)
      res))

  (with-decorator classmethod
    (defn copy [cls records &optional [default None]]
      (when (= default None)
        (setv default {}))
      (.setdefault default "important" False)
      (.copy (super Hello cls) records default)
      ))


  )
