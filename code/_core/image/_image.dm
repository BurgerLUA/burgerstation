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
	return ..()

/image/overlay/proc/add_overlay(var/datum/overlay_to_add)
	overlays += overlay_to_add
	return TRUE

/image/overlay/proc/update() //Custom shit.

	if(no_update)
		return

	overlays.Cut()

	if(length(additional_blends) && !never_blend)

		//Sort blends by layer.

		additional_blends = sortTim(additional_blends,/proc/cmp_icon_blend_layer, TRUE)

		var/icon/I

		if(no_initial)
			I = ICON_INVISIBLE
		else
			I = new/icon(initial_icon,initial_icon_state)

		for(var/id in additional_blends)
			var/icon_blend/IB = additional_blends[id]

			/* UNUSED
			if(IB.special_type & ICON_BLEND_MASK)
				var/icon/OI = new/icon(IB.icon,IB.icon_state)
				var/icon/MI = new/icon(initial_icon,initial_icon_state)
				MI.Blend("#FFFFFF",ICON_ADD)
				MI.Blend(OI,ICON_MULTIPLY)
				I.Blend(MI,ICON_OVERLAY)
			*/

			if(IB.special_type & ICON_BLEND_OVERLAY)
				var/image/OI = new/image(IB.icon,IB.icon_state)
				OI.color = IB.color
				OI.layer = IB.layer
				add_overlay(OI)

			if(IB.special_type & ICON_BLEND_COLOR)
				I.Blend(IB.color,ICON_MULTIPLY)

		icon = I
	else
		icon = initial_icon
		icon_state = initial_icon_state

	if(attached_object)
		name = "[attached_object.name] (overlay)"

	return TRUE