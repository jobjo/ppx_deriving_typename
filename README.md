# ppx_deriving_typename
This project serves as a simple example of how to build type driver ppx rewriters.
It defines a silly ppx `ppx_deriving_typename` for deriving the names of 
custom data types defined with a `[@@deriving typename]` attribute.

For example:

```ocaml
type address = Email of string [@@deriving typename]

type person = { name : string } [@@deriving typename]

```
yields the following code once piped through the ppx processor:

```ocaml
type address = | Email of string 
let _ = fun (_ : address)  -> () 
let (address_name : string) = "address" 
let _ = address_name 
type person = { name: string }
let _ = fun (_ : person)  -> () 
let (person_name : string) = "person" 
let _ = person_name 
```

The rewriter itself is defined in `ppx/ppx_deriving_typename.ml`.

### Build and run

`make test` to execute the code in `test/run.ml`.
`make test-source` to print the rewritten source of `test/run.ml`.

### How it works
The ppx driver is defined in `ppx/ppx_derive_typename.ml`. The implementation
uses the following libraries and other ppx rewriters:

- [Ppx_core](https://github.com/janestreet/ppx_core) - Standard library for ppx rewriters
- [Ppx_type_conv](https://github.com/janestreet/ppx_type_conv) - A support library for type driven code generators 
- [Ppx_driver](https://github.com/janestreet/ppx_driver) - Driver for AST transformers
- [Ppx_metaquot](https://github.com/janestreet/ppx_metaquot) - A ppx rewriter allowing you to write values representing the OCaml AST in the OCaml syntax.  
