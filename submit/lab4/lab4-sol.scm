(define (quadratic-roots a b c)
  (if (= a 0)
      'error
  (let ((discriminant) (sqrt (- (expt b 2)(* 4 a c)))))
       (list (/ (- (-b) (discriminant)) (* 2 a))
	    (/ (+ (-b) (discriminant)) (* 2 a)))))

(define (cmp-gt ls1 ls2)
  (if (null? ls1)
      '()
      (cons (> (car ls1) (car ls2))
	    (cmp-gt (cdr ls1) (cdr ls2)))))

(define (ls-prod ls1 ls2)
  (if (null? ls1)
      '()
      (cons (* (car ls1) (car ls2))
	    (cmp-gt (cdr ls1) (cdr ls2)))))
