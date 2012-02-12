#!/usr/bin/newlisp

(load "words.lsp")   ; Words list holds random spread of words
(load "gtk.lsp")

(setf level 0)
(setf score 0)
(setf round_time 120)
(setf game_over nil)
(setf level_right 5)

(do-until game_over
          (begin
            (setf game_over 1)
            (setf time_remaining round_time)
            (setf new_word_delay 10)
            (setf right 0)
            (inc level_right)
            (do-while (and (> time_remaining 0) (< right level_right))
                      (begin
                        ; get the next word to display
                        (if (= 0 (% time_remaining new_word_delay))
                          (begin
                            (setf word (pop Words))
                            ; replace with gtk label update
                            (println time_remaining " " word)
                            ))

                        ; update gtk:
                        ;   round_time label
                        ;
                        ; listen for keyboard events / gtk response

                        ; dummy to test level up after sufficient right words
                        (if (and (= 20 time_remaining) (< level 2))
                          (setf right level_right))

                        ; level up when number of right words achieved
                        (if (>= right level_right)
                          (begin
                            (setf game_over nil)
                            (inc level)
                            (inc score (+ (* 10 level) time_remaining))
                            ))

                        ; replace with 1000
                        (sleep 10)
                        (dec time_remaining)
                        )
                      )

            )
          )

(exit)
