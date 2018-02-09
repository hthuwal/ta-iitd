open Test2

let gpt_easy = 0.1;;
let gpt = 1.1;;

(* Solution to part (b) -- best way to combine coins a, b, c, d to create amount amt.
'best' is defined by a weight function which is a parameter to  the main cost function*)

let weight x = int_of_float ((float_of_int 2)** (float_of_int x));;
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

let cost amt a b c d f = 
	if amt <=0 || a<=0 || b<=0 || c<=0 || d<=0 || a = b || a = c || a = d || b = c || b = d || c = d 
	then -1 
	else
	cost_helper amt a b c d 1 f ;;

let pagal amt a b c d f = amt, a, b, c, d, f;;

let test_coinChanger_cost amt a b c d f = 
	let student = Test2.coinChanger_cost amt a b c d f in
	let ta = cost amt a b c d f in
	if student == ta then (if ta == -1 then gpt_easy else gpt)
	else 0.0;;

let grade = ref 0.0;;

let rec test() = 
	let ic = Scanf.Scanning.open_in "bonus_evaluate.cases" in
	try
		while true 
		do
			let amt,a,b,c,d,f = Scanf.bscanf ic "%d %d  %d %d %d %d\n" pagal in
			if f = 0 then 
				(grade := (!grade +. (test_coinChanger_cost amt a b c d weight)))
			else
				(grade := (!grade +. (test_coinChanger_cost amt a b c d weightI)))
				
		done
	with End_of_file -> Scanf.Scanning.close_in ic;; 

test();;
grade := !grade /. 20.0;;
print_float (!grade);;