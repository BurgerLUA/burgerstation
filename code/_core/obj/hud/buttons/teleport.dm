/obj/hud/button/teleport/
	alpha = 0
	mouse_opacity = 0
	flags = FLAGS_HUD_TELEPORT | FLAGS_HUD_SPECIAL

	essential = TRUE

/obj/hud/button/teleport/teleport_here

	name = "wishgranter teleport"
	desc = "Click here to whisk away."

	screen_loc = "CENTER-0.5,CENTER-0.5+3"

	icon = 'icons/hud/travel_icons.dmi'
	icon_state = "village"
	var/map_number = 1

	user_colors = FALSE


/obj/hud/button/teleport/teleport_here/update_icon()

	icon = initial(icon)

	var/icon/I = new/icon(icon,"base")
	swap_colors(I)
	var/icon/I2 = new/icon(icon,icon_state)

	I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()

/obj/hud/button/teleport/teleport_here/update_owner(var/mob/desired_owner)

	. = ..()

	if(. && is_advanced(owner))

		var/mob/living/advanced/A = owner

		if(A.known_wishgranters && length(A.known_wishgranters))
			var/list/known_locations = A.known_wishgranters - "main"
			icon_state = known_locations[map_number]
			update_icon()
			name = known_locations[map_number]

	
/obj/hud/button/teleport/teleport_here/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(icon_state && all_wishgranters[icon_state] && is_player(caller))

		var/mob/living/advanced/player/P = caller

		if(!P.client)
			return FALSE

		var/turf/desired_turf = get_turf(all_wishgranters[icon_state])
		desired_turf = get_step(desired_turf,SOUTH)
		var/list/callback_list = list()
		callback_list["start_turf"] = get_turf(P)
		callback_list["end_turf"] = desired_turf
		if(add_progress_bar(P,"teleport",SECONDS_TO_DECISECONDS(3),callback_list))
			P.to_chat(span("notice","You begin walking into the light..."))
			P.show_hud(FALSE,FLAGS_HUD_TELEPORT,FLAGS_HUD_NONE,speed=1)

	return ..()




/obj/hud/button/teleport/teleport_here/proc/cycle_map(var/mob/living/advanced/A,var/desired_direction = EAST)

	var/list/known_locations = A.known_wishgranters - "main"

	if(!known_locations || !length(known_locations))
		return FALSE

	map_number = map_number + (desired_direction == EAST ? 1 : -1)

	map_number = SAFEINDEX(map_number,length(known_locations))

	icon_state = known_locations[map_number]
	name = known_locations[map_number]
	update_icon()

	return ..()

/obj/hud/button/teleport/cycle/
	icon_state = "arrow"

/obj/hud/button/teleport/cycle/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.client)
		return FALSE

	for(var/obj/hud/button/teleport/teleport_here/B in A.buttons)
		B.cycle_map(A,dir)

	return ..()

/obj/hud/button/teleport/cycle/right
	dir = EAST
	screen_loc = "CENTER+2,CENTER+3"


/obj/hud/button/teleport/cycle/left
	dir = WEST
	screen_loc = "CENTER-2,CENTER+3"

