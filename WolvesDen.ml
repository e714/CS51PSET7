open Core.Std
open Helpers
open WorldObject
open WorldObjectI

(* ### Part 6 Custom Events ### *)
let lan_limit = 8

(** The Wall will spawn a white walker when there are enough towns
    in the world. *)
class wolves_den p city: world_object_i =
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
     let tcount = World.fold (fun obj sum -> if obj#get_name = "lannister" 
       then sum + 1 else sum) 0 in
     if lan_limit < tcount && (World.fold 
       (fun obj b -> obj#get_name <> "direwolf" && b) true) 
     then(
       ignore(Printf.printf "WOLVES! D: ";flush_all());
       ignore(new Direwolf.direwolf self#get_pos city self))
     

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO Part 1 Basic ### *)

  method! get_name = "den"

  method! draw = Draw.circle old#get_pos World.obj_width World.obj_height 
           Graphics.black Graphics.magenta "H"

  method! draw_z_axis = 1


end

