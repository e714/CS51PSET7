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

class dragon p (k: KingsLanding.kings_landing) (home: int*int) : movable_t =
object (self)
  inherit world_object p
  inherit movable p dragon_inverse_speed

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)

  val mutable stolen_gold = 0 

  (* ### TODO: Part 6 Events ### *)
  val mutable life : int = dragon_starting_life

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
     let neighbors = World.get self#get_pos in
     if self#is_dany neighbors then
      (stolen_gold <- 0; ())
    else
      if k#get_gold < gold_theft_amount/2 then
        self#die else

     if self#get_pos = k#get_pos 
     then stolen_gold<-stolen_gold +
       (k#forfeit_treasury gold_theft_amount
        (self:>WorldObjectI.world_object_i))
     else ();   

  (* ### TODO: Part 6 Custom Events ### *)
  method private is_dany (hmm : world_object_i list) : bool =
    match hmm with
    | [] -> false
    | x :: xs -> if x#get_name = "dany" then true else self#is_dany xs

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
  method! receive_damage : unit =
    life <- life-1;
    if life <= 0 then
      (self#die; ())
    else ();

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method! next_direction = if stolen_gold = 0 then
    World.direction_from_to self#get_pos k#get_pos
    else World.direction_from_to self#get_pos home


  (* ### TODO: Part 6 Custom Events ### *)

end
