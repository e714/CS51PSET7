open Core.Std
open Event51
open Helpers
open WorldObject
open WorldObjectI
open Movable

(* ### Part 2 Movement ### *)
let human_inverse_speed = Some 1

(* ### Part 3 Actions ### *)
let max_gold_types = 5

(* ### Part 4 Aging ### *)
let human_lifetime = 1000

(* ### Part 5 Smart Humans ### *)
let max_sensing_range = 5

(** Humans travel the world searching for towns to trade for gold.
    They are able to sense towns within close range, and they will return
    to King's Landing once they have traded with enough towns. *)
class human p : movable_t =
object(self)
  inherit world_object p
  inherit movable p human_inverse_speed

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
  val mutable gold_object : int list = []

  (* ### TODO: Part 5 Smart Humans ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 3 Actions ### *)

  initializer
    self#register_handler World.action_event self#do_action;

  (* ### TODO: Part 6 Custom Events ### *)

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 6 Custom Events ### *)

  (**************************)
  (***** Helper Methods *****)
  (**************************)

  (* ### TODO: Part 3 Actions ### *)
  method private deposit_gold (obj: world_object_i) : int list =
    obj#receive_gold gold_object

  method private extract_gold (obj: world_object_i) : int option =
    obj#forfeit_gold ()

  method private do_action _ : unit =
    let neighbors = World.get self#get_pos in
    let rec forloop (neighbors : world_object_i list) (numob: int) : int =
    match neighbors with
    | [] -> numob
    | obj :: remain -> 
      gold_object <- self#deposit_gold obj ;
      match self#extract_gold obj with
      | None -> forloop remain numob
      | Some s -> gold_object <- s :: gold_object;
                  forloop remain (numob+1) 
    in 
    let numob = forloop neighbors 0 in
    self#draw_circle (Graphics.rgb 0xC9 0xC0 0xBB) 
                                   Graphics.black (string_of_int numob);


  (* ### TODO: Part 5 Smart Humans ### *)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "human"

  method! draw = self#draw_circle (Graphics.rgb 0xC9 0xC0 0xBB) Graphics.black ""

  method! draw_z_axis = 2


  (* ### TODO: Part 3 Actions ### *)

  (***************************)
  (***** Ageable Methods *****)
  (***************************)

  (* ### TODO: Part 4 Aging ### *)

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)


  method! next_direction = Some (Direction.random World.rand)


  (* ### TODO: Part 5 Smart Humans ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (**** Human Methods ****)
  (***********************)

  (* ### TODO: Part 5 Smart Humans ### *)

end
