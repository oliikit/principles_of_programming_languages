open OUnit2
open Assignment

(*
  This file contains a few tests but not necessarily complete coverage.  You are
   encouraged to think of more tests if needed for the corner cases.
   We will cover the details of the test syntax but with simple copy/paste it should
   not be hard to add new tests of your own without knowing the details.
   1) Write a new let which performs the test, e.g. let test_gcd_2 _ = ...
   2) Add that let-named entity to one of the test suite lists such as section1_tests
      by adding e.g.
       "GCD 2"       >:: test_gcd_2;

   Thats it! OR, even easier, just add another `assert_equal` to the existing tests.
   They will not be submitted with the rest of your code, so you may alter this file as you wish.

   Recall that you need to type "dune test" to your shell to run the test suite.
*)

let test_nth_exn _ =
  assert_equal (nth_exn 0 [ 1; 2; 3; 4 ]) 1;
  assert_equal (nth_exn 3 [ 1; 2; 3; 4 ]) 4;
  assert_equal (nth_exn 1 [ "Voyage"; "Shipwreck"; "Salvage" ]) "Shipwreck"

let test_mk_pairs _ =
  assert_equal
    (mk_pairs "ST" [ "TOS"; "TNG"; "DS9" ])
    [ ("ST", "TOS"); ("ST", "TNG"); ("ST", "DS9") ];
  assert_equal
    (mk_pairs 1 [ "Day more"; "Night in Bangkok"; "Last Time" ])
    [ (1, "Day more"); (1, "Night in Bangkok"); (1, "Last Time") ];
  assert_equal (mk_pairs 0 []) []

let test_pair_up _ =
  assert_equal
    (pair_up [ "Do"; "Re"; "Mi" ]
       [ "Deer"; "Golden sun"; "Name I call myself" ])
    [ ("Do", "Deer"); ("Re", "Golden sun"); ("Mi", "Name I call myself") ];
  assert_equal
    (pair_up [ 1; 2; 3; 4 ]
       [
         "The cow as white as milk";
         "The cape as red as blood";
         "The hair as yellow as corn";
         "The slippers as pure as gold";
       ])
    [
      (1, "The cow as white as milk");
      (2, "The cape as red as blood");
      (3, "The hair as yellow as corn");
      (4, "The slippers as pure as gold");
    ]

let test_cartesian_product _ =
  assert_equal
    (List.sort compare @@ cartesian_product [ 1; 3; 5 ] [ 2; 6 ])
    (List.sort compare @@ [ (1, 2); (1, 6); (3, 2); (3, 6); (5, 2); (5, 6) ]);
  assert_equal
    (List.sort compare
    @@ cartesian_product [ "Crimson"; "Cerulean" ] [ "Flask"; "Seed"; "Dagger" ]
    )
    (List.sort compare
    @@ [
         ("Crimson", "Flask");
         ("Crimson", "Seed");
         ("Crimson", "Dagger");
         ("Cerulean", "Flask");
         ("Cerulean", "Seed");
         ("Cerulean", "Dagger");
       ])

let section1_tests =
  "Section 1"
  >: test_list
       [
         "nth_exn" >:: test_nth_exn;
         "mk_pairs" >:: test_mk_pairs;
         "pair_up" >:: test_pair_up;
         "cartesian_product" >:: test_cartesian_product;
       ]

let test_good_grid_1 =
  [
    [ 22; 20; 19; 25; 26; 27 ];
    [ 21; 23; 24; 18; 28; 29 ];
    [ 02; 01; 12; 13; 17; 30 ];
    [ 03; 04; 11; 14; 16; 31 ];
    [ 07; 05; 09; 10; 15; 32 ];
    [ 06; 08; 36; 35; 34; 33 ];
  ]

let test_bad_grid_1 =
  [
    [ 22; 20; 19; 25; 26; 27 ];
    [ 21; 23; 24; 18; 28; 29 ];
    [ 02; 01; 12; 13; 17; 30 ];
    [ 03; 04; 11; 14; 16; 31 ];
    [ 07; 05; 09; 10; 15; 32 ];
    [ 06; 08; 35; 36; 34; 33 ];
  ]

let test_fetch_val _ =
  assert_equal (fetch_val [ [ 1; 2; 3 ]; [ 4; 5; 6 ]; [ 7; 8; 9 ] ] (0, 0)) 1;
  assert_equal (fetch_val [ [ 1; 2; 3 ]; [ 4; 5; 6 ]; [ 7; 8; 9 ] ] (2, 1)) 8

let test_fetch_neighbor_coords _ =
  assert_equal
    (List.sort compare @@ fetch_neighbor_coords test_good_grid_1 (0, 0))
    (List.sort compare [ (0, 1); (1, 0); (1, 1) ]);
  assert_equal
    (List.sort compare @@ fetch_neighbor_coords test_good_grid_1 (2, 2))
    (List.sort compare
       [ (1, 1); (1, 2); (1, 3); (2, 1); (2, 3); (3, 1); (3, 2); (3, 3) ])

let test_get_next_pos _ =
  assert_equal (get_next_pos test_good_grid_1 (0, 0)) (Some (1, 1));
  assert_equal (get_next_pos test_good_grid_1 (2, 1)) (Some (2, 0));
  assert_equal (get_next_pos test_bad_grid_1 (5, 4)) None

let test_verify_solution _ =
  assert_equal (verify_solution 6 6 test_good_grid_1) true;
  assert_equal (verify_solution 6 6 test_bad_grid_1) false

let section2_tests =
  "Section 2"
  >: test_list
       [
         "fetch_val" >:: test_fetch_val;
         "fetch_neighbor_coords" >:: test_fetch_neighbor_coords;
         "get_next_pos" >:: test_get_next_pos;
         "verify_solution" >:: test_verify_solution;
       ]

let series = "Assignment1 Tests" >::: [ section1_tests; section2_tests ]
let () = run_test_tt_main series
