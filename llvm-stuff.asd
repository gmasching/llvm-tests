;;;; cg-llvm.asd

(asdf:defsystem #:llvm-stuff
  :author "Gregorio Manabat <zpersoncool@gmail.com>"
  :depends-on
  (
   #:cg-llvm
   #:kaleidoscope256
   #:utility
   #:filesystem-util)
  :serial t
  :components
  ((:file "test2")))
