obj/effect/temp/arrow
	name = "arrow"
	icon = 'icons/obj/effects/point.dmi'
	icon_state = "arrow"
	duration = 20
	pixel_z = TILE_SIZE

obj/effect/temp/arrow/Finalize()
	. = ..()
	animate(src,pixel_z = 0, time=SECONDS_TO_DECISECONDS(1),easing=BOUNCE_EASING)
