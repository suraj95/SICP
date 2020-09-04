(define a 1) 
(define b 2) 
(list a b) ;(1 2) 
(list 'a 'b) ;(a b) 
(list 'a b) ;(a 2)

(car '(a b c)) ;a 
(cdr '(a b c)) ;(b c)

(define (memq item x)
	(cond ((null? x) false) 
		((eq? item (car x)) x) 
		(else (memq item (cdr x)))))

(memq 'apple '(pear banana prune)) ;false
(memq 'pear '(pear banana prune)) ;true
(list (list 'george))	;((george))
(cdr '((x1 x2) (y1 y2))) ; ((y1 y2))

; cadr takes car of a cdr
(cadr '((x1 x2) (y1 y2))) ; (y1 y2)

