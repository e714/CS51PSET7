open Core.Std
open WorldObject
open WorldObjectI

let max_sensing_range = 5

(* Baratheons should travel in a random direction. *)
class northern_hunter p city : Human.human_t =
object (self)
  inherit world_object p as super
  inherit Human.human p city

  (******************************)
  (***** Instance Variables *****)
  (******************************)

  (* ### TODO: Part 5 Smart Humans *)
  val mutable facing : Direction.direction option = 
    Some (Direction.random World.rand)
  val sensing_range = max_sensing_range

  (* Initializer *)
  initializer
    self#register_handler World.action_event self#do_action;

  (********************************)
  (***** WorldObjectI Methods *****)
  (********************************)

  (* ### TODO: Part 5 Smart Humans *)
  method! get_name = "northern_hunter"

  method! draw_picture = self#draw_circle Graphics.green Graphics.white
    ""

  (***********************)
  (***** Human Methods *****)
  (***********************)
  method private available_square ((x,y) : int*int) 
    (dir : Direction.direction option) : bool =
    match dir with
    | None -> false
    | Some d ->
      let (deltax, deltay) = Direction.to_vector d in
      World.can_move (x+deltax, y+deltay)

  (* Method makes it attracted to direwolves in the sensing range *)
  method private magnet_gold : world_object_i option =
    let objectlist = (List.filter (World.objects_within_range 
      self#get_pos sensing_range)
      (fun x -> (x#get_name = "direwolf"))) in
      match objectlist with 
      | [] -> None 
      | x :: xs -> Some x

  method private do_action _ : unit = 
    let neighbors = World.get self#get_pos in
      List.iter neighbors (fun x -> self#is_wolf x) 

  method private is_wolf (x: world_object_i) : unit =
    if x#get_name = "direwolf" then
      (x#die;
       ignore(Printf.printf "hunter says: wolf eliminated. "; flush_all());
      self#die; ())
    else () (* laugh. *)

  (* ### TODO: Part 5 Smart Humans *)
  (*method! next_direction = 
    if self#available_square self#get_pos facing then
      facing
    else ((facing <- self#next_direction_default); facing)*)
  method! next_direction =
    match self#magnet_gold with
    | None -> self#next_direction_default
    | Some s -> World.direction_from_to self#get_pos s#get_pos

  method private next_direction_default : Direction.direction option = 
    if self#available_square self#get_pos facing then
      facing
    else
      let dir = Some (Direction.random World.rand) in
      if self#available_square self#get_pos dir then
        ((facing <- dir); dir)
      else self#next_direction_default

end


