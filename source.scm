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

;(let ((x 1))
;  body)

; can be translated into

; ((lambda (x) body) 1)

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

(define one-through-four (list 1 2 3 4)) 
one-through-four ;(1 2 3 4)

; We can think of car as selecting the ﬁrst item in the list, 
; and of cdr as selecting the sublist consisting of all but the ﬁrst item.

(car one-through-four) ;1 
(cdr one-through-four) ;(2 3 4) 
(car (cdr one-through-four)) ;2 
(cons 10 one-through-four) ;(10 1 2 3 4) 
(cons 5 one-through-four) ;(5 1 2 3 4) 

; The procedure list-ref takes as arguments a list and a number n and returns the n-th item of the list.

(define (list-ref items n)
	(if (= n 0)
		(car items) (list-ref (cdr items) (- n 1)))) 

(define squares (list 1 4 9 16 25)) (list-ref squares 3) ;16

; The procedure length, which returns the number of items in a list, illustrates this typical pattern of use:

(define (length items) (if (null? items) 0 (+ 1 (length (cdr items))))) 

(define odds (list 1 3 5 7))

(length odds);4

(define squares (list 1 4 9 16 25)) 

(length squares);5

; To append lists, if list1 is the empty list, then the result is just list2.
; Otherwise, append the cdr of list1 and list2, and cons the car of list1 onto the result:

(define (append list1 list2)
    (if (null? list1) 
    list2 
    (cons (car list1) (append (cdr list1) list2))))

(append squares odds) ;(1 4 9 16 25 1 3 5 7)
(append odds squares) ;(1 3 5 7 1 4 9 16 25)

; Exercise 2.18: Deﬁne a procedure reverse that takes a list as argument and returns a 
; list of the same elements in reverse order:

(define (reverse items)
	(define (reverse-helper items reversed-items)
		(if (null? items)
			reversed-items
			(reverse-helper (cdr items) (cons (car items) reversed-items))))
	(reverse-helper items ())) ; empty list represented with ()


(reverse (list 1 4 9 16 25)) ;(25 16 9 4 1)

; Use this notation to write a procedure same-parity that takes one or more integers and returns a list 
; of all the arguments that have the same even-odd parity as the ﬁrst argument.

(define (same-parity x . y)
	(define (same-parity-helper x y result)
		(if (null? y) ; base case
			(cons x (reverse result))
			(if (even? x)
				(if (even? (car y))
					(same-parity-helper	x (cdr y) (cons (car y) result)) ; both even
					(same-parity-helper	x (cdr y) result) ; x is even & (car y) is odd
				)
				(if (odd? (car y))
					(same-parity-helper	x (cdr y) (cons (car y) result)) ; both odd
					(same-parity-helper	x (cdr y) result) ; x is odd & (car y) is even
				)
			)
		)
	)
	(same-parity-helper x y ()))

(same-parity 1 2 3 4 5 6 7) ;(1 3 5 7) 
(same-parity 2 3 4 5 6 7) ;(2 4 6)

; One extremely useful operation is to apply some transformation to each element in a list and 
; generate the list of results. For instance, the following procedure scales each number in a list 
; by a given factor:

(define (scale-list items factor) 
	(if (null? items) 
		() ; nil gave unbound error, so replaced it with empty list.
	(cons (* (car items) factor) 
(scale-list (cdr items) factor)))) 

(scale-list (list 1 2 3 4 5) 10) ;(10 20 30 40 50)

; We can abstract this general idea and capture it as a common pattern expressed as a higher-order 
; procedure, just as in Section 1.3. The higher-order procedure here is called map. map takes as 
; arguments a procedure of one argument and a list, and returns a list of the results produced 
; by applying the procedure to each element in the list—

(define (map proc items) 
	(if (null? items)
		() 
		(cons (proc (car items)) 
			(map proc (cdr items))))) 

(map abs (list -10 2.5 -11.6 17)) ; (10 2.5 11.6 17) 
(map (lambda (x) (* x x)) (list 1 2 3 4)) ; (1 4 9 16)

; Now we can give a new deﬁnition of scale-list in terms of map:

(define (scale-list-map items factor) 
	(map (lambda (x) (* x factor)) items))

(scale-list-map (list 1 2 3 4 5) 10) ;(10 20 30 40 50)

; Similarly, we can define a function square-list:

(define (square-list items) 
	(if (null? items) 
		() 
		(cons (square (car items)) 
			(square-list(cdr items)))))

(square-list (list 1 2 3 4)) ; (1 4 9 16)

; We can also use map procedure in the same way

(define (square-list-map items) 
	(map square items))

(square-list-map (list 1 2 3 4)) ; (1 4 9 16)

; Modify your reverse procedure of Exercise 2.18 to produce a deep-reverse procedure that takes a 
; list as argument and returns as its value the list with its elements reversed and with all sublists 
; deep-reversed as well. For example,

(define (deep-reverse items)
	(define (deep-reverse-helper items reversed-items)
		(if (null? items)
			reversed-items
			(deep-reverse-helper (cdr items) (cons (reverse (car items)) reversed-items))))
	(deep-reverse-helper items ())) ; empty list represented with ()

(define x (list (list 1 2) (list 3 4)))
(reverse x) ; ((3,4) (1,2))
(deep-reverse x) ; ((4,3) (2,1))

; Write a procedure fringe that takes as argument a tree (represented as a list) and returns a list 
; whose elements are all the leaves of the tree arranged in left-to-right order. 

(define (fringe items)
	(define (fringe-helper items returned-items)
		(if (not (null? items)) 
			(if (not (list? (car items))) 
				(fringe-helper (cdr items) (cons (car items) returned-items)) ; base case
				(append (fringe-helper (car items) returned-items) 
						(fringe-helper (cdr items) returned-items)) ; recursive step

			)
			(reverse returned-items); end of list
		)
	)
	(fringe-helper items ())
)

(define x (list (list 1 2 3 4) (list 5 6))) 
(fringe x) ; (1 2 3 4 5 6)

; Just as map is a powerful abstraction for dealing with sequences, map together with recursion is a 
; powerful abstraction for dealing with trees. 

(define (scale-tree tree factor) 
	(cond 	((null? tree) ()) 
			((not (pair? tree)) (* tree factor)) 
			(else (cons 	(scale-tree (car tree) factor) 
						(scale-tree (cdr tree) factor))))) 

(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10) ; (10 (20 (30 40) 50) (60 70))

; Another way to implement scale-tree is to regard the tree as a sequence of sub-trees and use map. 

(define (scale-tree-map tree factor)
	(map 	(lambda (sub-tree) 
				(if 	(pair? sub-tree) 
						(scale-tree sub-tree factor) (* sub-tree factor)
				)
			)
	tree))

(scale-tree-map (list 1 (list 2 (list 3 4) 5)) 10) ; (10 (20 (30 40) 50))

; Deﬁne a procedure square-tree analogous to the square-list procedure of Exercise 2.21.

(define (square-tree tree) 
	(cond 	((null? tree) ()) 
			((not 	(pair?	tree)) (square tree)) 
			(else 	(cons 	(square-tree (car tree)) 
							(square-tree (cdr tree))))))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))) ; (1 (4 (9 16) 25) (36 49))

(define (square-tree-map tree)
	(map 	(lambda (sub-tree)
				(if 	(pair? sub-tree)
						(square-tree-map sub-tree) (square sub-tree)

				)
			)
	tree))

(square-tree-map (list 1 (list 2 (list 3 4) 5) (list 6 7))) ; (1 (4 (9 16) 25) (36 49))

