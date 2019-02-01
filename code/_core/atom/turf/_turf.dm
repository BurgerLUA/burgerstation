/turf/
	name = "TURF ERROR"
	icon = 'icons/debug/turfs.dmi'
	icon_state = ""
	layer = LAYER_FLOOR

	//Density
	var/density_north = FALSE
	var/density_south = FALSE
	var/density_east  = FALSE
	var/density_west  = FALSE
	var/density_up    = FALSE
	var/density_down  = FALSE

	mouse_over_pointer = MOUSE_INACTIVE_POINTER


	var/allow_bullet_pass = FALSE

/turf/New()
	area = src.loc

/turf/change_victim(var/atom/attacker)
	for(var/v in contents)
		if(is_mob(v))
			return v
	return src

/turf/on_enter(var/atom/enterer)
	area.on_enter(enterer)
	for(var/atom/A in contents)
		if(is_trigger(A))
			var/obj/trigger/T = A
			T.on_trigger(enterer)


/turf/can_be_attacked(var/atom/attacker)
	return FALSE