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
  (filesystem-util:rebase-path ;;"ll/test.ll"
			       "ll/hello-world.ll"
			       ;;"ll/copied-from-documentation.ll"
			       *this-directory*))
(defparameter *test-directory* "/home/imac/install/llvm/3.8.0/src/test/")
;;"/home/imac/install/scheme2llvm/scheme2llvm.ll"

(cg-llvm::define-cg-llvm-rule llvm-module ()
  (progm (? cg-llvm::whitespace)
	 (v do-llvm-elements
	    #+nil
	    #'print
	    #'identity
	    #+nil
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

(defparameter *test-files* nil)

(defun do-extension-files (&optional
			     (fun 'test)
			     (extension "ll")
			     (original-path *test-directory*))
  (labels
      ((rec (path)
	 (dolist (thing (uiop:directory-files path))     
	   (cond ((uiop:file-pathname-p thing)
		  (when (string= extension
				 (pathname-type thing))
		    (funcall fun thing original-path)))))
	 (dolist (thing (uiop:subdirectories path))
	   (cond ((uiop:directory-pathname-p thing)
		  (rec thing))))))
    (rec original-path)))

(defun do-test-file (path)
  (do-llvm-elements (merge-pathnames path *test-directory*)))



(defun find-test-files ()
  (setf *test-files* nil)
  (do-extension-files
      (lambda (thing original-path)
	(push (enough-namestring thing original-path)
	      *test-files*)))
  (setf *test-files* (nreverse *test-files*))
  (values))

(defparameter *count* 0)
(defparameter *correct* 0)
(defun do-tests (&optional (start 0))
  (setf *count* 0)
  (setf *correct* 0)
  (dolist (thing (nthcdr start *test-files*))
    (incf start)    
    (format t "~&       Parsing: ~a"
	    thing)
    (incf *count*)
    (handler-case
	(progn (do-llvm-elements (merge-pathnames thing *test-directory*))
	       (incf *correct*))
      (esrap-liquid::simple-esrap-error ()
	(format t "~&[FAILED]"))
      (error (c)
	(format t "~&other error")
	(print c)
	nil))))

(defun correctness ()
  (* 100.0) (/ *correct*
	       *count*))
