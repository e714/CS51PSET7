open Core.Std
open Helpers
open WorldObject
open WorldObjectI

(* ### Part 3 Actions ### *)
let next_gold_id = ref 0
let get_next_gold_id () =
  let p = !next_gold_id in incr next_gold_id ; p

(* ### Part 3 Actions ### *)
let max_gold = 5
let produce_gold_probability = 50
let expand_probability = 4000
let forfeit_gold_probability = 3

(* ### Part 4 Aging ### *)
let town_lifetime = 2000

(** Towns produce gold.  They will also eventually die if they are not cross
    pollenated. *)
class town p (gold_id: int): world_object_i =
object (self)
  inherit world_object p as old

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
  val mutable gold_amount : int = World.rand max_gold

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
    if World.rand produce_gold_probability = 1 
       && gold_amount != max_gold then gold_amount <- gold_amount + 1
       self#smells_like_gold = Some gold_id
    else ();

    if World.rand expand_probability = 1 then 
      World.spawn 1 self#get_pos Main.gen_towns gold_id
    else ();

    self#draw_circle (Graphics.rgb 0x96 0x4B 0x00) Graphics.black (string_of_int gold_amount)

  method private forfeit_gold unit : int option =
    if World.rand forfeit_gold_probability = 1
       && gold_amount != 0 then
          gold_amount <- gold_amount - 1;
          Some gold_id
    else None



  
  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "town"

  method! draw = self#draw_circle (Graphics.rgb 0x96 0x4B 0x00) Graphics.black ""

  method! draw_z_axis = 1


  (* ### TODO: Part 4 Aging ### *)

  (* ### TODO: Part 3 Actions ### *)

  (* ### TODO: Part 4 Aging ### *)

end
