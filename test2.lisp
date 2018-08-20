(defpackage #:llvm-stuff
  (:use :cl
	:esrap-liquid))
(in-package #:llvm-stuff)

(defun wot ()
  (cg-llvm:cg-llvm-parse
   'llvm-module
   #+nil
   "; ModuleID = 'hello-world.c'
target datalayout = \"e-m:e-i64:64-f80:128-n8:16:32:64-S128\"
target triple = \"x86_64-unknown-linux-gnu\"

@.str = private unnamed_addr constant [13 x i8] c\"Hello world!\\00\", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable \"less-precise-fpmad\"=\"false\" \"no-frame-pointer-elim\"=\"true\" \"no-frame-pointer-elim-non-leaf\" \"no-infs-fp-math\"=\"false\" \"no-nans-fp-math\"=\"false\" \"stack-protector-buffer-size\"=\"8\" \"unsafe-fp-math\"=\"false\" \"use-soft-float\"=\"false\" }
attributes #1 = { \"less-precise-fpmad\"=\"false\" \"no-frame-pointer-elim\"=\"true\" \"no-frame-pointer-elim-non-leaf\" \"no-infs-fp-math\"=\"false\" \"no-nans-fp-math\"=\"false\" \"stack-protector-buffer-size\"=\"8\" \"unsafe-fp-math\"=\"false\" \"use-soft-float\"=\"false\" }

!llvm.ident = !{!0}

!0 = !{!\"clang version 3.6.2 (branches/release_36 255700)\"}
"
   
   "
; Copied directly from the documentation
; Declare the string constant as a global constant.
@.str = private unnamed_addr constant [13 x i8] c\"hello world\"

; External declaration of the puts function
declare i32 @puts(i8* nocapture) nounwind

; Definition of main function
define i32 @main() { ; i32()*
    ; Convert [13 x i8]* to i8  *...
    %cast210 = getelementptr [13 x i8],[13 x i8]* @.str, i64 0, i64 0

    ; Call puts function to write out the string to stdout.
    %call = call i32 @puts(i8* %cast210)
    ret i32 0
}

; Named metadata
;!0 = !{i32 42, null, !\"string\"}
!foo = !{!0}
"))
#+nil
(v do-llvm-elements (lambda (x)
		      (format t "~&~s~%" x)))
					;#+nil


(cg-llvm::define-cg-llvm-rule do-llvm-elements (fun)
  (block out
    (loop
       (? cg-llvm::whitespace)
       (let ((element (v cg-llvm::llvm-element)))
	 (if element
	     (funcall fun element)
	     (return-from out)))))
  (values))

(defparameter *this-directory* (filesystem-util:this-directory))

(defparameter *test-file*
  (filesystem-util:rebase-path "test.ll"
			       *this-directory*))
"/home/imac/install/llvm/3.8.0/src/test"

(cg-llvm::define-cg-llvm-rule llvm-module ()
  (progm (? cg-llvm::whitespace)
	 (v do-llvm-elements #'print)
	 #+nil
	 `(module ,@(v llvm-elements))
	 (? cg-llvm::whitespace)))

(defun huh (&optional (file *test-file*))
  (with-open-file
      (stream
       file
       ;;"/home/imac/install/scheme2llvm/scheme2llvm.ll"
       )
    (cg-llvm::with-cg-llvm-rules
      (cg-llvm::with-cg-llvm-contexts
	(esrap-liquid::parse-stream
	 'llvm-module
	 stream)))))
#+nil
(test huh
  (is
   (not
    (equal nil
	   (huh)))))

()
