/turf/simulated/floor/catwalk
	name = "grate"
	icon = 'icons/turf/floor/catwalk.dmi'
	icon_state = "floor"

	plane = PLANE_FLOOR_BELOW
	layer = LAYER_FLOOR

	health_base = 500

	footstep = /footstep/catwalk

	destruction_turf = /turf/simulated/openspace

	corner_icons = TRUE
	corner_category = "catwalk"

	color = COLOR_GREY

/turf/simulated/floor/catwalk/Finalize()
	. = ..()
	var/turf/T = locate(x,y,z-1)
	if(T) vis_contents += T

/turf/simulated/floor/catwalk/update_sprite()
	. = ..()
	icon = null
	icon_state = null

/turf/simulated/floor/catwalk/update_icon()
	icon = initial(icon)
	icon_state = initial(icon_state)
	. = ..()

/turf/simulated/floor/catwalk/update_overlays()
	. = ..()
	var/image/I = new/image(icon,icon_state)
	I.appearance_flags = src.appearance_flags | KEEP_APART | RESET_COLOR
	I.layer = LAYER_FLOOR
	I.plane = PLANE_FLOOR
	add_overlay(I)

/turf/simulated/floor/catwalk/pre_change()
	. = ..()
	vis_contents.Cut()