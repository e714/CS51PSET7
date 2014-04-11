open Core.Std
open Event51
open Helpers
open WorldObject
open WorldObjectI
open Movable
open Ageable
open CarbonBased

(* ### Part 2 Movement ### *)
let human_inverse_speed = Some 1

(* ### Part 3 Actions ### *)
let max_gold_types = 5

(* ### Part 4 Aging ### *)
let human_lifetime = 1000

(* ### Part 5 Smart Humans ### *)
let max_sensing_range = 5

class type human_t =
object
  inherit ageable_t

  method private get_gold : int list
  method private next_direction_default : Direction.direction option
end

(** Humans travel the world searching for towns to trade for gold.
    They are able to sense towns within close range, and they will return
    to King's Landing once they have traded with enough towns. *)
class human p (home : world_object_i) : human_t =
object(self)
  inherit world_object p
  inherit movable p human_inverse_speed
  inherit ageable p human_inverse_speed (World.rand human_lifetime) human_lifetime
  inherit carbon_based p human_inverse_speed (World.rand human_lifetime) human_lifetime

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
  val mutable gold_object : int list = []

  (* ### TODO: Part 5 Smart Humans ### *)
  val sensing_range = World.rand max_sensing_range
  val gold_types = World.rand max_gold_types + 1

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
  method private deposit_gold (obj: world_object_i) : unit =
    gold_object <- (obj#receive_gold gold_object)

  method private extract_gold (obj: world_object_i) : unit =
    match obj#forfeit_gold with
    | None -> ()
    | Some x -> (gold_object <- x::gold_object)

  method private do_action _ : unit =
    let neighbors = World.get self#get_pos in
      List.iter neighbors (fun x -> self#deposit_gold x;
        self#extract_gold x) 

  (* ### TODO: Part 5 Smart Humans ### *)
  method private get_gold : int list = gold_object;

   method private magnet_gold :world_object_i option =
    let townlist = (List.filter (World.objects_within_range self#get_pos sensing_range)
      (fun x -> match x#smells_like_gold with
      |Some y -> not(List.mem gold_object y)
      |None -> false)) in
    let comp_dist x = Direction.distance self#get_pos x#get_pos in
    let rec min_dist (min: float) (closest: world_object_i) (tlst: world_object_i list) : world_object_i = 
      match tlst with 
      | [] -> closest
      | hd::tl -> if ((comp_dist hd) < min) 
	              then min_dist (comp_dist hd) hd tl  
	              else min_dist min closest tl in
    match townlist with 
    | [] -> None 
    | _ -> Some (min_dist Float.max_value (match List.hd townlist with
      | Some x -> x) townlist)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "human"

  (* method! draw = self#draw_circle (Graphics.rgb 0xC9 0xC0 0xBB) Graphics.black (string_of_int (List.length gold_object))*)

  method! draw_z_axis = 2


  (* ### TODO: Part 3 Actions ### *)

  (***************************)
  (***** Ageable Methods *****)
  (***************************)

  (* ### TODO: Part 4 Aging ### *)
  
  method! draw_picture = self#draw_circle (Graphics.rgb 0xC9 0xC0 0xBB) Graphics.black (string_of_int (List.length gold_object))
  
  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)



  (* Want this back later*)
  (* SO TIRED. *)
  method! next_direction =
    if gold_types < List.length gold_object then
      World.direction_from_to self#get_pos home#get_pos
    else match self#magnet_gold with
    | None -> self#next_direction_default
    | Some s -> World.direction_from_to self#get_pos s#get_pos

  (* I don't think we need this anymore *)
  method private next_direction_default = None


  (* ### TODO: Part 5 Smart Humans ### *)

  (* ### TODO: Part 6 Custom Events ### *)

  (***********************)
  (**** Human Methods ****)
  (***********************)

  (* ### TODO: Part 5 Smart Humans ### *)
  (* method private next_direction_default = None *)

end
