(define (add-rat x y) 
	(make-rat (+ (* (numer x) (denom y)) (* (numer y) (denom x))) (* (denom x) (denom y)))) 

(define (sub-rat x y)
	(make-rat (- (* (numer x) (denom y)) (* (numer y) (denom x))) (* (denom x) (denom y)))) 

(define (mul-rat x y)
	(make-rat (* (numer x) (numer y)) (* (denom x) (denom y)))) 

(define (div-rat x y)
	(make-rat (* (numer x) (denom y)) (* (denom x) (numer y))))

(define (equal-rat? x y)
	(= (* (numer x) (denom y)) (* (numer y) (denom x))))


; Pairs oﬀer a natural way to complete the rational-number system. 
; Simply represent a rational number as a pair of two integers: a numerator and a denominator. 
; Then make-rat, numer, and denom are readily implemented as follows:

(define (make-rat n d) (cons n d)) 
(define (numer x) (car x)) 
(define (denom x) (cdr x))

; Also, in order to display the results of our computations, we can print rational numbers by printing 
; the numerator, a slash, and the denominator: 

(define (print-rat x)
	(newline) 
		(display (numer x)) 
	(display "/") (display (denom x)))


(define one-half (make-rat 1 2))
(print-rat one-half) ; 1/2
(define one-third (make-rat 1 3)) ; 1/3
(print-rat (add-rat one-half one-third)) ; 5/6






