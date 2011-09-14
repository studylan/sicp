; In the terms of wishful thinking, we can implement usage of rational
; numbers without even knowing the details of their implementation. Only
; thing we have to know is how to create them (make-rat x y), how to get
; numerator (numer r) and denominator (denom r). We don't have to know
; anything about their internals.

(load "../common.scm")

(define (add-rat x y)
  (make-rat
    (+ (* (numer x) (denom y))
       (* (numer y) (denom x)))
    (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat
    (- (numer x) (denom y)
       (numer y) (denom x))
    (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat 
    (* (numer x) (numer y))
    (* (denom x) (denom y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

; We can implement now assumed functions in terms of pairs

; constructor
(define (make-rat n d) (cons n d))

; numerator selector
(define (numer x) (car x))

; denominator selector
(define (denom x) (cdr x))

; textual representation
(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))

(define one-half (make-rat 1 2))
; (print-rat one-half)

(define one-third (make-rat 1 3))

; here we see it is not normalized to 2/3 but it shows 6/9
(print-rat (add-rat one-third one-third))

; we can fix normalization by reimplementing make-rat with
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

; here we see it is not normalized to 2/3 but it shows 6/9
; In heist it represents 2/1/3/1 which is not normalized on the other
; side but is correct mathematically.
(print-rat (add-rat one-third one-third))
