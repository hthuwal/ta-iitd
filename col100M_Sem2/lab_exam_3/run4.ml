open Test
open Model
open Cell
open Array
open Printf


let gpt = 0.2;;

let sudoku_student = Array.make_matrix size size (PossibleValues (getList size []));;
let sudoku_original = Array.make_matrix size size (PossibleValues (getList size []));;

let inpfile = Sys.argv.(1);;

Model.readInput inpfile sudoku_student;;
Model.solveHumanistic sudoku_student;;
Model.readInput inpfile sudoku_original;;

let print_bool b = if b = true then print_string "True\n" else print_string "False\n";;

let runner sudoku_stud = 
    let stud = Test.solveBruteForce sudoku_stud in
    let check = Model.testMySudoku sudoku_stud inputGrid in 
    print_bool check;
    if (check) then (gpt)
    else (print_string "INCORRECT ANSWER\n";0.0);;

let file = "result.txt";;
let () =
  (* Write message to file *)
  let oc = open_out_gen [Open_creat; Open_text; Open_append] 0o640 file in  (* create or truncate file, return channel *)
  fprintf oc "%f\n" (runner sudoku_student);   (* write something *)   
  close_out oc;;
