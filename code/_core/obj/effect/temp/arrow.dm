obj/effect/temp/arrow
	name = "arrow"
	icon = 'icons/obj/effects/point.dmi'
	icon_state = "arrow"
	duration = 20
	pixel_z = -TILE_SIZE

	var/desired_pixel_x = 0
	var/desired_pixel_y = 0

obj/effect/temp/arrow/Finalize()
	. = ..()
	animate(src,pixel_z = 0, time=SECONDS_TO_DECISECONDS(1),easing=BOUNCE_EASING,flags=ANIMATION_PARALLEL)
	animate(src,pixel_x=desired_pixel_x,pixel_y=desired_pixel_y,time=SECONDS_TO_DECISECONDS(0.3),flags=ANIMATION_PARALLEL)
