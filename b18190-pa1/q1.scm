#lang sicp

(define (make-qsort f)
  (define (Qsort l)
  (if (null? l) l
   (if (null? (cdr l)) l
       (append (append (Qsort (left f (pivot l) (cdr l))) (list (pivot  l))) (Qsort (right f (pivot l) (cdr l))))
       )))
  Qsort)


(define (left f pvt l)
  (filter (lambda (x) (f x pvt)) l) )

(define (right f pvt l)
  (filter (lambda (x) (not (f x pvt))) l) )
 
(define (pivot l)
  (car l))

(define (filter pred l)
  (if (null? l)
      '()
      (if (pred (car l))
          (cons (car l) (filter pred (cdr l)))
          (filter pred (cdr l)))))
  
 ;((make-qsort <) '(1 5 3 2 4 6))
 ;((make-qsort >) '(1 5 3 2 4 6))