/image/

/image/overlay/
	var/initial_icon
	var/initial_icon_state
	var/atom/attached_object
	var/never_blend = FALSE
	var/no_initial = FALSE
	var/no_update = FALSE
	var/list/additional_blends = list()

/image/overlay/Destroy()
	attached_object = null
	QDEL_CUT_ASSOC(additional_blends)
	return ..()

/image/overlay/proc/add_overlay(var/datum/overlay_to_add)
	overlays += overlay_to_add
	return TRUE

/image/overlay/proc/update() //Custom shit.

	if(no_update)
		return

	overlays.Cut()
	for(var/k in filters)
		filters -= k

	if(length(additional_blends) && !never_blend)

		additional_blends = sortTim(additional_blends,/proc/cmp_icon_blend_layer, TRUE) //Sort blends by layer.

		if(no_initial)
			icon = null
			icon_state = null
		else
			icon = initial_icon
			icon_state = initial_icon_state

		for(var/id in additional_blends)
			var/icon_blend/IB = additional_blends[id]
			if(IB.icon && IB.icon_state && IB.icon_state != "")
				if(IB.special_type & ICON_BLEND_CUT)
					var/icon/OI = new/icon(IB.icon,IB.icon_state)
					filters += filter(type="alpha", icon=OI)
				else if(IB.special_type & ICON_BLEND_MASK)
					var/image/OI = new/image(IB.icon,IB.icon_state)
					OI.color = IB.color
					OI.layer = IB.layer
					OI.blend_mode = BLEND_INSET_OVERLAY
					OI.appearance_flags = RESET_COLOR
					add_overlay(OI)
				else if(IB.special_type & ICON_BLEND_OVERLAY)
					var/image/OI = new/image(IB.icon,IB.icon_state)
					OI.color = IB.color
					OI.layer = IB.layer
					OI.appearance_flags = RESET_COLOR
					add_overlay(OI)
			if(IB.special_type & ICON_BLEND_COLOR)
				color = IB.color
	else
		icon = initial_icon
		icon_state = initial_icon_state

	if(attached_object)	appearance_flags = attached_object.appearance_flags

	return TRUE