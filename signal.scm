; The key to organizing programs so as to more clearly reﬂect the signalﬂow structure 
; is to concentrate on the “signals” that ﬂow from one stage in the process to the next.

; Filtering a sequence to select only those elements that satisfy a given predicate is accomplished by

(define	(filter predicate sequence)
	(cond 	((null? sequence) ()) ; nil replaced by ()
			((predicate (car sequence)) 
			(cons 	(car sequence) 
					(filter predicate (cdr sequence)))) 
			(else (filter predicate (cdr sequence)))))

(filter odd? (list 1 2 3 4 5)) ; (1 3 5)

; Accumulations can be implemented by

(define (accumulate op initial sequence) 
	(if (null? sequence) 
		initial 
		(op	(car sequence) 
			(accumulate op initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5)) ; 15
(accumulate * 1 (list 1 2 3 4 5)) ; 120


; All that remains to implement signal-ﬂow diagrams is to enumerate the sequence of elements

(define (enumerate-interval low high) 
	(if (> low high) 
		() ; nil replaced by () 
		(cons low (enumerate-interval (+ low 1) high))))

(enumerate-interval 2 7) ; (2 3 4 5 6 7)

; To enumerate leaves of a tree, we can use

(define (enumerate-tree tree) 
	(cond 	((null? tree) ()) ; nil replaced by ()
			((not (pair? tree)) (list tree)) 
			(else (append 	(enumerate-tree (car tree)) 
							(enumerate-tree (cdr tree))))))

(enumerate-tree (list 1 (list 2 (list 3 4)) 5)); (1 2 3 4 5)


; Now we can reformulate sum-odd-squares and even-fibs as in the signal-ﬂow diagrams.

(define (sum-odd-squares tree)
	(accumulate 
		+ 0 (map square (filter odd? (enumerate-tree tree)))))

(define (even-fibs n)
	(accumulate cons () (filter even? (map fib (enumerate-interval 0 n))))) ; nil replaced by ()


; we can reuse pieces from the sum-odd-squares and even-fibs procedures 
; in a program that constructs a list of the squares of the ﬁrst n + 1 Fibonacci numbers

(load "source.scm") ; for fib procedure

(define (list-fib-squares n) 
	(accumulate 
		cons 
		()  ; nil replaced by ()
		(map square (map fib (enumerate-interval 0 n))))) 

(list-fib-squares 10) ; (0 1 1 4 9 25 64 169 441 1156 3025)

