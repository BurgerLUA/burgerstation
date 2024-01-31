/obj/effect/temp/menacing
	name = "menacing"
	icon = 'icons/obj/effects/stand.dmi'
	icon_state = "menacing"

/obj/effect/temp/menacing/New(desired_location,desired_time,offset_x = 0,offset_y=0)

	. = ..()

	pixel_x = offset_x
	pixel_y = offset_y

	if(duration)
		animate(src, pixel_x = offset_x+(TILE_SIZE*2)+rand(-3,3), pixel_y=offset_y+(TILE_SIZE*2)+rand(-3,3), time=duration)
		spawn(duration-5)
			animate(src, alpha=0, time=5)

	