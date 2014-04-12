open Core.Std
open WorldObject
open WorldObjectI

(* Baratheons should travel in a random direction. *)
class lannister p city : Human.human_t =
object (self)
  inherit world_object p as super
  inherit Human.human p city

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 5 Smart Humans *)
  val mutable facing : Direction.direction option = Some (Direction.random World.rand)

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 5 Smart Humans *)
  method! get_name = "lannister"

  method! draw_picture = self#draw_circle Graphics.yellow Graphics.black (string_of_int (List.length self#get_gold))

  (***********************)
  (***** Human Methods *****)
  (***********************)
  method private available_square ((x,y) : int*int) (dir : Direction.direction option) : bool =
    match dir with
    | None -> false
    | Some d ->
      let (deltax, deltay) = Direction.to_vector d in
      World.can_move (x+deltax, y+deltay)

  (* ### TODO: Part 5 Smart Humans *)
  (*method! next_direction = 
    if self#available_square self#get_pos facing then
      facing
    else ((facing <- self#next_direction_default); facing)*)

  method private next_direction_default : Direction.direction option = 
    if self#available_square self#get_pos facing then
      facing
    else
      let dir = Some (Direction.random World.rand) in
      if self#available_square self#get_pos dir then
        ((facing <- dir); dir)
      else self#next_direction_default

end


