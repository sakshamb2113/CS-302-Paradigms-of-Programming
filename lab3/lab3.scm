#lang sicp
;;q1 and q2

(define (make-account balance password)
  (define incorrect-count 0)
  (define (withdraw amount )
    (if  (>= balance amount)
         (begin (set! balance (- balance amount)) balance)
         "Insufficient Balance!"))
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (define (helper amount)
    (if (eq? incorrect-count 5) (call-the-cops) 
    (begin (set! incorrect-count (+ incorrect-count 1))
           "Incorrect password")
    ))
  (define (call-the-cops)
    "you have exhausted your attempts")
  (define (dispatch m1 m2)
    (cond ((eq? m2 'withdraw) (if (eq? m1 password) (lambda (amount) (withdraw amount)) (lambda (amount) (helper amount)))) 
          ((eq? m2 'deposit) (if (eq? m1 password) (lambda (amount) (deposit amount)) (lambda (amount) (helper amount))))
          (else (error "Invalid Request"  
                       ))))  
  dispatch)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'deposit) 99)
((acc 'secret-password 'withdraw) 200)
((acc 'secret-passwor1 'withdraw) 50)
((acc 'secret-passwor1 'withdraw) 50)
((acc 'secret-passwor1 'withdraw) 50)
((acc 'secret-passwor1 'withdraw) 50)
((acc 'secret-passwor1 'withdraw) 50)
((acc 'secret-passwor1 'withdraw) 50)


;;q3
(define (make-monitored f)
  (define counter 0)
  (define (mf flag)
    (cond
      ((equal? flag 'how-many-calls?) counter)
      ((equal? flag 'reset-count) (set! counter 0))
      (else (begin (set! counter (+ counter 1))
            (f flag) ) )
      )
    )
  mf
)

(define (square x)
  (* x x))
(define s (make-monitored square))
(s 'how-many-calls?)
(s 100)
(s 'how-many-calls?)
(s 3)
(s 'how-many-calls?)
(s 'reset-count)
(s 'how-many-calls?)
(s 99)
(s 'how-many-calls?)