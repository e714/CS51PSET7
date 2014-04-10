open Core.Std
open Helpers
open WorldObject
open WorldObjectI
open KingsLanding
open Movable

(* ### Part 3 Actions ### *)
let gold_theft_amount = 1000

(* ### Part 4 Aging ### *)
let dragon_starting_life = 20

(* ### Part 2 Movement ### *)
let dragon_inverse_speed = Some 10

class dragon p (k: KingsLanding.kings_landing): movable_t =
object (self)
  inherit world_object p
  inherit movable p dragon_inverse_speed

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)

  val mutable stolen_gold = 0 

  (* ### TODO: Part 6 Events ### *)

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 3 Actions ### *)

  initializer
    self#register_handler World.action_event self#do_action;

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 3 Actions ### *)

  method private do_action _ : unit =
     if self#get_pos = k#get_pos 
     then stolen_gold<-stolen_gold +
       (k#forfeit_treasury gold_theft_amount
        (self:>WorldObjectI.world_object_i))
     else ();   

  (* ### TODO: Part 6 Custom Events ### *)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "dragon"

  method! draw = Draw.circle self#get_pos World.obj_width World.obj_height 
           Graphics.red Graphics.black (string_of_int stolen_gold)

  method! draw_z_axis = 3


  (* ### TODO: Part 3 Actions ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method! next_direction = Direction.natural self#get_pos k#get_pos


  (* ### TODO: Part 6 Custom Events ### *)

end
