/obj/effect/temp/menacing
	name = "menacing"
	icon = 'icons/obj/effects/stand.dmi'
	icon_state = "menacing"

/obj/effect/temp/menacing/New(var/desired_location,var/desired_time,var/offset_x = 0,var/offset_y=0)

	. = ..()

	pixel_x = offset_x
	pixel_y = offset_y

	if(duration)
		animate(src, pixel_x = offset_x+(TILE_SIZE*2)+rand(-3,3), pixel_y=offset_y+(TILE_SIZE*2)+rand(-3,3), time=duration)
		spawn(duration-5)
			animate(src, alpha=0, time=5)

	