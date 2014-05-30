(* RLA Denmark *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

structure Util : UTIL = 
struct
  fun nats n = nats' n nil 

  (* nats' n L = R
     Invariant
     [1...n] @ L = R
  *)
  and nats' 0 L = L
    | nats' n L = nats' (n - 1) (n :: L) 

  fun flatten nil = nil
    | flatten (x :: y) = x @ flatten y

  fun sort f nil = nil
    | sort f (x :: y) = 
      let 
	val (l, r) = split f x y (nil, nil)
      in (sort f l) @ [x] @ (sort f r)
      end
  and split f x nil (l, r) = (l, r)
    | split f x (y :: z) (l, r) = 
      if f(x, y) then split f x z (l, y :: r) 
      else split f x z (y :: l, r)

end