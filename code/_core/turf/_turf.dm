/turf/
	name = "TURF ERROR"
	icon = 'icons/debug/turfs.dmi'
	icon_state = ""
	layer = LAYER_FLOOR

	appearance_flags = TILE_BOUND | KEEP_TOGETHER
	mouse_over_pointer = MOUSE_INACTIVE_POINTER

	//Density
	density = 0
	var/density_north = FALSE
	var/density_south = FALSE
	var/density_east  = FALSE
	var/density_west  = FALSE
	var/density_up    = FALSE
	var/density_down  = FALSE

	var/allow_bullet_pass = FALSE

	plane = PLANE_TURF

/turf/New(loc)
	area = src.loc
	..()

/turf/change_victim(var/atom/attacker)
	for(var/v in contents)
		if(is_mob(v))
			return v
	return src

/turf/Entered(var/atom/enterer)
	area.Entered(enterer)

/turf/can_be_attacked(var/atom/attacker)
	return FALSE

/turf/Enter(var/atom/enterer,var/atom/oldloc)
	var/enter_direction = get_dir(oldloc,src)

	if((enter_direction & NORTH) && density_north)
		return FALSE

	if((enter_direction & EAST) && density_east)
		return FALSE

	if((enter_direction & SOUTH) && density_south)
		return FALSE

	if((enter_direction & WEST) && density_west)
		return FALSE

	return ..()