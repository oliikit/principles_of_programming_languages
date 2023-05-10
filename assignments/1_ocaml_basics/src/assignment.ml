(*

PL Assignment 1
 
Name                  : 
List of Collaborators :

Please make a good faith effort at listing people you discussed any 
problems with here, as per the course academic integrity policy.  
CAs/Prof need not be listed!

Fill in the function definitions below replacing the 

  unimplemented ()

with your code.  Feel free to add "rec" to any function listed to make
it recursive. In some cases, you will find it helpful to define
auxillary functions, feel free to.

Several of the questions below involve computing well-known mathematical functions;
if you are not familiar with the function named your trusty search engine
should be able to give you an answer, and feel free to ask on Piazza.

You must not use any mutation operations of OCaml for any of these
questions (which we have not taught yet in any case): no arrays,
for- or while-loops, references, etc.

Note for this first assignment you can only use things in standard library Stdlib; 
you **cannot** use list library functions such as `List.hd` or `List.nth` 
(you can code your own versions of them, of course).

*)

(* Disables "unused variable" warning from dune while you're still solving these! *)
[@@@ocaml.warning "-27"]

(* Here is a simple function which gets passed unit, (), as argument
   and raises an exception.  It is the initial implementation below. *)

let unimplemented () = failwith "unimplemented"

(* ************** Section One: List operations ************** *)

(*
  1a. Write a function that will return the value at a given index (location) in a list. Raise an 
      exception if the provided index is negative or out of bounds.  The first element is indexed 0.
*)

let nth_exn (n : int) (lst : 'a list) : 'a = unimplemented ()

(*
# nth_exn 1 [1;2;3;4] ;;
- : int = 2
# nth_exn 2 ["TOS";"TNG";"DS9"] ;;
- : string = "DS9"
*)

(*
  1b. Write a function that, when given an element elt and a list, will return a 
      new list consisting of pairs of elt coupled with every element in the list.
      If the provided list is empty, simply return an empty list.
*)

let mk_pairs (elt : 'a) (lst : 'b list) : ('a * 'b) list = unimplemented ()

(*
# mk_pairs "int" [1;2;3;4] ;;
- : (string * int) list = [("int",1);("int",2);("int",3);("int",4)]
# mk_pairs "ST" ["TOS";"TNG";"DS9"] ;;
- : (string * string) list = [("ST","TOS");("ST","TNG");("ST","DS9")]
*)

(* 1c. Sometimes we wish to work with more than one list at a time. Given lists
       `l1` and `l2`, produce a list containing the pairwise elements in a tuple.
       You can assume the lists are of equal length.
*)

let pair_up (l1 : 'a list) (l2 : 'b list) : ('a * 'b) list = unimplemented ()
(*
# pair_up [1;2;3] ["a";"b";"c"] ;;
- : (int * string) list = [(1,"a"); (2,"b"); (3,"c")]
# pair_up ["Do";"Re";"Mi"] ["Deer";"Golden sun";"Name I call myself"]
- : (string * string) list = ([("Do","Deer");("Re","Golden sun");("Mi","Name I call myself")])
*)

(*
   1d. A cartesian product of two lists will return a list containing all the
       possible pairs of elements selected from the two lists. Write a function
       that will return the cartesian product when given two lists. If either
       of the lists is empty, return an empty list.
*)

let cartesian_product (l1 : 'a list) (l2 : 'b list) : ('a * 'b) list =
  unimplemented ()

(*
# cartesian_product [1;3;5] [2;6] ;;
- : int list = [(1,2);(1,6);(3,2);(3,6);(5,2);(5,6)]
*)

(* ************** Section Two: Hidato verifier ************** *)

(* Hidato, or Hidoku, is a logic puzzle game. The goal of the game is to fill a
   rectangular grid with consecutive numbers that connect horizontally,
   vertically, or diagonally. In this part of the assignment, you will write a
   function that when presented with a finished Hidato grid, returns whether
   it has been correctly solved.
   In case you're not familiar with the game, the rules and some examples can
   be found here:
   https://puzzlemadness.co.uk/hidoku/small/2023/1/23#rules


   An example of a correctly solved Hidato puzzle is shown below.

   22 20 19 25 26 27
   21 23 24 18 28 29
   02 01 12 13 17 30
   03 04 11 14 16 31
   07 05 09 10 15 32
   06 08 36 35 34 33

   For this particular puzzle, starting on 01 we can go left to 02, down to 03, right to 04,
   down to 05, down/left to 06, ... etc stepping all the way to the maximum 36, and so this is
   a correct solution.

   For simplicity's sake, we will implement a naive checking algorithm, which
   is essentially a grid reachability search from 1 to <max>. In other words, we
   want to make sure that there exists a continuous path in the given grid.

   The algorithm can be broken down into the following steps:
   1. Find a starting position, and mark it as current.
   2. Check whether the current position has a neighbor whose value is the next
      number we're looking for.
   3. If so, mark that neighbor's position as current, and repeat 2 from there.
   4. The algorithm only returns true if we can reach <max> from 1.

   A simple representation of an n x m Hidato grid is as a list of length n,
   where each of the n elements is itself a length-m list.

   e.g.: The above example grid is represented as the OCaml list

   [[22;20;19;25;26;27];
    [21;23;24;18;28;29];
    [02;01;12;13;17;30];
    [03;04;11;14;16;31];
    [07;05;09;10;15;32];
    [06;08;36;35;34;33]]

   The function itself will take in three arguments: number of rows (n), number
   of columns (m), and the Hidato grid in the above representation. You can
   assume that the grid provided will be of the correct dimension.
*)

(* 2a. To perform the verification, we often need to query a value by its
       coordinate. Write a function that will return a cell's value given
       its coordinate.
*)

let fetch_val (grid : int list list) (coord : int * int) : int =
  unimplemented ()

(*
# fetch_val [[1;2;3];[4;5;6];[7;8;9]] (0,0) ;;
- : int = 1
# fetch_val [[1;2;3];[4;5;6];[7;8;9]] (2,1) ;;
- : int = 8
*)

(* 2b. Since the search needs to examine the neighbors of a given cell, let's
       write a helper function that will fetch the coordinates of all neighbors
       of a given cell.
*)

let fetch_neighbor_coords (grid : int list list) (cell : int * int) :
    (int * int) list =
  unimplemented ()

(*
# let test_grid = 
	 [[22;20;19;25;26;27]; 
    [21;23;24;18;28;29];
    [02;01;12;13;17;30]; 
    [03;04;11;14;16;31];
    [07;05;09;10;15;32]; 
    [06;08;36;35;34;33]]
	;;
# fetch_neighbor_coords test_grid (0,0) ;;
- : int list = [(0,1);(1,0);(1,1)]
# fetch_neighbor_coords test_grid (2,2) ;;
- : int list = [(1,1);(1,2);(1,3);(2,1);(2,3);(3,1);(3,2);(3,3)]
*)

(* 2c. Write a function that, given a grid and a coordinate, returns the valid
       next position, i.e. the coordinate of the neighboring cell whose value is
       +1 of the current cell. We will use an option type for the return value
       since an invalid solution will have cells without a valid next position.
       e.g. next_pos_exists test_grid (0,0) = Some (1,1);;
*)

let get_next_pos (grid : int list list) (cell : int * int) : (int * int) option
    =
  unimplemented ()

(*
# get_next_pos test_grid (0,0);;
- : (int * int) option = Some (1,1)

# let test_grid_bad = 
	 [[22;20;19;25;26;27]; 
    [21;23;24;18;28;29];
    [02;01;12;13;17;30]; 
    [03;04;11;14;16;31];
    [07;05;09;10;15;32]; 
    [06;08;35;36;34;33]]
	;;
# get_next_pos test_grid_bad (5,4);;
- : (int * int) option = None
*)

(* 2d. Now we can put it all together and verify the entire grid! *)

let verify_solution n m grid = unimplemented ()

(*
# verify_solution 6 6 test_grid;;
- : bool = true
*)
