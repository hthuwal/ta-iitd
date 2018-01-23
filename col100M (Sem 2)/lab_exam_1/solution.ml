(* Solution to part (a) -- number of ways in which coins a, b, c, d can be used to create amount amt.
k is the parameter that controls which of a, b, c, d are available - required since they 
cannot use lists.*)

let rec ways_helper amt a b c d k = 
	if amt = 0 then 1
	else if amt < 0 then 0
	else match k with
	| 1 -> (ways_helper (amt-a) a b c d k) + (ways_helper amt a b c d (k+1))
	| 2 -> (ways_helper (amt-b) a b c d k) + (ways_helper amt a b c d (k+1))
	| 3 -> (ways_helper (amt-c) a b c d k) + (ways_helper amt a b c d (k+1))
	| 4 -> (ways_helper (amt-d) a b c d k)
	| _ -> 0 ;;

let ways amt a b c d = ways_helper amt a b c d 1;;

(* Solution to part (b) -- best way to combine coins a, b, c, d to create amount amt.
'best' is defined by a weight function which is a parameter to  the main cost function*)

let weight x = 2*x;;
let weightI x = 100 - x;;

let rec cost_helper amt a b c d k f= 
	if amt = 0 then 0
	else if amt < 0 then 0
	else match k with
	| 1 -> min ((f a) + (cost (amt-a) a b c d k f)) (cost amt a b c d (k+1) f)
	| 2 -> min ((f b) + (cost (amt-b) a b c d k f)) (cost amt a b c d (k+1) f)
	| 3 -> min ((f c) + (cost (amt-c) a b c d k f)) (cost amt a b c d (k+1) f)
	| 4 -> (f d) + (cost (amt-d) a b c d k f)
	| _ -> 0

let cost amt a b c d f = cost_helper a b c d 1 f
