#lang sicp

(define (filter-all preds lowerb upperb)
  (if (null? preds)
      (make-list lowerb upperb)
  (filter (lambda (x) ((car preds) x)) (filter-all (cdr preds) lowerb upperb))
  )
)

(define (make-list lowerb upperb)
  (if (> lowerb upperb)
  '()
  (cons lowerb (make-list (+ lowerb 1) upperb))

  )
  )


(define (filter pred l)
  (if (null? l)
      '()
      (if (pred (car l))
          (cons (car l) (filter pred (cdr l)))
          (filter pred (cdr l)))))

;(define (is-positive x)
;(> x 0)
  ;)

;(define (smallest-divisor n)
 ; (find-divisor n 2))

;(define (find-divisor n test-divisor)
 ; (cond ((> (square test-divisor) n) n)
 ;       ((divides? test-divisor n) test-divisor)
 ;       (else (find-divisor n (+ test-divisor 1)))))

;(define (divides? a b)
;  (= (remainder b a) 0))

;(define (prime? n)
 ; (= n (smallest-divisor n)))



;(define (square x) (* x x))
  

;(filter-all (list is-positive prime?) -5 10)