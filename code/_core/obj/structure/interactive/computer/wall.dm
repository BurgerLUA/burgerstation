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

	return TRUE

obj/structure/interactive/computer/wall
	name = "wall computer"
	desc = "Compute walls!"
	desc_extended = "It has no program and refuses to work."

	icon_state = "computer_wall"
	var/computer_type = "generic"
	var/keyboard_type = "generic_key"

obj/structure/interactive/computer/wall/Initialize()
	setup_dir_offsets()
	dir = SOUTH
	return ..()

obj/structure/interactive/computer/wall/PostInitialize()
	. = ..()
	update_sprite()
	return .

obj/structure/interactive/computer/wall/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)

	if(computer_type && on)
		var/icon/I2 = new/icon(icon,computer_type)
		I.Blend(I2,ICON_OVERLAY)

	if(keyboard_type)
		var/icon/I3 = new/icon(icon,keyboard_type)
		I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()


obj/structure/interactive/computer/wall/dorms
	name = "dorms computer"
	desc = "Registration of dorms."
	desc_extended = "A computer intended to register dorms."

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"



