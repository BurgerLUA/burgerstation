/atom/proc/update_sprite()
	update_icon()
	overlays.Cut()
	update_overlays()
	underlays.Cut()
	update_underlays()
	return TRUE

/atom/proc/update_icon()
	return TRUE

/atom/proc/update_overlays()
	return TRUE

/atom/proc/update_underlays()
	return TRUE

/obj/proc/initialize_blends()
	return TRUE

/atom/proc/add_overlay(var/datum/desired_overlay)

	if(length(overlays) >= 100)
		CRASH_SAFE("Warning: [get_debug_name()] exceeds 100 overlays![is_datum(desired_overlay) ? " Overlay name: [desired_overlay.get_debug_name()]." : ""]")
		return FALSE

	overlays += desired_overlay

	return TRUE

/atom/proc/add_underlay(var/datum/desired_underlay)

	if(length(overlays) >= 100)
		CRASH_SAFE("Warning: [get_debug_name()] exceeds 100 underlays![is_datum(desired_underlay) ? " Overlay name: [desired_underlay.get_debug_name()]." : ""]")
		return FALSE

	underlays += desired_underlay

	return TRUE

/atom/movable/proc/add_vis_content(var/atom/movable/desired_vis_content)

	if(length(vis_contents) >= 100)
		CRASH_SAFE("Warning: [get_debug_name()] exceeds 100 vis contents![is_datum(desired_vis_content) ? " Overlay name: [desired_vis_content.get_debug_name()]." : ""]")
		return FALSE

	vis_contents |= desired_vis_content

	return TRUE

/atom/movable/proc/remove_vis_content(var/atom/movable/desired_vis_content)

	vis_contents -= desired_vis_content

	return TRUE



/obj/proc/add_blend(var/desired_id,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type, var/desired_should_save,var/desired_layer)

	if(additional_blends && additional_blends[desired_id])
		var/icon_blend/IB = additional_blends[desired_id]
		if(desired_icon)
			IB.icon = desired_icon

		if(desired_icon_state)
			IB.icon_state = desired_icon_state

		if(desired_color)
			IB.color = desired_color

		if(desired_blend)
			IB.blend = desired_blend

		if(desired_type)
			IB.special_type = desired_type

		if(desired_should_save)
			IB.should_save = desired_should_save

		if(desired_layer)
			IB.layer = desired_layer

		return IB
	else
		var/icon_blend/IB = new(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type, desired_should_save, desired_layer)
		if(!additional_blends)
			additional_blends = list()
		additional_blends[desired_id] = IB
		return IB

/*
/obj/proc/change_blend(var/desired_id,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type,var/desired_layer,var/debug_message)

	if(!additional_blends[desired_id])
		return FALSE

	if(desired_icon)
		additional_blends[desired_id].icon = desired_icon

	if(desired_icon_state)
		additional_blends[desired_id].icon_state = desired_icon_state

	if(desired_color)
		additional_blends[desired_id].color = desired_color

	if(desired_blend)
		additional_blends[desired_id].blend = desired_blend

	if(desired_type)
		additional_blends[desired_id].special_type = desired_type

	if(desired_layer)
		additional_blends[desired_id].layer = desired_layer

	if(debug_message)
		log_debug("[debug_message]: [desired_id] [additional_blends[desired_id].icon_state]")

	return TRUE
*/

/*
/obj/proc/blend_exists(var/desired_id)
	if(!additional_blends)
		return FALSE
	return additional_blends[desired_id]
*/