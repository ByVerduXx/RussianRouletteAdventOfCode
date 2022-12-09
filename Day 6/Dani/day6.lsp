
(let ((in (open "input.in")))
  (defvar input (read-line in))
  (close in))

(defvar counter 4)
(defvar found 0)
(defvar pointer 4)

(if (and (not (eq (char input 0) (char input 1))) (not (eq (char input 0) (char input 2))) (not (eq (char input 0) (char input 3))) (not (eq (char input 1) (char input 2))) (not (eq (char input 1) (char input 3))) (not (eq (char input 2) (char input 3))))
    (print counter)
    (loop while (not (eq found 1))
          do (if (and (not (eq (char input pointer) (char input (1- pointer)))) (not (eq (char input pointer) (char input (1- (1- pointer))))) (not (eq (char input pointer) (char input (1- (1- (1- pointer)))))) (not (eq (char input (1- pointer)) (char input (1- (1- pointer))))) (not (eq (char input (1- pointer)) (char input (1- (1- (1- pointer)))))) (not (eq (char input (1- (1- pointer))) (char input (1- (1- (1- pointer)))))))
                (progn (print (+ counter 1))
                         (setq found 1))
                (progn (setq counter (+ counter 1))
                         (setq pointer (+ pointer 1)))
            )
    )
)

;Part 2

(defun without-last(l)
    (reverse (cdr (reverse l))))

(defvar set (list ()))
(defvar input-length (length input))
(setq set (without-last set))

(loop for i from 0 to 13
      do (progn (push (char input i) set))
)

(setq found 0)
(setq counter 14)

(loop while (not (eq found 1))
    do (progn (if (eq (length (remove-duplicates set)) 14)
                    (progn (print counter)
                             (setq found 1))
                    (progn 
                             (setq set (without-last set))
                             (push (char input counter) set)
                             (setq counter (+ counter 1)))
                ))
)




