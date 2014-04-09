open Core.Std
open WorldObject
open WorldObjectI

(** Ponds serve as obstruction for other world objects. *)
class pond p : world_object_i =
object (self)
  inherit world_object p as old

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)
  method! get_name = "pond"

  method! draw = Draw.circle old#get_pos World.obj_width World.obj_height 
  				 Graphics.blue Graphics.black ""

  method! draw_z_axis = 1

  method! is_obstacle = true
end
