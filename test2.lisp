(defpackage #:llvm-stuff
  (:use :cl
	:esrap-liquid))
(in-package #:llvm-stuff)

(cg-llvm::define-cg-llvm-rule do-llvm-elements (fun)
  (block out
    (loop
       (? cg-llvm::whitespace)
       (let ((element (? cg-llvm::llvm-element)))
	 (if element
	     (funcall fun element)
	     (return-from out)))))
  (values))

(defparameter *this-directory* (filesystem-util:this-directory))

(defparameter *test-file*
  (filesystem-util:rebase-path "ll/test.ll"
			       *this-directory*))
;;"/home/imac/install/llvm/3.8.0/src/test"
;;"/home/imac/install/scheme2llvm/scheme2llvm.ll"

(cg-llvm::define-cg-llvm-rule llvm-module ()
  (progm (? cg-llvm::whitespace)
	 (v do-llvm-elements
	    #+nil
	    #'print
	    (lambda (x)
	      (format t "~&~s~%" x))
	    )
	 #+nil
	 `(module ,@(v llvm-elements))
	 (? cg-llvm::whitespace)))

(defun do-llvm-elements (&optional (file *test-file*))
  (with-open-file (stream file)
    (cg-llvm::with-cg-llvm-rules ;;FIXME::refactor define-esrap-env?
      (cg-llvm::with-cg-llvm-contexts ;;FIXME::refactor define-esrap-env?
	(esrap-liquid::parse-stream
	 'llvm-module
	 stream)))))
