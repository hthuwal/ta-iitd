open List
exception Not_a_matrix
exception Dimension_mismatch
exception No_solutions
exception Infinite_solutions

let read_list_from_carg = let l = (Array.length Sys.argv) in List.map float_of_string (Array.to_list (Array.sub (Sys.argv) 1 (l-1)))

let convert_helper a i = Array.to_list (Array.sub a (i+1) (int_of_float a.(i))) ;;

let rec read_mat_helper mat l i = 
	if Array.length l = i 
	then 
		mat 
	else 
		let newmat = mat @ [(convert_helper l i)] in 
		read_mat_helper newmat l (i + int_of_float(l.(i)) + 1) ;;

let read_mat_from_carg = 
	let l = (Array.length Sys.argv) in 
		let flat = Array.map float_of_string (Array.sub (Sys.argv) 1 (l-1)) in
			read_mat_helper [] flat 0;;


let rec dimension l = 
	match l with
	| [] -> 0
	| hd::tl -> 1 + (dimension tl)

let rec dimension2H mat dim = 
	match mat with
	| [] -> dim
	| row1::rest -> if (dimension row1) = (snd dim)
			then dimension2H rest ((1+(fst dim)),(snd dim))
			else raise Not_a_matrix

let dimension2 mat = 
	match mat with
	| [] -> (0,0)
	| row1::rest -> dimension2H rest (1, (dimension row1))

let checkDimension mat b = 
	try
		let m = (dimension2 mat) in
			let n = (dimension b) in
				if (fst m) = n then true
				else false
	with e ->
		false

let rec insertH l i a = 
	if i = 0 then
		((a::(tl l)), (hd l))
	else
		let z = (insertH (tl l) (i-1) a) in
			(((hd l)::(fst z)),(snd z))
		
		
let rec swapH l i j =
	if i = 0 then
		let z = insertH (tl l) (j-1) (hd l) in
			(snd z)::(fst z)
	else
		(hd l)::(swapH (tl l) (i-1) (j-1))


let swap l i j = 
	if (i = j) then l
	else if (i < j) then swapH l i j
	else swapH l j i	


let rec multH l c = 
	match l with
	| [] -> []
	| hd::tl -> (hd *. c)::(multH tl c)

let rec mult mat i c = 
	if i = 0 then (multH (hd mat) c)::(tl mat)
	else (hd mat)::(mult (tl mat) (i-1) c)

let rec addLists l1 l2 = 
	match l1 with
	| [] -> []
	| h::t -> (h +. (hd l2))::(addLists t (tl l2))

let rec replace l i x = 
	if i = 0 then
		x::(tl l)
	else
		(hd l):: (replace (tl l) (i-1) x)

let rec addRows mat i j = 
	let r1 = nth mat i in
	let r2 = nth mat j in
	replace mat i (addLists r1 r2) 

let rec firstNonZeroIndex l i = 
	match l with
	| [] -> max_int
	| hd::tl -> if ( hd > 0. || hd < 0.) then i
		    else (firstNonZeroIndex tl (i+1))

let rec firstNonZeroColumn mat =
	match mat with 
	| [] -> max_int
	| hd::tl ->  let z = (firstNonZeroIndex hd 0) in
	let k = (firstNonZeroColumn tl) in
		if z < k then z else k

let rec hasNonZeroIndex l i = 
	if (i = 0) then let k = (hd l) in (k < 0. || k > 0.)
	else hasNonZeroIndex (tl l) (i-1)

let rec firstRowWithLead mat i rowNum= 
	match mat with	
	| [] -> max_int
	| hd::tl -> if (hasNonZeroIndex hd i) then rowNum
		    else (firstRowWithLead tl i (rowNum+1))


let rec normalizeH mat c j =
	if (j = 0) then mat
	else
		let mat0c = (nth (nth mat 0) c) in
		let matjc = (nth (nth mat j) c) in
		let x = ((-1. *. matjc)/. mat0c) in
		let z = (mult mat 0 x) in
		let f = (addRows z j 0) in
		normalizeH ((hd mat)::(tl f)) c (j-1)
	
let normalize mat c = 
	match mat with 
	| [] -> []
	| row1::rest -> normalizeH mat c ((length mat)-1)

let rec rowEchelon mat = 
	match mat with 
	| [] -> []
	| _ ->
	let c = firstNonZeroColumn mat in
		if c = max_int then mat
		else
			let r = firstRowWithLead mat c 0 in
			let mat1 = swap mat 0 r in
			let mat2 = normalize mat1 c in 
			(hd mat2)::(rowEchelon (tl mat2))


let rec numSolutionsH mat c =
	match mat with
	| [] -> 1
	| hd::tl -> let z = (firstNonZeroIndex hd 0) in
		    if (c = z)
		    then (numSolutionsH tl (c+1))
		    else if ((length hd) = (z + 1)) then 0
		    else max_int


let numSolutions mat = numSolutionsH (rowEchelon mat) 0

let rec mySum l = 
	match l with
	| [] -> 0.
	| h::t -> h +. (mySum t)

let rec solveEqnH a row currSol currSum = 
	match currSol with
	| [] -> ((mySum row) +. currSum)/. a
	| h::t -> (solveEqnH a (tl row) t (h *. (hd row) *. (-1.) +. currSum))

let rec solveEqn row currSol = 
	let z = hd row in
	if (z < 0. || z > 0.) then solveEqnH (hd row) (tl row) currSol 0.
	else solveEqn (tl row) currSol
		

let rec solveRowEchelonH mat currSol = 
	match mat with
	| [] -> currSol
	| row1::rest -> solveRowEchelonH (rest) ((solveEqn row1 currSol)::currSol)

let solveRowEchelon mat = 
	let rmat = rev mat in
	solveRowEchelonH rmat []

let rec createMat mat b = 
	match mat with
	| [] -> []
	| h::t -> (h @ [(hd b)])::(createMat t (tl b))


let solve mat b = 
	if (checkDimension mat b) = false then raise Dimension_mismatch
	else 
		let mat1 = createMat mat b in
		let n = numSolutions mat1 in
		if n = 0 then raise No_solutions
		else if n = max_int then raise Infinite_solutions
		else solveRowEchelon (rowEchelon mat1)		


let rec print_list l = match l with
[] -> ()
|x::xs -> print_float(x);print_string " " ;print_list xs;;

let rec print_mat m = match m with
[] -> ()
|row::xs -> print_list row; print_newline();print_mat xs;;
