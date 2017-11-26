type address = | Email of string [@@deriving typename]

type person = { name : string } [@@deriving typename]

let () = 
  Printf.printf 
    "Type names of address and person are \"%s\" and \"%s\".\n" 
    address_name
    person_name
