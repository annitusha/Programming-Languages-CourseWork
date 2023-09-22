(define (quadratic-roots a b c)
  (if (= a 0)
      'error
  (let ((discriminant (sqrt (- (expt b 2) (* (* 4 a c))))))
       (list (/ (+ (* b -1) discriminant) (* 2 a))
	     (/ (- (* b -1) discriminant) (* 2 a))))))

(define (cmp-gt ls1 ls2)
  (if (null? ls1)
      '()
      (cons (> (car ls1) (car ls2))
	    (cmp-gt (cdr ls1) (cdr ls2)))))

(define (ls-prod ls1 ls2)
  (if (null? ls1)
      '()
      (cons (* (car ls1) (car ls2))
	    (ls-prod (cdr ls1) (cdr ls2)))))

(define ls-f
  (lambda (ls1 ls2 (fn (lambda (a b) (+ a b))))
  (if (null? ls1)
  '()
    (cons (fn (car ls1) (car ls2))
      (ls-f (cdr ls1) (cdr ls2) fn)))))


(define (greater-than ls (v 0)) 
  (if (null? ls)
      '()
      (cons (> (car ls) v)
	    (greater-than (cdr ls) v))))

(define (my-sqrt n (guess 1))
  (if (> (/ (abs(- (* guess guess ) n)) n) (/ 1 10000))
    (my-sqrt n (/(+ guess (/ n guess)) 2))
    guess ))
    


(define (quadratic-root a b c (d sqrt))
  (if (= a 0)
      'error
  (let ((discriminant (d (- (expt b 2) (* (* 4 a c))))))
       (list (/ (+ (* b -1) discriminant) (* 2 a))
	     (/ (- (* b -1) discriminant) (* 2 a))))))