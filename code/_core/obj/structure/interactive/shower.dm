obj/structure/interactive/shower
	name = "shower"
	desc = "For when you don't feel like taking a b‰‰‰th."
	desc_extended = "A shower fixture as decor to liven up the area."

	icon = 'icons/obj/structure/shower.dmi'
	icon_state = "shower"

	var/showers_left = 0

	reagents = /reagent_container/shower

obj/structure/interactive/shower/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	set_active(showers_left <= 0)

	return TRUE

obj/structure/interactive/shower/Initialize()
	. = ..()
	set_dir(dir,TRUE)

obj/structure/interactive/shower/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(.)
		pixel_x = 0
		if(dir == SOUTH)
			pixel_y = 16
		else
			pixel_y = 0

obj/structure/interactive/shower/Destroy()
	CALLBACK_REMOVE("\ref[src]_shower")
	. = ..()

/obj/structure/interactive/shower/proc/set_active(var/desired_active=TRUE)

	if(desired_active)
		showers_left = 40
		shower()
		update_sprite()
	else
		showers_left = 0

	return TRUE


/obj/structure/interactive/shower/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(showers_left > 0)
		icon_state = "[icon_state]_on"

/obj/structure/interactive/shower/proc/shower()

	var/turf/T = get_turf(src)
	if(!T || src.qdeleting)
		showers_left = 0

	if(showers_left > 0)

		showers_left -= 1

		reagents.add_reagent(/reagent/nutrition/water,50)

		for(var/k in T.contents)
			if(reagents.volume_current <= 10)
				break
			var/atom/movable/M = k
			if(M.reagents)
				var/size_mod = M.reagents.volume_max * 0.025 //A person would be 1000, so this num would be 25
				reagents.splash(null,M,5 + FLOOR(size_mod,1),silent=TRUE)

		if(reagents.volume_current > 0)
			reagents.splash(null,T,reagents.volume_current,silent=TRUE)

		play_sound(pick('sound/effects/shower/shower_mid1.ogg','sound/effects/shower/shower_mid2.ogg','sound/effects/shower/shower_mid3.ogg'),T)

		CALLBACK("\ref[src]_shower",SECONDS_TO_DECISECONDS(1.5),src,.proc/shower)
	else
		update_sprite()


	return TRUE