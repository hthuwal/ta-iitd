open Array
open Printf
open Printexc

let gpt = 0.1;;

let test5_runner mat b=  
	let student = 
		try List.map string_of_float (Test5.solve mat b)
		with 
			Test5.Dimension_mismatch -> ["Dimension_mismatch"]
		|   Test5.No_solutions -> ["No_solutions"]
		|   Test5.Infinite_solutions -> ["Infinite_solutions"]
		|   _ -> ["Something weird"]
	in 
	let ta = 
		try List.map string_of_float (Model.solve mat b)
		with 
			Model.Dimension_mismatch -> ["Dimension_mismatch"]
		|   Model.No_solutions -> ["No_solutions"]
		|   Model.Infinite_solutions -> ["Infinite_solutions"]
		|   _ -> ["Something weird"]
	in
	if student = ta then gpt
	else 0.0;;

let rec remove_last l ans= match l with
[] -> []
|x::y::[] -> ans @ [x]
|x::tl -> remove_last tl (ans @ [x]);;

let mat = Model.read_mat_from_carg;;

let b = List.nth mat ((List.length mat) - 1);;
let mat = remove_last mat [];;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (test5_runner mat b);   (* write something *)   
  close_out oc;;