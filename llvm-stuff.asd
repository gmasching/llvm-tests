;;;; cg-llvm.asd

(asdf:defsystem #:llvm-stuff
  :author "Gregorio Manabat <zpersoncool@gmail.com>"
  :depends-on
  (
   #:cg-llvm
   #:kaleidoscope256
   #:utility
   #:filesystem-util
   #:plump)
  :serial t
  :components
  ((:file "package")
   (:file "failed-tests")
   (:file "test2")))
