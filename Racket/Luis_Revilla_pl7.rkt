#lang racket
#|
5/11/2020
Homework 7 concurrent programs
Worked by Julio Villazón, Luis Revilla and Jesús González 
|#

(require racket/async-channel)

; Create a new communication channel between threads
(define pipe (make-channel))
;(define pipe (make-async-channel))

;create function that finds a number that is divisible from 1 to N
(define (divisible-up-to n)
  (let loop
    ([result n]
     [num n])
    (if (zero? num)
        result
        (if(zero? (remainder result num))
           (loop result (sub1 num))
           (loop (add1 result) n)))))

;function that generates a list N random numbers from 2 to L
(define (generate_r N L)
  (let loop
   ([result empty]
    [a N]
    [r (random L)])
    (if (zero? a)
        result
        (loop
         (cond
           [(> r 2)(append result (list r))]
           [else (append result (list 2))])
         (sub1 a) (random L)))))

  
; Return a new thread
(define (make-thread name)
    (thread (lambda ()
        (let loop ()
            ; Read a message from the channel
            (define msg (channel-get pipe))
            ;(define msg (async-channel-get pipe))
            (sleep 2)
            (cond
                [(equal? msg 'end)
                    (printf "Thread ~a finishing\n" name)]
                [else
                    (printf "Thread: ~a | Input: ~a | Result: ~a\n" name msg (divisible-up-to msg))
                    (loop)])))))

(define (main T N L)
    (printf "MAIN THREAD START\n")
    ; Create the threads indicated in the argument
    (define threads (map make-thread (range T)))
    ; List with data
    (define data (range N))
    ; Send the data through the predefined channel
  ;let data be the list of random numbers
    (let loop ([data (generate_r N L)])
        (cond
            [(not (empty? data))
                (channel-put pipe (car data))
                ;(async-channel-put pipe (car data))
                (loop (cdr data))]))
    (printf "Finished sending data\n")
    ; Send the finishing symbol for each thread
    (let loop ([n T])
        (cond
            [(not (zero? n))
                (channel-put pipe 'end)
                ;(async-channel-put pipe 'end)
                (loop (sub1 n))]))
    (for-each thread-wait threads)
    (printf "MAIN THREAD FINISHING\n"))
