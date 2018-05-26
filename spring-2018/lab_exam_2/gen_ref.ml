open Array
open Printf

let mat = Model.read_mat_from_carg;;

let x = Model.numSolutions mat;;

if x = 1
then
	Model.print_mat mat
else
	print_string("Bye")