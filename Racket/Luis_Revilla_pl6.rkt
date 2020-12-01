#lang racket


(define (d num)
  (let loop
   ([num num]
    [res 1])
    (cond 
        [(equal? num 0) res]
        [(equal? (modulo res num) 0) (sub1 num)]
        [else (loop (add1 num) (add1 res))])
    )
)