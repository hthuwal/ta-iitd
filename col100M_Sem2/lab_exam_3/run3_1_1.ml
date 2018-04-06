open Test
open Model
open Cell
open Array
open Printf


let sudoku_student = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_teacher = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_original = Array.make_matrix size size (PossibleValues (getList size []));;

let inpfile = Sys.argv.(1);;
let value = int_of_string Sys.argv.(2);;
let row = int_of_string Sys.argv.(3);;
Model.readInput inpfile sudoku_student;;
Model.readInput inpfile sudoku_teacher;;
Model.readInput inpfile sudoku_original;;

let gpt = 0.2;;

let print_bool b = if b = true then print_string "True\n" else print_string "False\n";;

let print_error value row student ta = 
    print_string "INCORRECT ANSWER: \n"; 
    Printf.printf "Value: %d, Row: %d\n" value row;
    Model.comparePrintSudokus sudoku_teacher sudoku_student sudoku_original;
    print_string "Expected Return Value: ";
    print_bool ta;
    print_string "Your Return Value: ";
    print_bool student;
    print_string "\n";;

let runner sudoku_stud sudoku_ta value row = 
    let orig_sudoku = sudoku_stud in
    let student = Test.eliminateValueRow sudoku_stud value row in
    let ta = Model.eliminateValueRow sudoku_ta value row in
    if (student = ta) && (Model.compareSudokus sudoku_stud sudoku_ta) then (gpt)
    else (print_error value row student ta;0.0);;
   

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (runner sudoku_student sudoku_teacher value row);   (* write something *)   
  close_out oc;;
