open Core.Std
open Helpers
open WorldObject
open WorldObjectI

(* ### Part 6 Custom Events ### *)
let town_limit = 200

(** The Wall will spawn a white walker when there are enough towns
    in the world. *)
class wall p city: world_object_i =
object (self)
  inherit world_object p as old

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO Part 6 Custom Events ### *)

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO Part 6 Custom Events ### *)
  
  initializer
    self#register_handler World.action_event self#do_action;
    
  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO Part 6 Custom Events ### *)

  method private do_action () =
     if town_limit > (World.fold(fun obj i -> match obj#smells_like_gold with
       |Some x-> i+1
       |None -> i) 0) &&
         World.fold (fun obj b -> (obj#get_name <> "white_walker") && b) true 
     then ignore(Printf.printf "white walkers!";flush_all();
         new WhiteWalker.white_walker self#get_pos city);

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO Part 1 Basic ### *)

  method! get_name = "wall"

  method! draw = Draw.circle old#get_pos World.obj_width World.obj_height 
           (Graphics.rgb 70 100 130) Graphics.white "W"

  method! draw_z_axis = 1


end

