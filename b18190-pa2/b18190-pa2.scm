#lang sicp
(define-syntax delay
    (syntax-rules ()
      ((delay expr) (memo-proc (lambda () expr))))
    )

  (define (memo-proc proc)
    (let ((already-run? false) (result false))
      (lambda ()
        (if (not already-run?)
            (begin (set! result (proc))
                   (set! already-run? true)
                   result)
            result)
        )
      )
    )


  (define-syntax cons-stream
    (syntax-rules ()
      ((cons-stream a b) (cons a (delay b)))))


    (define (stream-car s)
    (car s))

  (define (force promise) (promise))

  (define (stream-cdr s) (force (cdr s)))

  (define the-empty-stream '())

  (define (stream-null? s) (eq? s the-empty-stream))

  (define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))


(define Fu '())
(define Pooh '())

(define (play strategy1 strategy2 first_move no_of_rounds)

  (define (player_strat1 other_player round)
    (cons-stream (stream-ref other_player (- round 1)) (player_strat1 other_player (+ round 1)))
    )

  (define (player_strat2 other_player round)
  
    (cons-stream (antagonist (most-frequent other_player player_strat2 round)) (player_strat2 other_player (+ round 1)))
    )
  

  (define (most-frequent other_player this_player round)
    (define cnt1 0)
    (define cnt2 0)
    (define cnt3 0)
    (define cnt4 0)
    (define curr-round 0)
    (define (fill-list round)

      (if (>= round 0)
          (begin (cond ((eqv? (stream-ref other_player round) 1) (set! cnt1 (+ cnt1 1)))
                       ((eqv? (stream-ref other_player round) 2) (set! cnt2 (+ cnt2 1)))
                       ((eqv? (stream-ref other_player round) 3) (set! cnt3 (+ cnt3 1)))
                       ((eqv? (stream-ref other_player round) 4) (set! cnt4 (+ cnt4 1)))
                       )
                 (fill-list (- round 1))
                 )
          )
      )
   
    (define idx 0)
    (define (get-max cnt1 cnt2 cnt3 cnt4 idx)
      (cond ((and (>= cnt4 cnt1) (>= cnt4 cnt2) (>= cnt4 cnt3)) 4)  
            ((and (>= cnt3 cnt1) (>= cnt3 cnt2) (>= cnt3 cnt4)) 3)
            ((and (>= cnt2 cnt1) (>= cnt2 cnt4) (>= cnt2 cnt3)) 2)
            ((and (>= cnt1 cnt4) (>= cnt1 cnt2) (>= cnt1 cnt3)) 1)
          
            )
      )

      
    
    (fill-list (- round 1))
    (get-max cnt1 cnt2 cnt3 cnt4 0)

    )

  ;;elf:1 orc:2 dwarf:3 hobbit:4
  ;; 
  (define (antagonist x)
    (cond ((eqv? x 4) 2)
          ((eqv? x 3) 4)
          ((eqv? x 1) 4)
          ((eqv? x 2) 3)
          ((eqv? x 2) 1)
          ((eqv? x 1) 3)
          )
    )

  (define (kills? x y)
    (cond ((and (eqv? x 2) (eqv? y 4) ) #t)
          ((and (eqv? x 4) (eqv? y 3) ) #t)
          ((and (eqv? x 4) (eqv? y 1) ) #t)
          ((and (eqv? x 3) (eqv? y 2) ) #t)
          ((and (eqv? x 1) (eqv? y 2) ) #t)
          ((and (eqv? x 3) (eqv? y 1) ) #t)
          (else #f)
          )
    )

  (cond ((eqv? strategy1 1) (set! Fu (cons-stream first_move (player_strat1 Pooh 1))))
        ((eqv? strategy1 2) (set! Fu (cons-stream first_move (player_strat2 Pooh 1))))
        )
  (cond ((eqv? strategy2 1) (set! Pooh (cons-stream 4 (player_strat1 Fu 1))))
        ((eqv? strategy2 2) (set! Pooh (cons-stream 4 (player_strat2 Fu 1))))
        )

  (define cnt 0)
  (define curr_round 0)
  (define (simulate S1 S2 curr_round)
    (if (<= curr_round no_of_rounds)
        (begin (cond ((kills? (stream-car S1) (stream-car S2)) (set! cnt (+ cnt 1)))
                     ((kills? (stream-car S2) (stream-car S1)) (set! cnt (- cnt 1)))
                 )
        (simulate (stream-cdr S1) (stream-cdr S2) (+ curr_round 1))
        )
      )
        
    )


  (simulate Fu Pooh 1)
  (cond ( (> cnt 0) 1)
        ( (< cnt 0) 2)
        ( else 0)
        )
 )

