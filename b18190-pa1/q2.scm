#lang sicp

(define (fewest-moves l)
  (if (null? l) 0

  (if (= (car l) 1)
  (+ (min (fewest-moves (cdr l)) (if (> (len l) 1) (fewest-moves (cddr l)) 0)) 1)


  (+ (min (fewest-moves (cdr l)) (if (> (len l) 3) (fewest-moves (cddddr l)) 0)) 1)
  )
  )
  )
 

(define (len l)
   (cond ((null? l) 0)
    (else (+ 1 (len (cdr l))))))
  
;(fewest-moves '(1 0 1 1 1 0 1 1 0 1 0 1 1 0 0 1 1 1))
;(fewest-moves '(0 1 1))
;(fewest-moves '(0 1 1 1 1))