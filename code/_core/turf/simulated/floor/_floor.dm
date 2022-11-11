/turf/simulated/floor/
	name = "FLOOR"
	desc = "A floor."

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	health_base = 100

	plane = PLANE_FLOOR

	density = FALSE

/turf/simulated/floor/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!damage_type || !damage_type.target_floors)
		return FALSE

	return ..()


/turf/simulated/floor/Initialize()

	. = ..()

	if(water_reagent && reagents)
		var/reagent_container/turf/TR = reagents
		TR.desired_reagent = water_reagent
		TR.update_container()

/*
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
*/


/turf/simulated/floor/Exited(var/atom/movable/O,var/atom/new_loc)

	. = ..()

	if(O && stored_water_overlay)
		O.overlays -= stored_water_overlay



/turf/simulated/floor/can_construct_on(var/atom/caller,var/obj/structure/structure_to_make = null)

	if(!is_living(caller))
		return FALSE
	var/mob/living/C = caller
	if(get_dist(C,src) > 1)
		C.to_chat(span("warning","You're too far away!"))
		return FALSE

	var/area/A = loc
	if(A.flags_area & FLAG_AREA_NO_CONSTRUCTION)
		C.to_chat(span("warning","You cannot construct this in this area!"))
		return FALSE

	var/mob/living/L = locate() in contents
	if(L)
		C.to_chat(span("warning","You can't build this here, \the [L.name] is in the way!"))
		return FALSE
	for(var/obj/structure/S in src.contents)
		if(S.under_tile != SAFEVAR(structure_to_make,under_tile))
			continue
		if(istype(S,structure_to_make) || structure_to_make != null)
			var/flags_placement = SAFEVAR(structure_to_make,flags_placement)
			if(flags_placement & FLAG_PLACEMENT_ALLOW_MULTIPLE)
				continue
			if(flags_placement & FLAG_PLACEMENT_DIRECTIONAL)
				if(!(S.dir & C.dir))
					continue
			C.to_chat(span("warning","There is a [S.name] here already!"))
			return FALSE
		else
			for(var/k in S.structure_blacklist)
				if(istype(k,structure_to_make))
					C.to_chat(span("warning","You cannot construct this with \the [S.name] in the way!"))
					return FALSE

	return TRUE
