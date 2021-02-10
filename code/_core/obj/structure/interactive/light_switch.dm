/obj/structure/interactive/light_switch
	name = "light switch"
	desc = "Off. On. Off. On."
	desc_extended = "An incredibly complex space-age lightswitch that allows you to magically toggle the lights in the area. Has science gone too far?"

	icon = 'icons/obj/structure/light_switch.dmi'
	icon_state = "setup"

	anchored = TRUE
	initialize_type = INITIALIZE_LATE

	plane = PLANE_OBJ

	var/on = TRUE

	var/next_interact = 0

	dir_offset = TILE_SIZE - 8

/obj/structure/interactive/light_switch/off
	on = FALSE

/obj/structure/interactive/light_switch/Initialize()
	setup_dir_offsets()
	dir = SOUTH
	return ..()

/obj/structure/interactive/light_switch/Finalize()
	update_sprite()
	return ..()

/obj/structure/interactive/light_switch/update_atom_light()

	if(on)
		set_light(1,1,"#00FF00")
	else
		set_light(1,1,"#FF0000")

	return ..()

/obj/structure/interactive/light_switch/update_icon()

	if(on)
		flick("anim_on",src)
		icon_state = "on"
	else
		flick("anim_off",src)
		icon_state = "off"

	return ..()

/obj/structure/interactive/light_switch/proc/toggle(var/mob/caller)
	on = !on
	sync_lights()
	update_sprite()
	play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE*0.5)
	return TRUE

/obj/structure/interactive/light_switch/proc/sync_lights()

	var/area/A = get_area(src)

	for(var/obj/structure/interactive/lighting/L in A.contents)
		if(!L.lightswitch)
			continue
		if(L.on == on)
			continue
		L.on = on
		L.update_atom_light()
		L.update_sprite()

	for(var/obj/structure/interactive/light_switch/LS in A.contents)
		if(LS.on == on)
			continue
		LS.on = on
		LS.update_sprite()

	return TRUE

/obj/structure/interactive/light_switch/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(next_interact >= world.time)
		return TRUE

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	toggle(caller)

	next_interact = world.time + LIGHTING_INTERVAL + 1

	return TRUE
