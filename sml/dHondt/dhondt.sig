(* RLA Denmark *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

signature DHONDT = 
sig 
  val margins : 
        ( real list   (* list of totals for each party/coaltion *) 
	* int)        (* number of seats to be awarded*)
      -> 
        ( int list    (* seats awarded for each party *)
	* real list   (* margins, sorted according to size, increasing *)
	* real        (* expected error, see Stark paper *)
	* real        (* number of ballots to be audited *)
	)
end
