open Array
open Printf

let gpt = 0.1;;

let test3_runner mat = 
	let student = Test3.rowEchelon mat in
	let ta = Model.rowEchelon mat in
	if student = ta then gpt
	else 0.0;;

let mat = Model.read_mat_from_carg;;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (test3_runner mat);   (* write something *)   
  close_out oc;;