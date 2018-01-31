open Test1

let gpt_easy = 2.0/.20.0;;
let gpt = 8.0/.80.0;;

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

let ways amt a b c d = 
	if amt <=0 || a<=0 || b<=0 || c<=0 || d<=0 || a = b || a = c || a = d || b = c || b = d || c = d 
	then -1 
	else
	ways_helper amt a b c d 1;;

let pagal amt a b c d f = amt, a, b, c, d, f;;

let test_coinChanger amt a b c d = 
	let student = Test1.coinChanger amt a b c d in
	let ta = ways amt a b c d in
	if student == ta then (if ta == -1 then gpt_easy else gpt)
	else 0.0;;

let grade = ref 0.0;;

let rec test() = 
	let ic = Scanf.Scanning.open_in "vpl_evaluate.cases" in
	try
		while true 
		do
			let amt,a,b,c,d,f = Scanf.bscanf ic "%d %d  %d %d %d %d\n" pagal in
			(grade := (!grade +. (test_coinChanger amt a b c d)))
		done
	with End_of_file -> Scanf.Scanning.close_in ic;; 

test();;
print_float (!grade);;