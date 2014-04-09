open Core.Std
open Event51
open Helpers
open WorldObject
open WorldObjectI

(** Class type for objects which constantly try to move in a calculated next
    direction. *)
class type movable_t =
object
  inherit world_object_i

  (** The next direction for which this object should move. *)
  method next_direction : Direction.direction option
end

class movable p (inv_speed:int option) : movable_t =
object (self)
  inherit world_object p

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 2 Movement ### *)
  val mutable steps_remaining : int option = inv_speed
  
  initializer
    self#register_handler World.move_event self#do_move;

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 2 Movement ### *)
  method private do_move _ : unit =
    match steps_remaining with
    | None -> ()
    | Some s ->
      if s = 0 
        then 
          let _ = self#move self#next_direction in
          steps_remaining <- inv_speed
        else steps_remaining <- Some (s-1)

  (***************************)
  (***** Movable Methods *****)
  (***************************)

  (* ### TODO: Part 2 Movement ### *)
  method next_direction = Some North

end
