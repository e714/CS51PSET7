open Core.Std
open Event51
open Helpers
open WorldObject
open WorldObjectI

(* ### Part 3 Actions ### *)
let starting_gold = 500
let cost_of_human = 10
let spawn_probability = 20
let gold_probability = 50
let max_gold_deposit = 3

(** King's Landing will spawn humans and serve as a deposit point for the gold
    that humans gather. It is possible to steal gold from King's Landing;
    however the city will signal that it is in danger and its loyal humans
    will become angry. *)
class kings_landing p : world_object_i =
object (self)
  inherit world_object p as old

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 3 Actions ### *)

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 3 Actions ### *)

  (* ### TODO: Part 4 Aging ### *)

  (**************************)
  (***** Helper Methods *****)
  (**************************)

  (* ### TODO: Part 4 Aging ### *)

  (****************************)
  (*** WorldObjectI Methods ***)
  (****************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "kings_landing"

  method! draw = Draw.circle old#get_pos World.obj_width World.obj_height 
           (Graphics.rgb 0xFF 0xD7 0x00) Graphics.black ""

  method! draw_z_axis = 1

  (* ### TODO: Part 3 Actions ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (**********************************)
  (***** King's Landing Methods *****)
  (**********************************)

  (* ### TODO: Part 3 Actions ### *)

  (* ### TODO: Part 6 Custom Events ### *)

end
