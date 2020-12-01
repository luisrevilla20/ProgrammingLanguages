#|
Luis Revilla - A01022320
Homework 3 - Racket Recursion
14/09/2020
|#

#lang racket

(define (get-pi-regular n)
  (define (power n)
  (expt -1 (+ n 1)) ;Power of -1
  )
  (case n
    [(0) 0.0]; zero recursion 
    [(1) (/(* (power n) 4.0) (- (* 2 n) 1))] ; zero recursion with base case
    [else (+ (get-pi-regular (- n 1)) (/(* (power n) 4.0) (- (* 2 n) 1)))] ;Recursion 
   )
)



(define (get-pi n (a 0))
  (let loop
    ([n n]
     [a a]
    )
    (define (power n)
     (expt -1 (+ n 1))
    )
   (case n
    [(0) a] ; Zero recursion
    
    [(1) (+ a (/(* (power n) 4.0) (- (* 2 n) 1)))]; zero recursion with base case
    [else (loop (- n 1) (+ a (/(* (power n) 4.0) (- (* 2 n) 1))) )]
   )
  )
) ; recursion with accumulator



(define (ln-2 n (a 0))
  (let loop
    ([n n]
     [a a]
    )
  (case n
    [(0) a] ; Zero recursion
    
    [(1) (+ a (/ 1.0 (* (* 2 n) (- (* 2 n)1))))]; zero recursion with base case
    [else (loop (- n 1) (+ a (/ 1.0 (* (* 2 n) (- (* 2 n)1))) ))]
   )
 )
) ; recursion with accumulator