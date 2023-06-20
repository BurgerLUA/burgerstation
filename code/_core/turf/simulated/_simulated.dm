/turf/simulated/

	dynamic_lighting = TRUE

	health = null //This value is automatically assigned if there is a destruction_turf.
	health_base = 0 //Set to 0 for no health.

	var/real_icon
	var/real_icon_state

	var/tile = FALSE //Set to true if this is a tile.

	var/turf/destruction_turf

	var/exposed = TRUE //Are pipes and other hidden objects visible?

	var/turf_temperature_mod = 0

	var/image/overlay/stored_water_overlay
	var/water_reagent

	var/blood_level = 0 //How bloody the turf is. Used for footprints.
	var/blood_level_hard = 0 //How many blood objects. Used for checking if there is blood.
	var/blood_color //The color of blood.
	var/wet_level = 0

	var/drying_add = 0.1
	var/drying_mul = 0.02

	var/slip_factor = 1

	var/map_color = null //The map color. For drawing maps.

	var/corner_icons = FALSE
	var/corner_category = "none"

	var/smooth_code_1
	var/smooth_code_2
	var/smooth_code_3
	var/smooth_code_4

	var/queued_smoothing = FALSE

	var/material_id

	var/reinforced_material_id
	var/reinforced_color
	var/reinforced_alpha = 255
	var/reinforced_blend = BLEND_DEFAULT

	var/move_delay_modifier = 1 //Increase to make it harder to move on this turf. Decrease to make it easier. Only applies to mobs that touch the floor.

	var/organic = FALSE

	var/footstep/footstep //The footstep sounds that play.

	var/list/linked_attachments //For things like APCs, lights, etc.

	var/obj/effect/tile_wetness/wet_floor_effect
	var/wet_floor_icon_state = "full"

/turf/simulated/pre_change()
	. = ..()
	if(wet_level > 0)
		add_wet(-wet_level)

/turf/simulated/proc/destroy_attachments(var/delete=TRUE)
	if(!length(linked_attachments))
		return FALSE
	for(var/k in linked_attachments)
		var/obj/structure/O = k
		src.unattach(O)
		if(delete)
			qdel(O)
	return TRUE

/turf/simulated/proc/attach(var/obj/structure/O)
	if(!linked_attachments)
		linked_attachments = list()
	if(linked_attachments[O])
		return FALSE
	if(O.attached_to)
		O.attached_to.unattach(O)
	O.attached_to = src
	linked_attachments[O] = TRUE
	if(O.density)
		log_error("Warning: [O.get_debug_name()] was attached to a turf, but it had a density.")
		O.density = 0
	O.set_anchored(2)

/turf/simulated/proc/unattach(var/obj/structure/O)
	if(!linked_attachments) //No point.
		return FALSE
	O.attached_to = null
	linked_attachments -= O
	O.set_anchored(initial(O.anchored))
	return TRUE

/turf/simulated/can_move_to(var/check_contents=TRUE)

	if(collision_flags & FLAG_COLLISION_WALKING)
		return FALSE

	if(check_contents)
		for(var/atom/movable/M in src.contents)
			if(!M.density)
				continue
			if(M.collision_flags & FLAG_COLLISION_WALKING)
				return FALSE

	return ..()

/turf/simulated/proc/get_slip_strength(var/mob/living/L)
	return (wet_level > 0 ? 1 : 0) + (wet_level/100)*slip_factor

/turf/simulated/proc/add_wet(var/wet_to_add)
	var/old_wet = wet_level
	wet_level = clamp(wet_to_add + wet_level,0,100)
	if(old_wet <= 0)
		if(wet_level > 0)
			SSturf.wet_turfs += src
			if(!wet_floor_effect)
				wet_floor_effect = new(src)
				wet_floor_effect.icon_state = wet_floor_icon_state
	else
		if(wet_level <= 0)
			SSturf.wet_turfs -= src
			if(wet_floor_effect)
				QDEL_NULL(wet_floor_effect)

	if(wet_floor_effect)
		wet_floor_effect.alpha = clamp(100 + (wet_level/100)*155,0,255)



	return TRUE

