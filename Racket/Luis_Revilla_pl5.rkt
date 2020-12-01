#|
Luis Revilla - A01022320
Homework 5 - Functional Programs
08/10/2020
|#
#lang racket
(define (shift-char a n)
  
  (if (or (<= 97(char->integer a) 122) (<= 65(char->integer a) 90))
     ;(integer->char (+ n (char->integer a)) )
    (if (<= 97(char->integer a) 122)
        (if (>(+ n(char->integer a)) 122)
            (integer->char(-(+ n(char->integer a))26))
            (if (<(+ n(char->integer a)) 97)
                (integer->char(+(+ n(char->integer a))26))
                (integer->char(+ n(char->integer a)))
            )
        )
        (if (>(+ n(char->integer a)) 90)
            (integer->char(-(+ n(char->integer a))26))
            (if (<(+ n(char->integer a)) 65)
            (integer->char(+(+ n(char->integer a))26))
            (integer->char(+ n(char->integer a)))
        )
    ))
    a)
)

(define (caesar-encode s n b (a '())) ;Uses the accumulator
  (let loop
    ([s s]
     [n n]
     [a a])
    (if (equal? #f b)
        
        (if (empty? (string->list s))
            (list->string a)
            (loop (list->string(cdr(string->list s))) n (append a (list (shift-char(car (string->list s)) n))))
        ) 
         (if (empty? (string->list s))
            (list->string a)
            (loop (list->string(cdr(string->list s))) n (append a (list (shift-char(car (string->list s)) (- n)))))
        ) 
    )  
  )
)

(define (letter-distance c)
    (-(char->integer c) (char->integer #\a))
)

(define (vigenere-encode s e b (a '()))
    (let loop
    ([s s]
     [code (string->list e)]
     [a a])
     (if ( empty? (string->list s))
        (list->string a)
        (if (equal? #f b)   
            (loop (list->string(cdr(string->list s))) (cond [(empty? (cdr code)) (string->list e)] [else (cdr code)]) (append a (list (shift-char(car (string->list s)) (letter-distance (car (string->list e)))))))
            (loop (list->string(cdr(string->list s))) (cond [(empty? (cdr code)) (string->list e)] [else (cdr code)]) (append a (list (shift-char(car (string->list s)) (-(letter-distance (car (string->list e))))))))
         )
    )
    )
)

(define (file->list filename-in (a '()))
    (call-with-input-file filename-in 
        (lambda (in)
            (let loop
                ([line (read-line in)]
                 [a a])
                (cond
                    [(eof-object? line) a]
                    [else
                       ; (displayln line)
                        (loop (read-line in)(append a (list line)) )])))
    )
)

(define (list->file filename-out list)
    (call-with-output-file filename-out #:exists 'truncate
        (lambda (out)
            (let loop
                ([list list]
                [n 0])
                (cond
                    [(empty? list) n]
                    [else
                        (fprintf out "~a\n" (car list))
                        (loop (cdr list) (add1 n))])))))

(define (encode-file filename-in filename-out encoding key encoder)
  (list->file filename-out (list (encoding (string-join(file->list filename-in)) key encoder))))
