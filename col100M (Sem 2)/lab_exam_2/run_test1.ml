(* open Test1 *)
open Model
open Array
open Printf

let gpt = 0.1;;

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

let z = read_list_from_carg;;

let rec print_list l = match l with
[] -> ()
|x::xs -> print_float(x);print_string " " ;print_list xs;;

let rec print_mat m = match m with
[] -> ()
|row::xs -> print_list row; print_newline();print_mat xs;;

