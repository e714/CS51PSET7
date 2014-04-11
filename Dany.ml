open Core.Std
open Event51
open WorldObject
open WorldObjectI

(* ### Part 6 Custom Events ### *)
let spawn_dragon_gold = 500

(** Dany will spawn a dragon when King's Lnading has collected a certain
    amount of gold. *)
class dany p (kings : KingsLanding.kings_landing): world_object_i =
object (self)
  inherit world_object p as old

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 6 Custom Events ### *)
  val mutable if_dragon : bool = false

  (***********************)
  (***** Initializer *****)
  (***********************)

  (* ### TODO: Part 6 Custom Events ### *)
  initializer
    self#register_handler kings#get_gold_event self#spawn_dragon;

  (**************************)
  (***** Event Handlers *****)
  (**************************)

  (* ### TODO: Part 6 Custom Events ### *)
  method private spawn_dragon _ : unit =
    if (kings#get_gold >= spawn_dragon_gold) && if_dragon = false
      then
        if_dragon <- true; 
        ignore(World.add self#get_pos ((new Dragon.dragon self#get_pos kings self#get_pos) :> world_object_i));
        print_string "DRAGONS! D: ";
        flush_all();
        ()

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 1 Basic ### *)

  method! get_name = "dany"

  method! draw = Draw.circle old#get_pos World.obj_width World.obj_height 
           Graphics.black (Graphics.rgb 0x80 0x00 0x80) "D"

  method! draw_z_axis = 1


  (* ### TODO: Part 6 Custom Events *)

end