/turf/simulated/floor/
	name = "FLOOR"
	desc = "A floor."
	density_down = TRUE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

/turf/simulated/floor/is_safe_teleport()
	if(collision_flags & FLAG_COLLISION_WALKING)
		return FALSE

	for(var/atom/movable/M in contents)
		if(M.collision_flags & FLAG_COLLISION_WALKING)
			return FALSE

	return TRUE

/turf/simulated/floor/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!is_item(weapon))
		return FALSE

	var/obj/item/I = weapon

	if(!(I.flags_tool & FLAG_TOOL_SHOVEL))
		return FALSE

	return ..()


/turf/simulated/floor/Initialize()

	. = ..()

	if(water_reagent && reagents)
		var/reagent_container/turf/TR = reagents
		TR.desired_reagent = water_reagent
		TR.update_container()

	return .

/turf/simulated/floor/update_sprite()

	. = ..()

	if(reagents && length(reagents.stored_reagents))
		if(!stored_water_overlay)
			stored_water_overlay = new
			stored_water_overlay.icon = 'icons/obj/effects/water_height.dmi'
			stored_water_overlay.icon_state = "water"
			stored_water_overlay.alpha = 255
			stored_water_overlay.plane = PLANE_EFFECT
			stored_water_overlay.blend_mode = BLEND_SUBTRACT

		stored_water_overlay.color = reagents.color

	return .

/turf/simulated/floor/Exited(var/atom/movable/O,var/atom/new_loc)

	. = ..()

	if(O && stored_water_overlay)
		O.overlays -= stored_water_overlay

	return .


/turf/simulated/floor/can_construct_on(var/mob/caller,var/obj/structure/structure_to_make)

	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	var/area/A = loc
	if(A.flags_area & FLAGS_AREA_NO_CONSTRUCTION)
		caller.to_chat(span("warning","You cannot deploy this in this area!"))
		return FALSE

	for(var/obj/structure/S in src.contents)
		if(S.under_tile != SAFEVAR(structure_to_make,under_tile))
			continue
		if(istype(S,structure_to_make))
			var/flags_placement = SAFEVAR(structure_to_make,flags_placement)
			if(flags_placement & FLAGS_PLACEMENT_ALLOW_MULTIPLE)
				continue
			if(flags_placement & FLAGS_PLACEMENT_DIRECTIONAL)
				if(!(S.dir & caller.dir))
					continue
		caller.to_chat(span("warning","There is a structure ([S.name]) here already!"))
		return FALSE

	return TRUE