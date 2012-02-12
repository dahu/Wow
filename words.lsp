#!/usr/bin/newlisp

(context 'Words)

;(seed (time-of-day))
(seed 12345)

(setf Words:Words (randomize (parse (read-file "g5_s1.dat") "\n" 0)))

(context MAIN)
