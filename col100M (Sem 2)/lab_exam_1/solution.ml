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

let rec cost_helper amt a b c d k f = 
	if amt = 0 then 0
	else if amt < 0 then max_int
	else match k with
	| 1 -> let temp = (cost_helper (amt-a) a b c d k f) in 
				if temp != max_int then min ((f a) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 2 -> let temp = (cost_helper (amt-b) a b c d k f) in 
				if temp != max_int then min ((f b) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 3 -> let temp = (cost_helper (amt-c) a b c d k f) in 
				if temp != max_int then min ((f c) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 4 -> let temp = (cost_helper (amt-d) a b c d k f) in 
				if temp != max_int then (f d) + temp
				else max_int
	| _ -> 0 ;;

let cost amt a b c d f = cost_helper amt a b c d 1 f ;;

let pagal amt a b c d f = amt, a, b, c, d, f;;

let test ()=
	let ic = Scanf.Scanning.open_in "in.txt" in
	try
		while true 
		do
			let amt,a,b,c,d,f = Scanf.bscanf ic "%d %d  %d %d %d %d\n" pagal in
			if f = 0 then 
				(print_int (ways amt a b c d); print_string" ";print_int (cost amt a b c d weight); print_newline())
			else
				(print_int (ways amt a b c d); print_string" ";print_int (cost amt a b c d weightI); print_newline())
		done
	with End_of_file -> Scanf.Scanning.close_in ic;; 

test();;