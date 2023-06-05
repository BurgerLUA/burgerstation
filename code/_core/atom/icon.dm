/atom/proc/update_sprite()
	overlays.Cut()
	underlays.Cut()
	update_icon()
	update_overlays()
	update_underlays()
	return TRUE

/atom/proc/update_icon()
	return TRUE

/atom/proc/update_overlays()
	return TRUE

/atom/proc/update_underlays()
	return TRUE

/atom/proc/add_overlay(var/datum/desired_overlay)

	if(length(overlays) >= 100)
		CRASH("Warning: [get_debug_name()] exceeds 100 overlays![is_datum(desired_overlay) ? " Overlay name: [desired_overlay.get_debug_name()]." : ""]")

	overlays += desired_overlay

	return TRUE

/atom/proc/add_underlay(var/datum/desired_underlay)

	if(length(underlays) >= 100)
		CRASH("Warning: [get_debug_name()] exceeds 100 underlays![is_datum(desired_underlay) ? " Overlay name: [desired_underlay.get_debug_name()]." : ""]")

	underlays += desired_underlay

	return TRUE

/atom/movable/proc/add_vis_content(var/atom/movable/desired_vis_content)

	if(length(vis_contents) >= 100)
		CRASH("Warning: [get_debug_name()] exceeds 100 vis contents![is_datum(desired_vis_content) ? " Overlay name: [desired_vis_content.get_debug_name()]." : ""]")

	vis_contents += desired_vis_content

	return TRUE

/atom/movable/proc/remove_vis_content(var/atom/movable/desired_vis_content)

	vis_contents -= desired_vis_content

	return TRUE

