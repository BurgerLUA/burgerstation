/obj/structure/interactive/light_switch
	name = "light switch"
	desc = "Off. On. Off. On."
	desc_extended = "An incredibly complex space-age lightswitch that allows you to magically toggle the lights in the area. Has science gone too far?"

	icon = 'icons/obj/structure/light_switch.dmi'
	icon_state = "setup"

	anchored = TRUE
	initialize_type = INITIALIZE_LATE

	plane = PLANE_MOVABLE

	var/on = FALSE

	var/next_interact = 0

	dir_offset = TILE_SIZE - 8

/obj/structure/interactive/light_switch/PreDestroy()
	if(loc && is_turf(loc))
		var/area/A = loc.loc
		if(A.requires_power)
			A.light_switches -= src
	. = ..()

/obj/structure/interactive/light_switch/Initialize()
	. = ..()
	setup_dir_offsets()
	dir = SOUTH

/obj/structure/interactive/light_switch/Finalize()
	. = ..()
	if(is_turf(src.loc))
		var/area/A = src.loc.loc
		if(A.requires_power)
			A.light_switches += src
		else
			log_error("ERROR: Created [src.get_debug_name()] in an [A.type] that doesn't require power. Deleting!")
			qdel(src)
	update_sprite()
	update_atom_light()

/obj/structure/interactive/light_switch/post_move(var/atom/old_loc)
	. = ..()
	if(is_turf(old_loc))
		var/area/A = old_loc.loc
		if(A.requires_power)
			A.light_switches -= src
	if(is_turf(src.loc))
		var/area/A = src.loc.loc
		if(A.requires_power)
			A.light_switches += src

/obj/structure/interactive/light_switch/update_atom_light()

	if(on)
		set_light(1,1,"#00FF00")
	else
		set_light(1,1,"#FF0000")

	. = ..()

/obj/structure/interactive/light_switch/update_sprite()
	. = ..()
	plane = PLANE_LIGHTING_EFFECT

/obj/structure/interactive/light_switch/update_icon()
	. = ..()
	if(on)
		flick("anim_on",src)
		icon_state = "on"
	else
		flick("anim_off",src)
		icon_state = "off"

/obj/structure/interactive/light_switch/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"base")
	I.appearance_flags = src.appearance_flags
	I.plane = initial(plane)
	add_underlay(I)

/obj/structure/interactive/light_switch/proc/toggle(var/mob/caller)
	var/area/A = get_area(src)
	if(!A || !A.linked_apc || !A.linked_apc.cell || !A.linked_apc.cell.charge_current)
		caller.to_chat(span("warning","This doesn't seem to be working..."))
		return FALSE
	play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE*0.5)

	if(A.enable_power_lights & ON)
		A.toggle_power_lights(OFF)
	else
		A.toggle_power_lights(ON | AUTO)

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