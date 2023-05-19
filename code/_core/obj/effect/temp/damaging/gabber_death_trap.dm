/obj/effect/temp/gabber_death_trap

	name = "death trap"
	icon = 'icons/obj/effects/gabber_death_trap.dmi'
	icon_state = "active"
	duration = SECONDS_TO_DECISECONDS(30)

	hazardous = TRUE

	density = TRUE

	var/active = FALSE
	var/triggered = FALSE

	alpha = 100

	var/mob/living/advanced/owner
	var/loyalty_tag

	plane = PLANE_WALL_ATTACHMENT
	layer = -1000

/obj/effect/temp/gabber_death_trap/proc/place()
	var/turf/T = get_turf(owner)
	var/offset_x = T.x - src.x
	var/offset_y = T.y - src.y
	pixel_x = offset_x*TILE_SIZE
	pixel_y = offset_y*TILE_SIZE
	pixel_z = TILE_SIZE*2
	animate(src,pixel_x = pixel_x*0.5, pixel_y = pixel_y*0.5,pixel_z=pixel_z*1.5,time=15,easing=SINE_EASING|EASE_OUT)
	animate(pixel_x=0,pixel_y=0,pixel_z=0,time=10,easing=SINE_EASING|EASE_IN)
	CALLBACK("\ref[src]_arm",30,src,src::arm())

/obj/effect/temp/gabber_death_trap/proc/arm()
	animate(src,alpha=200,time=30)
	CALLBACK("\ref[src]_end",30,src,src::finish_arming())

/obj/effect/temp/gabber_death_trap/proc/finish_arming()
	active = TRUE
	animate(src,alpha=255,time=5)
	animate(alpha=200,time=5)

/obj/effect/temp/gabber_death_trap/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()
	if(active && !triggered && !src.qdeleting)
		CALLBACK("remove_effect_\ref[src]",SECONDS_TO_DECISECONDS(5),src,/obj/effect/temp/proc/remove_effect)
		triggered = TRUE
		icon_state = "triggered"
		animate(src,alpha=100,time=10)
		var/turf/T = get_turf(src)
		explode(T,2,owner,src,loyalty_tag)
		emp(T,2,owner,src,loyalty_tag)