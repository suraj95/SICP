; The comment character is ; and anything following that on the line will be ignored. 

(+ 137 349) ;486
(- 1000 334) ;666
(* 5 99) ;495

(+ 21 35 12 7) ;75
(* 25 4 12) ;1200

(define size 2)
(define pi 3.14159) 
(define radius 10)

(* (+ 2 (* 4 6)) (+ 3 5 7)) ;390

(define (square x) (* x x))
(define (cube x) (* x x x))
(define (inc n) (+ n 1))

(square 2) ;21
(square 21) ;441
(square (+ 2 5)) ;49

(define (sum-of-squares x y) (+ (square x) (square y)))

(sum-of-squares 3 4) ;25

(define (f a) (sum-of-squares (+ a 1) (* a 2)))

(f 5) ;136

(define (abs x) 
	(cond ((> x 0) x)
		((= x 0) 0)
		((< x 0) (- x))))

; It's a good idea to split the problem in subproblems which are easier to solve 

(define (sum-largest-squares a b c)
	(if (>= a b)
      (if (>= b c)
          (sum-of-squares a b)
          (sum-of-squares a c))
      (if (>= a c)
          (sum-of-squares b a)
          (sum-of-squares b c))))
		
(define (factorial n)
	(if (= n 1)
		1 
		(* n (factorial (- n 1)))))

(define (fib n) (cond ((= n 0) 0)
	((= n 1) 1)
	(else (+	(fib (- n 1)) 
			(fib (- n 2))))))

; Use fib for tree recursive procedure and fib-i for iterative procedure

(define (fib-i n) 
	(fib-iter 1 0 n)) 
(define 
	(fib-iter a b count) 
	(if (= count 0) 
	b (fib-iter 
	(+ a b) a (- count 1))))

(define (expt b n)
	(if (= n 0) 1 
	(* b (expt b (- n 1)))))

(define (even? n) 
	(= (remainder n 2) 0))

(define (gcd a b)
	(if (= b 0)
	a (gcd b (remainder a b))))

; Find the smallest divisor of a number

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))


; f(x,y) = x(1 + xy)^2 + y(1 − y) + (1 + xy)(1 − y)  which we could also express as
; a = 1 + xy, b = 1 − y, f(x,y) = xa^2 + yb + ab


; using helper function
(define (f x y)
	(define (f-helper a b) 
		(+ (* x (square a)) 
			(* y b) 
			(* a b))) 
	(f-helper (+ 1 (* x y)) 
		(- 1 y)))

; using lambda
(define (f x y) 
	((lambda (a b)
		(+ 	(* x (square a)) 
			(* y b) 
			(* a b))) 
		(+ 1 (* x y)) 
		(- 1 y)))

; using let
(define (f x y)
	(let 	((a (+ 1 (* x y))) 
		(b (- 1 y))) 
		(+ (* x (square a)) 
		(* y b) 
		(* a b))))

; let allows one to bind variables as locally as possible to where they are to be used.

(define x 5)

(+ (let ((x 3))
	(+ x (* x 10))) 
	x)

; value of x is defined 5, but the value of x in the body is 3 and
; and therefor value of the expression here is 38


; A let is a lambda. The procedure below—

(let ((x 1))
  body)

; can be translated into

((lambda (x) body) 1)

; This procedure presents a linear combination ax + by

(define (linear-combination a b x y) 
	(+ (* a x) (* b y)))

; We can also express this idea for a more general form-- for rational numbers, complex numbers, 
; polynomials, or whatever.

(define (linear-combination a b x y) 
	(add (mul a x) (mul b y)))

; where add and mul are not the primitive procedures + and * but rather more complex things 
; that will perform the appropriate operations for whatever kinds of data we pass in as the 
; arguments a, b, x, and y. If not defined, they will give error.

; n1/d1 + n2/d2 = (n1d2 + n2d1)/d1d2

(define (add-rat x y) 
	(make-rat 
		(+ 	(* (numer x) (denom y)) (* (numer y) (denom x))) 
			(* (denom x) (denom y))))


; To enable us to implement the concrete level of our data abstraction, our language provides a 
; compound structure called a pair, which can be constructed with the primitive procedure cons. 

(define x (cons 1 2)) 

(car x) ;1 
(cdr x) ;2

; Given a pair, we can extract the parts using the primitive procedures car and cdr.

(define x (cons 1 2)) 
(define y (cons 3 4)) 
(define z (cons x y)) 

(car (car z)) ; 1 
(car (cdr z)) ; 3

; Data objects constructed from pairs are called list-structured data.



