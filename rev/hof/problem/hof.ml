let b = fun x -> (x + 1) mod 1000000007 in
let h = fun x -> fun y -> x (x y) in
Printf.printf "TSGCTF{%d}" ((h (h (h h))) h h h h b 0)
