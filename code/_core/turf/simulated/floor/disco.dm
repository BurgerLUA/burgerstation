var/global/image/disco_underlay

/turf/simulated/floor/disco
	name = "disco floor"
	desc = "Pretty colors!"
	desc_extended = "A disco floor for disco dancing. It's Friday night."

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "disco"

	real_icon = 'icons/turf/floor/disco.dmi'
	real_icon_state = "disco_light"

	footstep = /footstep/tile

	color = COLOR_GREY

	var/back_color = "#FFFFFF"

/turf/simulated/floor/disco/Initialize()
	. = ..()
	real_icon_state = "disco_light_[1 + ((x+y) % 4)]"
	pixel_x = -8
	pixel_y = -8
	name = real_icon_state
	alpha = 255

/turf/simulated/floor/disco/Finalize()
	. = ..()
	update_sprite()
	src.set_light(4,0.25,"#FFFFFF")

/turf/simulated/floor/disco/update_underlays()

	. = ..()

	if(!disco_underlay)
		disco_underlay = new/image(real_icon,"disco_frame")
		disco_underlay.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
		disco_underlay.plane = src.plane
		disco_underlay.layer = src.layer - 0.01
		disco_underlay.color = back_color

	add_underlay(disco_underlay)


/turf/simulated/floor/disco/hierophant
	color = COLOR_PURPLE
	back_color = COLOR_GREY_LIGHT