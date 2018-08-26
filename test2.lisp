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
			       ;;"ll/hello-world.ll"
			       ;;"ll/copied-from-documentation.ll"
			       *this-directory*))
(defparameter *test-directory*
  ;"/home/imac/install/llvm/3.8.0/src/test/"
  "/home/imac/install/llvm/6.0.0/src/test/"
  )
;;"/home/imac/install/scheme2llvm/scheme2llvm.ll"

(cg-llvm::define-cg-llvm-rule llvm-module ()
  (progm (? cg-llvm::whitespace)
	 (v do-llvm-elements
	    ;#+nil
	    #'print
	    #+nil
	    #'identity
	    #+nil
	    (lambda (x)
	      (format t "~&~s~%" x))
	    )
	 #+nil
	 `(module ,@(v llvm-elements))
	 (? cg-llvm::whitespace)))

(defmacro parse-thing (exp string)
  `(cg-llvm::with-cg-llvm-rules ;;FIXME::refactor define-esrap-env?
     (cg-llvm::with-cg-llvm-contexts ;;FIXME::refactor define-esrap-env?
       (esrap-liquid::parse
	,exp
	,string))))

(mapcar
 (lambda (name)
   (setf (gethash name esrap-liquid::*not-tracing*)
	 t))
 '(cg-llvm::llvm-comment
   cg-llvm::whitespace))

(defun toggle-trace-rules ()
  (setf esrap-liquid::*debug-trace-rules*
	(not esrap-liquid::*debug-trace-rules*)))

(defmacro parse-thing2 (exp string)
  `(let ((esrap-liquid::*debug-trace-rules* t))
     (parse-thing ,exp ,string)))

(defun do-llvm-elements (&optional (file *test-file*))
  (let ((stream (alexandria:read-file-into-string file)))
    (parse-thing
     'llvm-module
     stream)))

(cg-llvm::define-cg-llvm-rule any ()
  (progm (? cg-llvm::whitespace)
	 (v cg-llvm::any-statements)
	 (? cg-llvm::whitespace)))

(defun do-llvm-statements (&optional (file *test-file*))
  (let ((stream (alexandria:read-file-into-string file)))
    (parse-thing
     'any
     stream)))

(defun parse-llvm-statement (string)
  (parse-thing
   'cg-llvm::any-statement
   string))

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

(defparameter *failed-tests* nil)

(defparameter *count* 0)
(defparameter *correct* 0)
(defun do-tests (&optional (files-list *test-files*) (start 0))
  (unless *test-files*
    (find-test-files))
  (setf *count* 0)
  (setf *correct* 0)
  (setf *failed-tests* nil)
  (dolist (thing (nthcdr start files-list))
    (incf start)    
    (format t "
Testnum: ~a 
Correct: ~a
Parsing: ~a"
	    *count*
	    (correctness)
	    thing)
    (incf *count*)
    (let ((completed? nil)) 
      (handler-case
	  (progn (do-llvm-elements (merge-pathnames thing *test-directory*))
		 (setf completed? t)
		 (incf *correct*))
	(esrap-liquid::simple-esrap-error ()
	  (format t "~&~%     [FAILED]~%"))
	(error (c)
	  (format t "~&~%    other error~%")
	  (print c)
	  nil))
      (unless completed?
       (push thing *failed-tests*)))))

(defun correctness ()
  (unless (zerop *count*)
    (* 100.0 (/ *correct*
		*count*))))

(defun wtf? ()
  (time (dotimes (x 1) (cg-llvm::cg-llvm-parse 'llvm-constants "i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30, i32 32, i32 34, i32 36, i32 38, i32 40, i32 42, i32 44, i32 46, i32 48, i32 50, i32 52, i32 54, i32 56, i32 58, i32 60, i32 62, i32 64, i32 66, i32 68, i32 70, i32 72, i32 74, i32 76, i32 78, i32 80, i32 82, i32 84, i32 86, i32 88, i32 90, i32 92, i32 94, i32 96, i32 98, i32 100, i32 102, i32 104, i32 106, i32 108, i32 110, i32 112, i32 114, i32 116, i32 118, i32 120, i32 122, i32 124, i32 126, i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31, i32 33, i32 35, i32 37, i32 39, i32 41, i32 43, i32 45, i32 47, i32 49, i32 51, i32 53, i32 55, i32 57, i32 59, i32 61, i32 63, i32 65, i32 67, i32 69, i32 71, i32 73, i32 75, i32 77, i32 79, i32 81, i32 83, i32 85, i32 87, i32 89, i32 91, i32 93, i32 95, i32 97, i32 99, i32 101, i32 103, i32 105, i32 107, i32 109, i32 111, i32 113, i32 115, i32 117, i32 119, i32 121, i32 123, i32 125, i32 127"))))
