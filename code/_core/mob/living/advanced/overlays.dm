/mob/living/advanced/proc/add_overlay_tracked(var/k,var/atom/object,var/desired_plane,var/desired_layer,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_additional_blends,var/desired_never_blend = FALSE, var/desired_no_initial = FALSE, var/desired_pixel_x = 0, var/desired_pixel_y = 0, var/desired_transform)

	if(!k)
		k = "\ref[object]"

	if(overlays_assoc[k])
		CRASH_SAFE("An overlay of reference [k] already exists! Removing and replacing...")
		remove_overlay(k)

	var/image/overlay/O = new /image/overlay
	if(object)
		O.attached_object = object
	else
		object = src //Intentional. This is just a fallback for the below settings.
	O.initial_icon = desired_icon ? desired_icon : object.icon
	O.initial_icon_state = desired_icon_state ? desired_icon_state : object.icon_state
	O.layer = desired_layer ? desired_layer : object.layer
	O.plane = desired_plane ? desired_plane : src.plane
	O.icon = desired_icon ? desired_icon : object.icon
	O.icon_state = desired_icon_state ? desired_icon_state : object.icon_state
	O.color = desired_color ? desired_color : object.color
	O.never_blend = desired_never_blend
	O.no_initial = desired_no_initial
	O.pixel_x = desired_pixel_x
	O.pixel_y = desired_pixel_y
	if(desired_transform)
		O.transform = desired_transform
	if(!desired_never_blend)
		if(desired_additional_blends)
			O.additional_blends = desired_additional_blends
		else if(isobj(object))
			var/obj/B = object
			O.additional_blends = B.additional_blends

	O.update()
	add_overlay(O)
	overlays_assoc[k] = O
	return O

mob/living/advanced/proc/remove_overlay(var/k)

	if(!overlays_assoc[k]) //It is normal not to find any.
		//CRASH_SAFE("Tried to remove non-existant overlay! ([k]).")
		return FALSE

	var/image/overlay/O = overlays_assoc[k]
	overlays -= O
	overlays_assoc -= k
	qdel(O)
	return TRUE

/mob/living/advanced/proc/update_all_blends() //Avoid using this.
	for(var/k in overlays_assoc)
		var/image/overlay/O = overlays_assoc[k]
		if(!istype(O))
			var/datum/found_ref = locate(k)
			CRASH_SAFE("Warning: Tried to get the associated overlay of [k] (Found Ref: [found_ref ? found_ref.get_debug_name() : "NULL"], but it returned [O ? O : "NULL"].")
			continue
		overlays -= O
		O.update()
		add_overlay(O) //Is this needed?
	return TRUE

/mob/living/advanced/proc/update_overlay_tracked(var/k,var/desired_layer,var/desired_plane,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_additional_blends,var/desired_never_blend,var/desired_no_initial,var/desired_pixel_x,var/desired_pixel_y,var/desired_alpha,var/desired_transform)

	var/image/overlay/O = overlays_assoc[k]

	if(!istype(O))
		var/datum/found_ref = locate(k)
		CRASH_SAFE("Warning: Tried to update the associated overlay of [k] (Found Ref: [found_ref ? found_ref.get_debug_name() : "NULL"], but it returned [O ? O : "NULL"].")
		return FALSE

	overlays -= O

	if(isnum(desired_layer))
		O.layer = desired_layer
	if(isnum(desired_plane))
		O.plane = desired_plane
	if(desired_icon)
		O.icon = desired_icon
		O.initial_icon = desired_icon
	if(desired_icon_state)
		O.icon_state = desired_icon_state
		O.initial_icon_state = desired_icon_state
	if(desired_color)
		O.color = desired_color
	if(desired_additional_blends)
		O.additional_blends = desired_additional_blends
	if(desired_transform)
		O.transform = desired_transform
	if(isnum(desired_pixel_x))
		O.pixel_x = desired_pixel_x
	if(isnum(desired_pixel_y))
		O.pixel_y = desired_pixel_y
	if(isnum(desired_alpha))
		O.alpha = desired_alpha
	O.update()

	add_overlay(O)

	return TRUE

/mob/living/advanced/proc/show_overlay(var/k,var/show=TRUE)
	update_overlay_tracked(k,desired_alpha = show ? 255 : 0)
	return TRUE