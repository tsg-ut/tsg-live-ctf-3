type in_channel
external bytes_create : int -> bytes = "caml_create_bytes"

external open_descriptor_in : int -> in_channel = "caml_ml_open_descriptor_in"
external set_in_channel_name: in_channel -> string -> unit =
  "caml_ml_set_channel_name"

type open_flag =
    Open_rdonly | Open_wronly | Open_append
  | Open_creat | Open_trunc | Open_excl
  | Open_binary | Open_text | Open_nonblock

external open_desc : string -> open_flag list -> int -> int = "caml_sys_open"

let open_in_gen mode perm name =
  let c = open_descriptor_in(open_desc name mode perm) in
  set_in_channel_name c name;
  c
let open_in name =
  open_in_gen [Open_rdonly; Open_text] 0 name
external input_scan_line : in_channel -> int = "caml_ml_input_scan_line"
external unsafe_input : in_channel -> bytes -> int -> int -> int
                      = "caml_ml_input"

let ic = open_in "/home/user/flag"

let n = input_scan_line ic

let res = bytes_create n

let _ = unsafe_input ic res 0 n

(* res *)

