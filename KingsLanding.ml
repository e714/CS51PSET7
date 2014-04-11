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

class kings_landing p :
object
  inherit world_object_i
  method forfeit_treasury : int -> world_object_i -> int
  method get_gold_event : int Event51.event
  method get_gold : int
end =
object (self)
  inherit world_object p

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)

  val mutable gold_amount : int = starting_gold

  (* ### TODO: Part 6 Custom Events ### *)
  val gold_event : int Event51.event = (Event51.new_event())

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
    (if World.rand gold_probability = 1 
    then gold_amount <- gold_amount + 1
    else ();


  (* ### TODO: Part 4 Aging ### *)
  
    if gold_amount >= cost_of_human && World.rand spawn_probability = 1 
    then (gold_amount <- (gold_amount - cost_of_human); self#generate_human)
    else())
  

  (**************************)
  (***** Helper Methods *****)
  (**************************)

  (* ### TODO: Part 4 Aging ### *)

  method private generate_human =
    match World.rand 2 with
    | 0 -> World.add self#get_pos ((new Baratheon.baratheon self#get_pos (self :> world_object_i)) :> world_object_i);
    | _ -> World.add self#get_pos ((new Lannister.lannister self#get_pos (self :> world_object_i)) :> world_object_i);

  (****************************)
  (*** WorldObjectI Methods ***)
  (****************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "kings_landing"

  method! draw = Draw.circle self#get_pos World.obj_width World.obj_height 
           (Graphics.rgb 0xFF 0xD7 0x00) Graphics.black (string_of_int gold_amount)

  method! draw_z_axis = 1

  (* ### TODO: Part 3 Actions ### *)

  method receive_gold (lst : int list) : int list =
    Event51.fire_event self#get_gold_event self#get_gold;
    gold_amount<-gold_amount+(min max_gold_deposit (List.length lst));[]

  (* ### TODO: Part 6 Custom Events ### *)
  method get_gold_event : int Event51.event = gold_event

  method get_gold : int = gold_amount

  (**********************************)
  (***** King's Landing Methods *****)
  (**********************************)

  (* ### TODO: Part 3 Actions ### *)

  method forfeit_treasury (steal_amount : int) (thief : world_object_i) : int = 
    let amount_stolen = if gold_amount - steal_amount >= 0 then steal_amount else gold_amount in 
      (gold_amount <- (gold_amount - amount_stolen); self#danger thief; amount_stolen)


  (* ### TODO: Part 6 Custom Events ### *)

end
