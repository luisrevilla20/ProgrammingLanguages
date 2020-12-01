#lang racket

(define (! n)
  (if (= n 1)
      1
      (* n (! (- n 1))))
  )

(define (fibonacci n)
  (case n
    [(0) 0]
    [(1) 1]
    [else (+ (fibonacci (- n 1)) (fibonacci (- n 2))])
  )

