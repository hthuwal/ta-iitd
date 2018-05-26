open Array
open Printf

let gpt = 0.0125;;

let print_bool b = if b = true then print_string "True" else print_string "False" ;;

let test1_runner mat b = 
	let student = Test1.checkDimension mat b in
	let ta = Model.checkDimension mat b in
	if student = ta then (print_string "CORRECT ANSWER\n"; gpt)
	else(print_string "INCORRECT ANSWER: \nMATRIX A\n";Model.print_mat (List.map Model.apply mat); print_string "\nVECTOR b: "; Model.print_list (Model.apply b); print_string "\n\nEXPECTED ANSWER: ";print_bool ta; print_string "\n\nYOUR ANSWER: "; print_bool student; print_string "\n";0.0);;


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
  fprintf oc "%f\n" (test1_runner mat b);   (* write something *)   
  close_out oc;;
