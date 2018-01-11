(* model solution for poly function *)
let model_poly x y z =
	x*x*x + 2*x*y*z*z*y*z + 1;;

(* model solution for degrees_to_radians *)
(* Ask Ma'am about issues regarding floating and integer multiplications *)
let model_degrees_to_radians angle:float = 
	let pi = 4.0 *. (atan 1.0) in
		((pi) /. (180.0)) *. angle;;

(* model solution for natural logarithm *)
let model_nlog x:float = 
	log (x +. sqrt(x *. x +. 1.0));;

(* model solution for cube root *)
let model_mcuberoot (x:float) (y:float) (z:float) = 
	(x*.y*.z)**(1.0/.3.0);;