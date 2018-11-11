(prompt "acaddoc.lsp file has loaded")

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



0.
