(* RLA Denmark *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

signature UTIL = 
sig 
  val nats : 
        int           (* an integer n *)
      -> 
	int list      (* a list of [1,2,...,n] *)

  val sort : (('a * 'a) -> bool) -> 'a list -> 'a list

  val flatten : 'a list list -> 'a list
end
