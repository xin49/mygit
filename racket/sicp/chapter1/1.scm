(define (factorial n)
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))

(define (factorial1 n)
    (factorial-iter 1 1 n))

(define (factorial-iter proceduct counter max-counter)
    (if (> counter max-counter)
        proceduct
        (factorial-iter (* counter proceduct) 
                        (+ counter 1)
                        max-counter)))

(factorial 5)
(factorial1 5)

;正则序和应用序测试
;forver iterator func p
;(define (p)
;    (p))
;(define (test n)
;    (if (= n 0) 
;        0 
;        (p)))
;(define (test n)
;    (if (= n 0) 
;        0 
;        (/ 1 0)))
;(test 0)
