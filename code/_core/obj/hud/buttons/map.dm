/obj/hud/button/map
	name = "map"
	screen_loc = "CENTER:-255,CENTER:-255"
	layer = LAYER_HUD
	plane = PLANE_HUD

	user_colors = FALSE

	mouse_opacity = 2

/obj/hud/button/map/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()
	update_owner(null)

/obj/hud/button/map/update_icon()
	. = ..()
	if(owner)
		var/turf/T = get_turf(owner)
		if(T && SSmap.z_icons[T.z])
			icon = SSmap.z_icons[T.z]
		else
			log_error("Tried opening map, didn't work...")