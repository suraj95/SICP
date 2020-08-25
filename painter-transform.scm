; A painter is represented as a procedure that, given a frame as argument, draws a particular image 
; shifted and scaled to ﬁt the frame. 

(define (segments->painter segment-list) 
	(lambda (frame) 
		(for-each 
			(lambda (segment) 
				(draw-line 
					((frame-coord-map frame) 
					(start-segment segment)) 
					((frame-coord-map frame) 
					(end-segment segment)))) 
			segment-list)))

; An operation on painters (such as flip-vert or beside) works by creating a painter that invokes the 
; original painters with respect to frames derived from the argument frame. 

(define (transform-painter painter origin corner1 corner2) 
	(lambda (frame) 
		(let ((m (frame-coord-map frame))) 
			(let ((new-origin (m origin))) 
				(painter (make-frame 
						new-origin 
						(sub-vect (m corner1) new-origin) 
						(sub-vect (m corner2) new-origin)))))))


; Here’s how to ﬂip painter images vertically—

(define (flip-vert painter)
	(transform-painter painter 
		(make-vect 0.0 1.0)	; new origin
		(make-vect 1.0 1.0) ; new end of edge1 
		(make-vect 0.0 0.0))) ; new end of edge2

; Using transform-painter, we can easily deﬁne new transformations. For example, we can deﬁne a painter that shrinks its image to the upperright quarter of the frame it is given—

(define (shrink-to-upper-right painter)
	(transform-painter painter 
		(make-vect 0.5 0.5) 
		(make-vect 1.0 0.5) 
		(make-vect 0.5 1.0)))

; Other transformations rotate images counterclockwise by 90 degrees29 

(define (rotate90 painter)
	(transform-painter painter 
		(make-vect 1.0 0.0) 
		(make-vect 1.0 1.0) 
		(make-vect 0.0 0.0)))

; or squash images towards the center of the frame: 

(define (squash-inwards painter)
	(transform-painter painter 
		(make-vect 0.0 0.0) 
		(make-vect 0.65 0.35) 
		(make-vect 0.35 0.65)))

; Exercise 2.50: Deﬁne the transformation flip-horiz, which ﬂips painters horizontally, and 
; transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.

(define (flip-horiz painter)
	(transform-painter painter 
		(make-vect 1.0 0.0)	; new origin
		(make-vect 0.0 0.0) ; new end of edge1 
		(make-vect 1.0 1.0))) ; new end of edge2
