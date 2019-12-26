obj/structure/interactive/bed
	name = "bed"
	desc = "What does it do?"
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"
	var/secondary_color = "#FF0000"

	var/mob/living/occupant

	var/pixel_offset_x = 0
	var/pixel_offset_y = 0

	layer = LAYER_BELOW_MOB

obj/structure/interactive/bed/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(is_living(caller))

		if(caller == occupant)
			occupant.to_chat("You unbuckle yourself from \the [src.name].")
			occupant.sleep_time = 0
			occupant.check_status_effects()
			occupant.pixel_x = initial(occupant.pixel_x)
			occupant.pixel_y = initial(occupant.pixel_y)
			occupant = null
			return TRUE

		var/mob/living/L = caller
		if(L.loc == src.loc)
			occupant = L
			occupant.sleep_time = -1
			occupant.check_status_effects()
			occupant.pixel_x = pixel_offset_x
			occupant.pixel_y = pixel_offset_y
			occupant.to_chat("You buckle yourself to \the [src.name].")
			return TRUE


	return ..()

obj/structure/interactive/bed/Initialize()
	. = ..()
	update_icon()
	return .

obj/structure/interactive/bed/padded
	name = "padded bed"


obj/structure/interactive/bed/padded/update_icon()
	overlays.Cut()
	var/image/sheets = new(icon,"bed_padding")
	sheets.color = secondary_color
	overlays += sheets

/*

obj/structure/interactive/bed/padded/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new(icon,icon_state)
	var/icon/I2 = new(icon,"bed_padding")

	I.Blend(I2,ICON_OVERLAY)

	icon = I
*/

#define SLEEPER_OPENED "open"
#define SLEEPER_OPENING "opening"

#define SLEEPER_CLOSED "closed"
#define SLEEPER_CLOSING "closing"


obj/structure/interactive/bed/sleeper
	name = "sleeper"
	icon_state = "sleeper"
	icon = 'icons/obj/structure/sleeper.dmi'
	icon_state = "sleeper"

	var/door_state = SLEEPER_CLOSED

	var/base_color = "#FFFFFF"
	secondary_color = "#FFFFFF"

	var/open_sound
	var/close_sound

	var/open_time = 7
	var/close_time = 7

	pixel_offset_x = 11
	layer = LAYER_ABOVE_MOB
	plane = PLANE_MOB

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

obj/structure/interactive/bed/sleeper/Initialize()

	var/image/I = new/image(icon,icon_state)
	I.layer = LAYER_BELOW_MOB
	I.color = base_color
	underlays += I

	return ..()


obj/structure/interactive/bed/sleeper/clicked_on_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	if(door_state == SLEEPER_CLOSED)
		open()
		return TRUE
	else if(door_state == SLEEPER_OPENED)
		close()
		return ..()

	return TRUE

obj/structure/interactive/bed/sleeper/proc/open()
	if(open_sound)
		play(open_sound)
	door_state = SLEEPER_OPENING
	update_icon()
	spawn(open_time)
		door_state = SLEEPER_OPENED
		update_icon()

obj/structure/interactive/bed/sleeper/proc/close()
	if(close_sound)
		play(close_sound)
	door_state = SLEEPER_CLOSING
	update_icon()
	spawn(close_time)
		door_state = SLEEPER_CLOSED
		update_icon()

obj/structure/interactive/bed/sleeper/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	collision_flags = initial(collision_flags)
	collision_bullet_flags = initial(collision_flags)

	switch(door_state)
		if(SLEEPER_OPENED)
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
			set_light(FALSE)
		if(SLEEPER_CLOSED)
			set_light(2, 0.5, secondary_color)
		if(SLEEPER_OPENING)
			set_light(2, 0.25, secondary_color)
		if(SLEEPER_CLOSING)
			set_light(2, 0.25, secondary_color)

	var/icon/I = new/icon(icon,door_state)
	I.Blend(secondary_color,ICON_MULTIPLY)

	icon = I

obj/structure/interactive/bed/sleeper/cryo
	name = "hypersleep chamber"
	base_color = "#AAAAAA"
	secondary_color = "#00FF00"

obj/structure/interactive/bed/sleeper/medical
	name = "medical sleeper"
	base_color = "#FFFFFF"
	secondary_color = "#0094FF"

obj/structure/interactive/bed/sleeper/syndicate
	name = "syndicate sleeper"
	base_color = "#303030"
	secondary_color = "#7F0000"