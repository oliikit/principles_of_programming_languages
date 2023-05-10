open OUnit2
open Assignment

(*
  This file contains a few tests but not necessarily complete coverage.  You are
   encouraged to think of more tests if needed for the corner cases.
   We will cover the details of the test syntax but with simple copy/paste it should
   not be hard to add new tests of your own without knowing the details.
   1) Write a new let which performs the test, e.g. let test_assoc _ = ...
   2) Add that let-named entity to one of the test suite lists such as section1_tests
      by adding e.g.
       "Assoc"       >:: test_assoc;

   Thats it! OR, even easier, just add another `assert_equal` to the existing tests.
   They will not be submitted with the rest of your code, so you may alter this file as you wish.

   Recall that you need to type "dune test" to your shell to run the test suite.
*)

let test_function_types _ =
  let _ = f1 true false in
  let _ = f2 List.cons [] 1 in
  let _ = f3 int_of_string (fun () -> "20") () in
  let _ = f4 (Some (fun x -> x)) in
  let _ =
    f5 [ 1; 2; 3; 4; 5; 6 ] (fun n ->
        if n mod 2 = 1 then Some (float_of_int n) else None)
  in
  let _ = f6 (fun n -> n < 0) (fun b -> not b) (Right false) in
  let _ = f7 [ Left 1; Right true ] in
  ()

let section1_tests = "Section1" >::: [ "FunctionTypes" >:: test_function_types ]

let test_list_of_sequence _ =
  assert_equal [ 1; 2 ] (list_of_sequence one_and_two);
  assert_equal [ 0; 0; 0; 0; 0 ] (list_of_sequence (cut_sequence 5 zeroes));
  assert_equal [ 0; 1; 3; 6 ] (list_of_sequence (cut_sequence 4 triangles))

let test_triangles _ =
  assert_equal
    [ 0; 1; 3; 6; 10; 15; 21; 28; 36; 45 ]
    (list_of_sequence (cut_sequence 10 triangles))

let test_fibonacci _ =
  assert_equal
    [ 0; 1; 1; 2; 3; 5; 8; 13]
    (list_of_sequence (cut_sequence 8 fibonacci))

let test_mapi_sequence _ =
  assert_equal [ 0; 1; 9; 36; 100 ]
    (cut_sequence 5 triangles
    |> mapi_sequence (fun _ x -> x * x)
    |> list_of_sequence);
  assert_equal "3:6"
    (cut_sequence 5 triangles
    |> mapi_sequence (fun i x -> string_of_int i ^ ":" ^ string_of_int x)
    |> cut_sequence 4 |> nth_sequence 3)

let test_filter_map_sequence _ =
  assert_equal [ 1; 7; 11; 29; 37 ]
    (cut_sequence 10 triangles
    |> filter_map_sequence (fun n -> if n mod 2 = 0 then Some (n + 1) else None)
    |> list_of_sequence);
  assert_equal [ 4; 25; 64 ]
    (cut_sequence 8 fibonacci
    |> filter_map_sequence (fun n -> if n mod 3 = 2 then Some (n * n) else None)
    |> list_of_sequence)

let section2_tests =
  "Section2"
  >::: [
         "list_of_sequence" >:: test_list_of_sequence;
         "triangles" >:: test_triangles;
         "fibonacci" >:: test_fibonacci;
         "mapi_sequence" >:: test_mapi_sequence;
         "filter_map_sequence" >:: test_filter_map_sequence;
       ]

let atree =
  Node
    ( 1,
      [
        Node
          ( 2,
            [
              Node (3, []);
              Node (4, []);
              Node (5, [ Node (6, []) ]);
              Node (7, []);
            ] );
        Node (8, []);
      ] )

let test_tree_fold _ =
  assert_equal 36 (tree_fold (fun acc n -> acc + n) 0 atree);
  assert_equal "12345678"
    (tree_fold (fun acc n -> acc ^ string_of_int n) "" atree)

let test_find_in_tree _ =
  assert_equal [ 1; 2; 3; 4; 5; 6; 7; 8 ]
    (find_in_tree (function x -> x > 0) atree);
  assert_equal [ 1; 4; 7 ] (find_in_tree (function x -> x mod 3 = 1) atree)

let coded_tree =
  [ ("a", 2); ("b", 2); ("c", 0); ("d", 0); ("e", 1); ("f", 1); ("g", 0) ]

let test_decode_tree _ =
  assert_equal (decode_tree coded_tree)
  @@ Node
       ( "a",
         [
           Node ("b", [ Node ("c", []); Node ("d", []) ]);
           Node ("e", [ Node ("f", [ Node ("g", []) ]) ]);
         ] )

let section3_tests =
  "Section3"
  >::: [
         "tree_fold" >:: test_tree_fold;
         "find_in_tree" >:: test_find_in_tree;
         "decode_tree" >:: test_decode_tree;
       ]

(* let square_of n = n * n
   let dec n = n - 1 *)

(* NOTE: Delete these two lines once you finish implementing Section 4 *)
let cached_square_of _ = unimplemented ()
let cached_dec _ = unimplemented ()

(* Note: Use these two functions instead to test your Section 4 answer *)
(* let cached_square_of = make_cached_fun square_of
   let cached_dec = make_cached_fun dec *)

let test_cached_fun _ =
  assert_equal 9
    (let _ = cached_square_of 1 in
     let _ = cached_square_of 2 in
     let _ = cached_square_of 3 in
     let _ = cached_square_of 4 in
     cached_square_of 3);
  assert_equal 0
    (let _ = cached_dec 1 in
     let _ = cached_dec 2 in
     let _ = cached_dec 1 in
     let _ = cached_dec 4 in
     cached_dec 1)

let section4_tests = "Section4" >::: [ "CachedFun" >:: test_cached_fun ]

let series =
  "Assignment"
  >::: [ section1_tests; section2_tests; section3_tests; section4_tests ]

let () = run_test_tt_main series
