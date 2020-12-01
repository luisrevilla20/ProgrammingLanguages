#|
Luis Revilla - A01022320
Homework 4 - Racket Lists
25/09/2020
|#
#lang racket



(define (hailstone n (a '())) ;Uses the accumulator
  (let loop
    ([n n]
     [a a])
   (case n
     [(0) '()]
     [(1) (append a '(1))];Base Case
     
     [else (if (zero? (remainder n 2))
               (loop (/ n 2) (append a (list n)));Even
               (loop (+ (* n 3) 1) (append a (list n)));Odd
               )]
    )
  )
)

(define (shift-char a n)
  (if (>(+ n(char->integer a)) 122)
      (integer->char(-(+ n(char->integer a))26))
      (if (<(+ n(char->integer a)) 97)
          (integer->char(+(+ n(char->integer a))26))
          (integer->char(+ n(char->integer a)))
        )
    )
)


(define (caesar-encode s n (a '())) ;Uses the acuumulator
  (let loop
    ([s s]
     [n n]
     [a a])

    (if (empty? (string->list s))
        (list->string a)
        (loop (list->string(cdr(string->list s))) n (append a (list (shift-char(car (string->list s)) n))))
    )      
  )
)