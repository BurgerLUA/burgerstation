/atom/movable/proc/setup_dir_offsets()
	var/x_offset = 0
	var/y_offset = 0

	if(dir & NORTH)
		pixel_y -= 32
		light_offset_y -= 16
		y_offset++

	if(dir & SOUTH)
		pixel_y += 32
		light_offset_y += 16
		y_offset--

	if(dir & EAST)
		pixel_x -= 32
		light_offset_x -= 16
		x_offset++

	if(dir & WEST)
		pixel_x += 32
		light_offset_x += 16
		x_offset--

	loc = locate(x+x_offset,y+y_offset,z) //Legitimately don't know why force_move or get_step doesn't work here. Even in initialize.

obj/structure/interactive/computer/wall
	name = "wall computer"
	desc = "Compute walls!"
	desc_extended = "It has no program and refuses to work."

	icon = 'icons/obj/structure/computer_wall.dmi'
	//icon_state = "dorm_available"

obj/structure/interactive/computer/wall/Initialize(var/desired_loc)
	setup_dir_offsets()
	return ..(loc) //thanks, i hate it

obj/structure/interactive/computer/wall/dorms
	name = "dorms computer"
	desc = "Registration of dorms."
	desc_extended = "A computer intended to register dorms."

	icon_state = "dorm_available"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"