/turf/simulated/proc/add_blood_level(var/amount_to_add,var/minimus=0,var/desired_color)
	if(desired_color && desired_color != blood_color)
		if(!blood_level || !blood_color)
			blood_color = desired_color
		else
			blood_color = blend_colors(blood_color,desired_color,amount_to_add/(amount_to_add+blood_level))
	blood_level = max(0,minimus,blood_level+amount_to_add)
	return TRUE

/turf/simulated/proc/add_blood_level_hard(var/amount_to_add,var/minimus=0)
	blood_level_hard = max(0,minimus,blood_level_hard+amount_to_add)
	return TRUE

/turf/simulated/on_destruction(var/damage = TRUE)

	if(destruction_turf == /turf/simulated/openspace)
		var/turf/T = locate(x,y,z-1)
		if(!T)
			QDEL_NULL(health)
			return FALSE
		if(T.density || !is_simulated(T)) //Don't break yet!
			return TRUE

	for(var/obj/effect/temp/impact/I in src.contents)
		I.alpha = 0

	. = ..()

	pixel_x = 0
	pixel_y = 0

	change_turf(destruction_turf)

/turf/simulated/Initialize()
	var/area/A = loc
	if(health_base > 0 && !(A.flags_area & FLAG_AREA_NO_CONSTRUCTION))
		if(!destruction_turf)
			if(A.destruction_turf && A.destruction_turf != src.type)
				destruction_turf = A.destruction_turf
			else if(SSdmm_suite.map_to_final_destruction_turf[SSdmm_suite.z_level_to_file[z]] && SSdmm_suite.map_to_final_destruction_turf[SSdmm_suite.z_level_to_file[z]] != src.type)
				destruction_turf = SSdmm_suite.map_to_final_destruction_turf[SSdmm_suite.z_level_to_file[z]]
		if(destruction_turf)
			health = /health/turf/
		else
			health_base = 0
	set_exposed(exposed,force=TRUE)
	return ..()

/turf/simulated/Finalize()
	. = ..()
	if(!map_color)
		map_color = color ? color : "#FFFFFF"
	if(corner_icons)
		if(SSsmoothing.initialized)
			SSsmoothing.queue_update_edges(src)
		else
			queue_smoothing_turf(src)


/turf/simulated/update_sprite()

	if(real_icon)
		icon = real_icon

	if(real_icon_state)
		icon_state = real_icon_state

	. = ..()





/turf/simulated/update_icon()

	if(corner_icons)
		var/full_icon_string = "[type]_[icon_state]_[smooth_code_1][smooth_code_2][smooth_code_3][smooth_code_4]"

		var/icon/I
		if(SSturf.icon_cache[full_icon_string])
			I = SSturf.icon_cache[full_icon_string]
			SSturf.saved_icons++
		else
			I = new/icon(icon,"1-[smooth_code_1]")

			var/icon/NE = new /icon(icon,"2-[smooth_code_2]")
			I.Blend(NE,ICON_OVERLAY)

			var/icon/SW = new /icon(icon,"3-[smooth_code_3]")
			I.Blend(SW,ICON_OVERLAY)

			var/icon/SE = new /icon(icon,"4-[smooth_code_4]")
			I.Blend(SE,ICON_OVERLAY)

			SSturf.icon_cache[full_icon_string] = I

		icon = I
		pixel_x = (TILE_SIZE - I.Width())/2 + initial(pixel_x)
		pixel_y = (TILE_SIZE - I.Height())/2 + initial(pixel_y)

		return TRUE

	. = ..()

/turf/simulated/update_overlays()

	. = ..()

	if(reinforced_material_id)
		var/image/I = new/image(initial(icon),"ref")
		I.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
		I.color = "#FFFFFF"
		I.alpha = reinforced_alpha
		I.blend_mode = reinforced_blend
		add_overlay(I)


/turf/simulated/proc/set_exposed(var/desired_exposed = FALSE,var/force=FALSE)

	if(desired_exposed == exposed && !force)
		return FALSE

	for(var/obj/O in src.contents)
		if(!O.under_tile)
			continue
		if(desired_exposed)
			O.invisibility = initial(O.invisibility)
		else
			O.invisibility = 101

	return TRUE

/turf/simulated/proc/do_footstep(var/mob/living/source,var/enter=FALSE)

	var/list/returning_footsteps = source.get_footsteps(footstep ? list(footstep) : list(),enter)
	if(length(returning_footsteps))
		return source.handle_footsteps(src,returning_footsteps,enter)

	return FALSE