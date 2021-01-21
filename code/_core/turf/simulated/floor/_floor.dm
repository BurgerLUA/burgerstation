/turf/simulated/floor/
	name = "FLOOR"
	desc = "A floor."
	density_down = TRUE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	health_base = 100

	plane = PLANE_FLOOR

	density = FALSE

/turf/simulated/floor/is_safe_teleport()
	if(collision_flags & FLAG_COLLISION_WALKING)
		return FALSE

	for(var/atom/movable/M in src.contents)
		if(M.collision_flags & FLAG_COLLISION_WALKING)
			return FALSE

	return TRUE

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
		caller.to_chat(span("warning","You cannot construct this in this area!"))
		return FALSE

	var/mob/living/L = locate() in contents
	if(L)
		caller.to_chat(span("warning","You can't build this here, \the [L.name] is in the way!"))
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
			caller.to_chat(span("warning","There is a [S.name] here already!"))
			return FALSE
		else
			for(var/k in S.structure_blacklist)
				if(istype(k,structure_to_make))
					caller.to_chat(span("warning","You cannot construct this with \the [S.name] in the way!"))
					return FALSE

	return TRUE

/turf/simulated/floor/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/item/material/rod))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/construct_frame,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_frame,caller,object)
		return TRUE

	return ..()

/turf/simulated/floor/proc/construct_frame(var/mob/caller,var/obj/item/material/rod/R)
	var/obj/structure/interactive/construction/frame/F = new(src)
	F.material_id = R.material_id
	F.color = R.color
	INITIALIZE(F)
	FINALIZE(F)
	caller.visible_message(span("notice","\The [caller.name] places \the [F.name]."),span("notice","You place \the [F.name]."))
	R.add_item_count(-2)
	return TRUE

/turf/simulated/floor/proc/can_construct_frame(var/mob/caller,var/obj/item/material/rod/R)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(R)

	if(R.item_count_current < 2)
		caller.to_chat(span("warning","You need 2 rods in order to build a frame!"))
		return FALSE

	if(!src.can_construct_on(caller,/obj/structure/interactive/construction/frame/))
		return FALSE

	return TRUE