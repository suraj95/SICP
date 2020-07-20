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

; it's a good idea to split the problem in subproblems which are easier to solve 

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

; use fib for tree recursive procedure and fib-i for iterative procedure

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

