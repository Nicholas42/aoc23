(defconstant +north+ 0)
(defconstant +south+ 1)
(defconstant +east+ 2)
(defconstant +west+ 3)

(defparameter *input* (make-array 1 :adjustable t :fill-pointer 0))
(defparameter *height* 0)

(defun readFile (fname)
  (progn
    (with-open-file (stream fname)
      (loop for line = (read-line stream nil 'eof)
            until (eq line 'eof)
            do (vector-push-extend line *input* )
            do (setf *height* (+ 1 *height*))))
    (defparameter *width* (length (aref *input* 0)))
    (defparameter *field* (make-array (list *width* *height*) :initial-element #\.))
    (defvar *visited*)
    (defvar *cache*)
    (defparameter *dirstack* '())
    (loop for y below *height*
          do (loop for x below *width*
                   do (setf (aref *field* x y) (char (aref *input* y) x))))))

(defun incx (x direction)
  (ccase direction
         (#.+north+ x)
         (#.+south+ x)
         (#.+east+ (+ x 1))
         (#.+west+ (- x 1))))

(defun incy (y direction)
  (ccase direction
         (#.+north+ (- y 1))
         (#.+south+ (+ y 1))
         (#.+east+ y)
         (#.+west+ y)))

(defun move (x y direction)
  (list (incx x direction) (incy y direction) direction))

(defun is-vertical-p (direction)
  (< direction 2))

(defun dirslash (direction)
  (mod (+ direction 2) 4))

(defun dirback (direction)
  (- 3 direction))

(defun needs-work-p (x y direction)
  (and
    (>= x 0)
    (>= y 0)
    (< x *width*)
    (< y *height*)
    (not (aref *cache* x y direction))))

(defun add-moves (x y &rest directions)
  (dolist (direction directions)
    (push (move x y direction) *dirstack*)))

(defun doStep (x y direction)
    (when (needs-work-p x y direction)
      (setf (aref *cache* x y direction) t)
      (setf (aref *visited* x y) t)
      (ccase (aref *field* x y)
             (#\. (add-moves  x y direction))
             (#\- (if (is-vertical-p direction)
                    (add-moves x y +east+ +west+)
                    (add-moves x y direction)))
             (#\| (if (is-vertical-p direction)
                    (add-moves x y direction)
                    (add-moves x y +south+ +north+)))
             (#\/ (add-moves x y (dirslash direction)))
             (#\\ (add-moves x y (dirback direction))))))

(defun tryStart (start)
  (let (
        (*cache* (make-array (list *width* *height* 4) :initial-element nil))
        (*visited* (make-array (list *width* *height*) :initial-element nil)))
    (progn
      (push start *dirstack*)
      (loop while *dirstack*
            do (progn
                 (setq nextStep (pop *dirstack*))
                 (apply #'doStep nextStep)))
      (loop for y below *height*
            sum (loop for x below *width*
                      sum (if (aref *visited* x y ) 1 0))))))
