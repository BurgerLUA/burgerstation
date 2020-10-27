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

/obj/structure/interactive/light_switch/off
	on = FALSE



/obj/structure/interactive/light_switch/Initialize()

	setup_dir_offsets()
	dir = SOUTH

	if(on)
		set_on(null)
	else
		set_off(null)

	return ..()

/obj/structure/interactive/light_switch/proc/toggle(var/mob/caller)

	on = !on

	if(on)
		set_on(caller)
	else
		set_off(caller)

	return TRUE

/obj/structure/interactive/light_switch/proc/sync_lights()
	var/area/A = get_area(src)
	for(var/obj/structure/interactive/lighting/L in A.contents)
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

/obj/structure/interactive/light_switch/proc/set_on(var/mob/caller)
	icon_state = "on"
	flick("anim_on",src)
	sync_lights()
	play('sound/machines/click.ogg',get_turf(src))
	return TRUE

/obj/structure/interactive/light_switch/proc/set_off(var/mob/caller)
	icon_state = "off"
	flick("anim_off",src)
	sync_lights()
	play('sound/machines/click.ogg',get_turf(src))
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.sanity -= 2
	return TRUE

/obj/structure/interactive/light_switch/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(next_interact >= world.time)
		return TRUE

	toggle(caller)

	next_interact = world.time + LIGHTING_INTERVAL + 1

	return TRUE
