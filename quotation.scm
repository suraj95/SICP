(define a 1) 
(define b 2) 
(list a b) ;(1 2) 
(list 'a 'b) ;(a b) 
(list 'a b) ;(a 2)

(car '(a b c)) ;a 
(cdr '(a b c)) ;(b c)