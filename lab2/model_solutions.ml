(* model solution for poly function *)
let model_poly x y z =
	x*x*x + 2*x*y*z*z*y*z + 1;;

(* model solution for degrees_to_radians *)
(* Ask Ma'am about issues regarding floating and integer multiplications *)
let model_degrees_to_radians angle:float = 
	let pi = 4.0 *. (atan 1.0) in
		((pi) /. (180.0)) *. angle;;

