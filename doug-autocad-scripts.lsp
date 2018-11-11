;;;  This is part of ABA Standard Macros 
;;;  These shortcut macros cannot be implemented in ACAD.PGP.
(defun toggle (VAR VSTAT VSTAT0 VSTAT1)
    (if (= (getvar VAR) 1)
        (progn(setvar VAR 0)(princ VSTAT)(princ VSTAT0))
        (progn(setvar VAR 1)(princ VSTAT)(princ VSTAT1)) )(princ))

(defun c:BF ()(command ".BREAK" pause "F")(prin1))

(defun c:ba()(princ "\nSelect object to break: ")(command "break" pause "f" pause "@")(princ))


(defun c:bk()(princ "\nSelect object to break: ")(command "break" pause "f")(princ))


(defun c:BM()(toggle "blipmode" "Blips are " "not drawn." "drawn.")(princ))

(defun c:cm()(princ "\nSelect objects to copy: ")(command "select" "auto" pause)
             (command "copy" "p" "" "m")(princ))

(defun c:ec()(command "erase" "c")(princ))

(defun c:el()(command "erase" "l" "")(princ))

(defun c:f0()(command "fillet" "r" "0")(command "fillet")(princ))

(defun c:hl()(toggle "highlight" "Highlighting of selected entities is " "off." "on."))

(defun c:st()(command "stretch" "crossing")(princ))

(defun c:tm()(toggle "tilemode" "Viewports are now " "entities in Pspace (Tilemode = 0)." "tiled areas of the screen (Tilemode = 1)."))

(defun c:za()(command "zoom" "a")(princ))

(defun c:zd()(command "zoom" "d")(princ))

(defun c:ze()(command "zoom" "e")(princ))

(defun c:zw()(command "zoom" "w")(princ))

(defun c:zp()(command "zoom" "p")(princ))

(defun c:zv()(command "zoom" "v")(princ))

;Fillet Radius automaticaaly changed to 0" for 90 deg. fillets
(defun c:fz ()
	(setq old_filletrad (getvar "filletrad"))
	(setvar "filletrad" 0.0)
	(command ".fillet" pause pause)
	(setvar "filletrad" old_filletrad)
	(princ)
)

;Automatically puts dimensions on the dimension layer (new dimlinear)
(defun c:dl (/ *error* CLAYER)
	(setq CLAYER (getvar "CLAYER"))
	(setvar "CLAYER" "N-Dimension")
	(command ".dimlinear" pause pause)
	(setvar "CLAYER" CLAYER)
	(setq *error* nil)
	(princ)
)

(defun myer (msg)
  	(setvar "CLAYER" CLAYER)
  	(setq att "*** Resetting system variable has been done ***")
  	(princ att)
)

;Automatically puts dimensions on the dimension layer (new dimcontinue)
(defun c:dc (/ *error* CLAYER)
	(setq *error* myer)
	(setq CLAYER (getvar "CLAYER"))
	(setvar "CLAYER" "N-Dimension")	
	(command ".dimcontinue" pause pause pause pause pause pause pause pause pause pause pause pause pause "")
	(setvar "CLAYER" CLAYER)
	(setq *error* nil)
	(princ)
)

(defun myer (msg)
  	(setvar "CLAYER" CLAYER)
  	(setq att "*** Resetting system variable has been done ***")
  	(princ att)
)

;Automatically inserts dynamic door block
(defun c:db (/ *error* CLAYER)
	(setq *error* myer)
	(setq CLAYER (getvar "CLAYER"))
	(setvar "CLAYER" "A-Doors")
	(command ".-insert" "dynamicdoor" pause "1" "1" "0.00")
	(setvar "CLAYER" CLAYER)
	(setq *error* nil)
	(princ)
)

(defun myer (msg)
  	(setvar "CLAYER" CLAYER)
  	(setq att "*** Resetting system variable has been done ***")
  	(princ att)
)

;Automatically inserts dynamic window block	
(defun c:wb (/ *error* CLAYER)
  	(setq *error* myer)
  	(setq CLAYER (getvar "CLAYER"))
  	(setvar "CLAYER" "A-Windows")
  	(command ".-insert" "Window_Plan" pause "1" "1" "0.00")
  	(setvar "CLAYER" CLAYER)
  	(setq *error* nil)
  	(princ)
)
 
(defun myer (msg)
  	(setvar "CLAYER" CLAYER)
  	(setq att "*** Resetting system variable has been done ***")
  	(princ att)
)
