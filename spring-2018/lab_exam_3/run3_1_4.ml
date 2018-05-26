open Test
open Model
open Cell
open Array
open Printf


let gpt = 0.2;;

let sudoku_student = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_teacher = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_original = Array.make_matrix size size (PossibleValues (getList size []));;

let inpfile = Sys.argv.(1);;
let i = int_of_string Sys.argv.(2);;
let j = int_of_string Sys.argv.(3);;
Model.readInput inpfile sudoku_student;;
Model.readInput inpfile sudoku_teacher;;
Model.readInput inpfile sudoku_original;;

let print_bool b = if b = true then print_string "True\n" else print_string "False\n";;

let print_error i j student ta = 
    print_string "INCORRECT ANSWER: \n"; 
    Printf.printf "i: %d, j: %d\n" i j;
    Model.comparePrintSudokus sudoku_teacher sudoku_student sudoku_original;
    print_string "Expected Return Value: ";
    print_bool ta;
    print_string "Your Return Value: ";
    print_bool student;
    print_string "\n";;

let runner sudoku_stud sudoku_ta i j = 
    let student = Test.eliminate sudoku_stud i j in
    let ta = Model.eliminate sudoku_ta i j in
    if (student = ta) && (Model.compareSudokus sudoku_stud sudoku_ta) then (gpt)
    else (print_error i j student ta;0.0);;
    (* if student = ta then (print_string "CORRECT ANSWER\n"; gpt)
    else(print_string "INCORRECT ANSWER: \nMATRIX A\n";Model.print_mat (List.map Model.apply mat); print_string "\nVECTOR b: "; Model.print_list (Model.apply b); print_string "\n\nEXPECTED ANSWER: ";print_bool ta; print_string "\n\nYOUR ANSWER: "; print_bool student; print_string "\n";0.0);;
 *)


let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (runner sudoku_student sudoku_teacher i j);   (* write something *)   
  close_out oc;;
