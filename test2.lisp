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

(defparameter *this-directory*
  (asdf:system-source-directory :llvm-stuff))

(defparameter *test-file*
  (utility:rebase-path "ll/test.ll"
		       ;;"ll/hello-world.ll"
		       ;;"ll/copied-from-documentation.ll"
		       *this-directory*))
(defparameter *test-directory*
  ;"/home/imac/install/llvm-things/llvm/3.8.0/src/test/"
  "/home/imac/install/llvm-things/llvm/6.0.0/src/test/"
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


(defparameter *whole-document* nil)
(defparameter *manual* nil)
(defun bar (&optional (file (merge-pathnames
			     "LLVM Language Reference Manual — LLVM 8 documentation.html"
			     *this-directory*)))
  (setf *whole-document*
	(plump:parse  
	 file))
  (setf *manual* (plump:get-element-by-id *document* "llvm-language-reference-manual")))


(defun print-div (div)
  (print (plump:attribute div "id")))

(defun foob (&optional (div *manual*))
  (map nil
       #'print-div
	(plump:child-elements div)))

(define-symbol-macro $$ sb-impl::*inspected*)

(defmacro do-child-elements ((child-var) node-form &body body)
  `(loop for ,child-var across (plump:children ,node-form)
      do (when (plump:element-p ,child-var)
	   ,@body)))

(defmacro do-children ((child-var) node-form &body body)
  `(loop for ,child-var across (plump:children ,node-form)
      do (progn
	   ,@body)))

;;;;search child elements. when body returns true,
;;;;add element to list to be returned.
(defmacro get-elements-by ((child-var) node-form &body body)
  (with-gensyms (finds)
    `(let ((,finds))
       (do-child-elements (,child-var) ,node-form
	 (when ,@body
	   (push ,child-var ,finds)) )
       ,finds)))

;;;;recursive version
(defmacro get-children-by-recursively ((child-var) node-form &body body)
  (with-gensyms (node finds)
    `(let ((,finds))      
       (labels ((scanren (,node)
		  (do-children (,child-var) ,node
		    (when ,@body
		      (push ,child-var ,finds))
		    (when (plump:element-p ,child-var)
		      (scanren ,child-var)))))
	 (scanren ,node-form))
       ,finds)))

(defun find-text-recursively (node &optional (string "Syntax:"))
  (get-children-by-recursively (child) node
    (and
     (plump:text-node-p child)
     (string-equal string
		   (plump:text child)))))

(defmacro naref (&rest args)
  `(aref ,(car (last args)) ,@(butlast args)))

(defparameter *instruction-reference* nil)

(defun header-p (node)
  (char= #\h (aref (plump:tag-name node) 0)))

(defun parent-after (known-parent known-descendant)
  (let ((old known-descendant)
	(parent (plump:parent known-descendant)))
    (block exit
      (loop
	 (when (eq known-parent
		   parent)
	   (return-from exit old))
	 (setf old parent)
	 (setf parent (plump:parent parent))))))
(defun one-or-zero-child (node)
  (let ((children (plump:children node)))
    (case (length children)
      (1 (naref 0 children))
      (0 nil)
      (otherwise (error "too many kids found")))))

(defun huh2 ()
    ;;the section where some instructions are stored
  (setf *instruction-reference* (plump:get-element-by-id *manual* "instruction-reference"))
  (huh *instruction-reference*)
 ;; (huh (plump:get-element-by-id *manual* "intrinsic-functions"))
  )

(defun huh (&optional (ref *instruction-reference*))
  (let ((sections ())
	(instructions ()))
    ;;iterate over groups of instructions
    (do-child-elements (child) ref
      (when (string-equal
	     "section"
	     (plump:attribute child "class"))
	(push child sections)))
    ;;iterate over each instruction in the subgroup
    (dolist (section sections)
      (do-child-elements (child) section
	(when (string-equal
	       "section"
	       (plump:attribute child "class"))
	  (push child instructions))))

    (dolist (x instructions)
     ;; (print-div x)

      (block nope
	;;The name
	(let ((head ;;get the header like h4,
	       (first
		(get-elements-by (child) x
		  (header-p child)))))	  
	  (when (not head)
	    (return-from nope))
	  (let ((foo
		 (first (plump:get-elements-by-tag-name
			 head		      
			 "code"))))
	    (when (not foo)
	      (return-from nope))
	    (let ((instruction-name
		   (mapcar
		     (lambda (span)
		       (plump:text
			(naref
			 0
			 (plump:children
			  span))))
		     (nreverse
		      (plump:get-elements-by-tag-name 
		       foo
		       "span")))))
	      ;;(print instruction-name)
	      )))

	;;locate the syntax
	(let ((acc nil)
	      (meh (plump:get-elements-by-tag-name
		    (parent-after
		     x
		     (car (find-text-recursively x "Syntax:")))
		    "pre")))
	  (dolist (thing
		    (coerce 
		     (plump:children
		      (first
		       meh))
		     'list))
	    (let ((text (if (plump:text-node-p thing)
			    thing
			    (one-or-zero-child thing))))
	      (when text
		(push (plump:text text) acc))))
	  (setf acc (nreverse acc))
	  #+nil
	  (print (esrap-liquid:text acc)
		 )
	  (progn
	    (terpri)
	    (princ (esrap-liquid:text acc)
		   )))))))
