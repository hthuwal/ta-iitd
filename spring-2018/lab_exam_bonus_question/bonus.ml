let rec cost_helper amt a b c d k f = 
	if amt = 0 then 0
	else if amt < 0 then max_int
	else match k with
	| 1 -> let temp = (cost_helper (amt-a) a b c d k f) in 
				if temp != max_int then min ((f a) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 2 -> let temp = (cost_helper (amt-b) a b c d k f) in 
				if temp != max_int then min ((f b) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 3 -> let temp = (cost_helper (amt-c) a b c d k f) in 
				if temp != max_int then min ((f c) + temp) (cost_helper amt a b c d (k+1) f)
				else min (max_int) (cost_helper amt a b c d (k+1) f)

	| 4 -> let temp = (cost_helper (amt-d) a b c d k f) in 
				if temp != max_int then (f d) + temp
				else max_int
	| _ -> 0 ;;

let coinChanger_cost amt a b c d f = 
	if amt <=0 || a<=0 || b<=0 || c<=0 || d<=0 || a = b || a = c || a = d || b = c || b = d || c = d 
	then -1 
	else
	cost_helper amt a b c d 1 f ;;