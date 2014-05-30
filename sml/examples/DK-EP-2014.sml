(* RLA Denmark :  Europa-Parlamentsvalget 25. may 2014 *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

structure DKEP2014 =
struct
  structure D = dHondt
    
    (* Party totals, as draw from the webpage of Denmark's Statistik Department, www.dst.dk *)
  val A = 435245.0
  val B = 148949.0
  val C = 208262.0
  val F = 249305.0
  val I = 65480.0
  val N = 183724.0
  val O = 605889.0
  val V = 379840.0
  val coalitions = [A + B + F, I, N, O, C + V]
  val audit = foldr op+ 0.0 coalitions

  val Denmark   = (coalitions, 13)
  val (wDenmark, mDenmark, eDenmark, sDenmark) = D.margins Denmark

  val ABF   = ([A, B, F], 5)
  val (wABF, mABF, eABF, sCV) = D.margins ABF

  val CV   = ([C, V], 3)
  val (wCV, mCV, eCV, sCV) = D.margins CV
end