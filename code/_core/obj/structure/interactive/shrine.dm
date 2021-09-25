/obj/structure/interactive/ritual
	name = "ritual shrine"
	desc = "Pray at the shrine, if you dare."
	desc_extended = "An occult ritual shrine constructed to honor the gods of battle. Are you prave enough to pray at it?"
	icon = 'icons/obj/structure/shrine.dmi'
	icon_state = "icon"

	pixel_x = -16
	pixel_y = -8

	var/active = FALSE

	var/list/connected_smoke = list()

	density = TRUE

	var/ritual_size = 5

/obj/structure/interactive/ritual/proc/make_smoke()

	for(var/ix=-ritual_size,ix<=ritual_size,ix++)
		for(var/iy=-ritual_size,iy<=ritual_size,iy++)
			//Okay. Corners only, please.
			if( (ix==-ritual_size || ix==ritual_size) || (iy==-ritual_size || iy==ritual_size) ) //Outer corner.
				var/turf/T = locate(x+ix,y+iy,z)
				var/obj/effect/ritual_smoke/outer/RS = new(T)
				var/abs_x = abs(ix)
				var/abs_y = abs(iy)
				var/desired_dir = 0x0
				if(abs_x >= abs_y) //Left/Right
					if(ix > 0)
						desired_dir |= EAST
					else
						desired_dir |= WEST
				if(abs_x <= abs_y) //Up/down
					if(iy > 0)
						desired_dir |= NORTH
					else
						desired_dir |= SOUTH
				RS.dir = desired_dir
				RS.name = "[ix].[iy]: [dir2text(desired_dir)]"
				RS.color = "green"
				connected_smoke += RS

			else if( (ix==-(ritual_size-1) || ix==(ritual_size-1)) || (iy==-(ritual_size-1) || iy==(ritual_size-1)) ) //Inner corner
				var/turf/T = locate(x+ix,y+iy,z)
				var/obj/effect/ritual_smoke/inner/RS = new(T)
				var/abs_x = abs(ix)
				var/abs_y = abs(iy)
				var/desired_dir = 0x0
				if(abs_x >= abs_y) //Left/Right
					if(ix > 0)
						desired_dir |= WEST
					else
						desired_dir |= EAST
				if(abs_x <= abs_y) //Up/down
					if(iy > 0)
						desired_dir |= SOUTH
					else
						desired_dir |= NORTH
				RS.dir = desired_dir
				RS.name = "[ix].[iy]: [dir2text(desired_dir)]"
				RS.color = "red"
				connected_smoke += RS


/obj/structure/interactive/ritual/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_living(caller))
		return ..()

	var/mob/living/L = caller
	if(!L.client)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)


	if(!active)
		make_smoke()
		active = TRUE