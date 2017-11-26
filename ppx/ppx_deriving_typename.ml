module PC   = Ppx_core
module PTC  = Ppx_type_conv.Type_conv
module A    = PC.Ast_builder.Default
module G    = PTC.Generator
module P    = Printf

(*
 *  Given a location, path and a list of type declarations which have
 *  been annotated with [@@deriving typename], generates a structure:
 *  let foo_name = "foo"
 *  Where foo is the name of the type.
 *)
let derive_typename ~(loc : PC.location)
                    ~(path : string)
                    ((_ : PC.rec_flag), (tdls : PC.type_declaration list)) 
                    : PC.structure =
  ignore path;
  let open PC in
  let from_type_decl (td : PC.type_declaration) =
    let name = P.sprintf "%s_name" td.ptype_name.txt in
    let binding = A.pvar ~loc name in
    let btype = [%type: string] in
    let pat = A.ppat_constraint ~loc binding btype in
    let expr = A.estring ~loc (td.ptype_name.txt) in
    let vb = A.value_binding ~loc ~pat ~expr in
    A.pstr_value ~loc PC.Nonrecursive [vb]
  in
  List.map ~f:from_type_decl tdls

(* Register *)
let () = 
  let str_type_decl = G.make_noarg derive_typename in
  PTC.ignore (PTC.add "typename" ~str_type_decl)
