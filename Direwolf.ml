open Core.Std
open Helpers
open WorldObject
open WorldObjectI
open KingsLanding
open Movable

(* ### Part 2 Movement ### *)
let direwolf_inverse_speed = Some 2

(* ### Part 6 Custom Events ### *)
let max_killed_lan = 5

(** A White Walker will roam the world until it has destroyed a satisfactory
    number of towns *)
class direwolf p (k: KingsLanding.kings_landing) home : movable_t =
object (self)
  inherit movable p direwolf_inverse_speed

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 3 Actions ### *)
  
  val mutable lannisters_killed = 0
  
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
    if self#dangerous then
      match World.get self#get_pos with
      | [] -> ()
      | neighbors -> (List.iter neighbors 
          (fun x -> if (x#get_name = "lannister")
          then (x#die; lannisters_killed<-lannisters_killed+1)))
    else 
      if home#get_pos = self#get_pos then self#die else()
    
  (* ### TODO: Part 6 Custom Events ### *)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "direwolf"

  method! draw = Draw.circle self#get_pos World.obj_width World.obj_height 
          Graphics.black Graphics.white (string_of_int lannisters_killed)

  method! draw_z_axis = 4


  (* ### TODO: Part 3 Actions ### *)

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)

  method! next_direction = 
    if self#dangerous then
      (if (World.rand World.size = 0) || (World.rand World.size = 1) then
        Direction.natural self#get_pos k#get_pos
      else Some (Direction.random World.rand))
    else World.direction_from_to self#get_pos home#get_pos


  (* ### TODO: Part 6 Custom Events ### *)
  method private dangerous = (lannisters_killed < max_killed_lan)
end
