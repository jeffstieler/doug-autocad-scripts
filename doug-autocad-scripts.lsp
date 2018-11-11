; hack for gravel hatch issues
(setenv "MaxHatch" "100000000")

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

;;
;;  Flatten.lsp - Converts 3d geometry to 2d geometry.
;;
;;  Copyright © 1999 by Autodesk, Inc.
;;
;;  Your use of this software is governed by the terms and conditions
;;  of the License Agreement you accepted prior to installation of this
;;  software.  Please note that pursuant to the License Agreement for this
;;  software, "[c]opying of this computer program or its documentation
;;  except as permitted by this License is copyright infringement under
;;  the laws of your country.  If you copy this computer program without
;;  permission of Autodesk, you are violating the law."
;;
;;  AUTODESK PROVIDES THIS PROGRAM "AS IS" AND WITH ALL FAULTS.
;;  AUTODESK SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTY OF
;;  MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.  AUTODESK, INC.
;;  DOES NOT WARRANT THAT THE OPERATION OF THE PROGRAM WILL BE
;;  UNINTERRUPTED OR ERROR FREE.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun c:flatten ( / ss ans )
 (acet-error-init (list nil 1))
 
 (princ "\nSelect objects to convert to 2d...")
 (if (not acet:flatn-hide)
     (setq acet:flatn-hide "No")
 );if
 
 (if (and (setq ss (ssget "_:l" '((-4 . "<NOT") (0 . "VIEWPORT") (-4 . "NOT>"))));setq
          (setq ss (car (acet-ss-filter (list ss nil T))))
     );and
     (progn
      (initget "Yes No")
      (setq ans (getkword 
                 (acet-str-format "\nRemove hidden lines? <%1>: "
                                  acet:flatn-hide
                 )
                );getkword
      );setq
      (if (not ans)
          (setq ans acet:flatn-hide)
          (setq acet:flatn-hide ans) 
      );if
      (if (equal ans "No")
          (acet-flatn ss nil)
          (acet-flatn ss T)
      );if
     );progn then
 );if
 (acet-error-restore)
);defun c:flatten

(acet-autoload2	'("FLATTENSUP.LSP"	(acet-flatn ss hide)))
(princ)

; VP lock
(defun c:vpl ()
(prompt "\nSelect viewports to lock:")
(setq lockedviewports (ssget))
(command "-vports" "l" "on" lockedviewports "" )
)

(defun c:vpu ()
(prompt "\nSelect viewports to unlock:")
(setq unlockedviewports (ssget))
(command "-vports" "l" "off" unlockedviewports "" )
)

(princ "\n\tType VPL to lock viewports, Type VPU to unlock viewports...")
(princ)

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

; Casework Offset
(defun c:co (/ line side)
  ; prompt for line selection
  (setq line (car (entsel "\nSelect line to offset: ")))

  ; prompt for point (side) selection
  (setq side (getpoint "\nSelect side to offset: "))

  ; first offset on overhead layer (+ 1' 0")
  (command ".offset" 12 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Overhead" "")

  ; second offset on under layer (+ 1' 0")
  (command ".offset" 24 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Under" "")

  ; third offset on casework layer (+ 0' 1 1/4")
  (command ".offset" 25.25 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Casework" "")

  (princ)
)

; Rod & Shelf Offset
(defun c:rs (/ line side)
  ; prompt for line selection
  (setq line (car (entsel "\nSelect line to offset: ")))

  ; prompt for point (side) selection
  (setq side (getpoint "\nSelect side to offset: "))

  ; first offset on overhead layer (+ 1' 0")
  (command ".offset" 12 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Overhead" "")

  ; second offset on casework layer (+ 0' 2")
  (command ".offset" 14 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Casework" "")

  (princ)
)

; Vanity Offset
(defun c:vo (/ line side)
  ; prompt for line selection
  (setq line (car (entsel "\nSelect line to offset: ")))

  ; prompt for point (side) selection
  (setq side (getpoint "\nSelect side to offset: "))

  ; first offset on under layer (+ 1' 9")
  (command ".offset" 21 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Under" "")

  ; second offset on casework layer (+ 0' 1 1/4")
  (command ".offset" 22.25 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Casework" "")

  (princ)
)

; Stone Wall
(defun c:sw (/ line side)
  ; prompt for line selection
  (setq line (car (entsel "\nSelect line to offset: ")))

  ; prompt for point (side) selection
  (setq side (getpoint "\nSelect side to offset: "))

  ; first offset on wall space layer (+ 0' 8 1/2")
  (command ".offset" 8.5 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Wall Space" "")

  ; second offset on col/wall layer (+ 0' 5 1/2")
  (command ".offset" 14 line side "")
  (command ".chprop" (entlast) "" "LA" "A-Col_Wall" "")

  (princ)
)

; Stairs
(defun c:ss (/ i overhang startline side treaddepth staircount)
  ; start with riser (under layer)
  ; prompt for line selection
  (setq line (car (entsel "\nSelect start line of staircase: ")))

  ; prompt for point (side) selection
  (setq side (getpoint "\nSelect side to draw: "))

  ; prompt for tread depth
  (setq treaddepth (getreal "\nEnter tread depth in inches: "))

  ; prompt for stair count
  (setq staircount (getint "\nEnter number of stairs: "))

  ; origin line is assumed to be the first riser
  ; it should be on the under layer
  (setq overhang 1.25)

  ; first nosing is just 1 overhang
  (command ".offset" overhang line side "")
  (command ".chprop" (entlast) "" "LA" "A-Stair" "")

  (setq i 1)
  (while (<= i staircount)
    ; the next riser is always an offset of (treaddepth - overhang)
    (command ".offset" (* i (- treaddepth overhang)) line side "")
    ; put risers on under layer
    (command ".chprop" (entlast) "" "LA" "A-Under" "")

    ; next nosing
    (command ".offset" (- (* i treaddepth) (* (1- i) overhang)) line side "")
    ; put nosings on stair layer
    (command ".chprop" (entlast) "" "LA" "A-Stair" "")

    (setq i (1+ i))
  )
  
  (princ)
)
