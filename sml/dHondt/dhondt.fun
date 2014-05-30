(* RLA Denmark *)
(* Author: Carsten Schuermann *)
(* Date: 30.5.2014 *)
(* License: GNU/GPL *)

structure dHondt : DHONDT = 
struct
  structure U = Util

  (* Coefficient *)
  type Coeff = real * int


  (* coeff (x, q) = (r, q)
     Invariant:
     r = x / q
  *)
  fun coeff (x:real, q:int) = (x / Real.fromInt q, q)


  (* matrix totals ds = m : matrix
     Invariant: 
     totals by coalition.  [t1, t2, .. tn]
     ds : divisors [ds1 ... dsn]
     m = [(NONE, [(t1/ds1, ds1), (t1/ds2, ds2),..., (t1/dsn, dsn)])
  	  ....
          (NONE, [(tn/ds1, ds1), (tn/ds2, ds2),..., (tn/dsn, dsn)])]
  *)
  fun matrix totals ds =
      map (fn t => ((nil:Coeff list), (NONE : Coeff option), 
		    map (fn d => coeff (t, d)) ds)) totals


  (* enum n [x1 .. xk] = [(n,x1), .... (n+k, xk)]
  *)
  fun enum n nil = nil
    | enum n (h :: t) = ((n, h) :: enum (n+1) t)


  (* findmax L = i 
     Invariant:
     L <> nil
     forall j \in 1, length L (rj,dj) \in L and L(ri,di) \in L => rj<=ri 
  *)
  fun findmax [(i, x)] = (i, x)
    | findmax ((i, x) :: L) = 
      let 
        val (j, y) = findmax L
      in
        if Real.< (x, y) then (j, y)
        else (i, x)
      end

  (* elect M = M'

     Invariant:
     Let i be the row with the highest non elected coefficient.
     M' = M where line i is altered, 
     where the new "blue" eleement is the first hopeful element in xi. 
  *)
  fun elect M = 
      let 
	val xs = enum 0 (map (fn (_, _, (x, _) :: _) => x) M)
	val (j, y) = findmax xs
      in
	elect' j M 
      end
  and elect' 0 ((W, NONE, (r, d) :: R) :: Ps) = ((W, SOME ((r, d)), R) :: Ps)
    | elect' 0 ((W, SOME rd', (r, d) :: R) :: Ps) = ((rd':: W, SOME ((r, d)), R) :: Ps)
    | elect' n (P :: Ps) = P :: (elect' (n-1) Ps)

  (* dhondt M n = M' 
 
     Invariant :  M' is teh result of electing n candidates in M
  *)
  fun dhondt M 0 = M
    | dhondt M n = dhondt (elect M) (n-1) 

  (* Computing inequalities a la Philips talk.  *)

  fun blue n nil = nil
    | blue n ((_, NONE, R) :: L) = blue (n+1) L
    | blue n ((_, SOME b, R) :: L) = (n, b) :: blue (n+1) L
  
  fun red n nil = nil
    | red n ((_, _, nil) :: L) = red (n+1) L
    | red n ((_, _, r :: _) :: L) = (n, r) :: red (n+1) L

  fun win nil = nil
    | win ((nil, NONE, _) :: L) = 0 :: (win L)
    | win ((W, SOME rd, R) :: L) = (List.length W + 1) :: (win L)
    
  fun clean nil = nil
    | clean (NONE :: L) = clean L
    | clean (SOME x :: L) = x :: clean L

  (* product F B R
 
     Invariant: 
     The blues are no longer functions, corresponding to the forefront of the elected
     The reds are a list of totals, corresponding to the top candidate not elected
  *)
 
  fun pseudomargins ((TL, dl), (TW, dw)) =
    (Real.fromInt dw * Real.fromInt dl) * (TW - TL) / 
    (Real.fromInt dw + Real.fromInt dl)

  fun error ((TL, dl), (TW, dw)) =
      let
	val rl = Real.fromInt dl
	val rw = Real.fromInt dw
      in
	(rl + rw) / (rw * rl * TW - rl * rw * TL) 
      end



  fun product B R f = map (fn (n:int, b) => 
			   map (fn (m:int, r) => 
				if n=m then NONE else SOME (f (r, b))) R) B



  (* Margins for pseudo candidates: *)
  (* (T(W) - T(L)) / ((1 / dw) + (1/dl)) 
     = (T(W) - T(L)) / (dw + dl / dw * dl)
     =  *)
  (* see whiteboard picture from Philips visit 11/2013 *)


  fun samplesize (alpha:real, gamma:real, (Bvoted:real, uvoted:real)) = 
  (* alpha : risk limit
     gamma : tuning constant (small gamma for if you trust the result is ok
                              large gamma if you don't trust it.
			      Difference:  few 
     B : number of valid ballots
     Bblank : number of blank ballots
     u : error
  *)
     let
       val Badjusted = Bvoted * uvoted 
     in
       Math.ln (1.0/alpha) / Math.ln (gamma/(1.0 - 1.0/Badjusted) + 1.0 - gamma)
     end

  (* margins data x y) = m 

     Invariant:
     x is the maximal divisor
     y is the number of mandates
     m are all margins based on 
  *)
  fun margins (totals, n) =
      let 
	val result = dhondt (matrix totals (U.nats n)) n
	val b = blue 0 result
	val r = red 0 result
	val m = product b r pseudomargins
	val eVoted = U.sort Real.> (clean (U.flatten (product b r error)))
	val (uvoted :: _) = eVoted

	val alpha = 0.001
	val gamma = 0.95
	val Bvoted = 2332217.0
	val s = samplesize (alpha, gamma, (Bvoted, uvoted))
	val _ = TextIO.print ("Sample size: " ^ (Real.toString s) ^ "\n")
      in 
	(win result, U.sort Real.< (clean (U.flatten m)), uvoted,  s)
      end
end