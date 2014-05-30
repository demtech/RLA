(* RLA Denmark :  Europa-Parlamentsvalget 7. juni 2009 *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

structure DKEP2009 =
struct
  structure D = dHondt

  val Denmark = ([503439.0, 100094.0, 371603.0, 297199.0, 13796.0, 474041.0, 55459.0, 168555.0, 357942.0], 13)
  val (_, mDenmark, _, _) = D.margins Denmark
end