/obj/overlay
	name = "overlay"
	desc = "overlay object"
	icon = 'icons/invisible.dmi'
	icon_state = "0"

	var/initial_icon
	var/initial_icon_state

	var/atom/attached_object

	var/never_blend = FALSE

	var/no_initial = FALSE

	var/no_update = FALSE

/obj/overlay/update_icon()

	if(no_update)
		return

	if(length(additional_blends) && !never_blend)
		var/icon/I

		if(no_initial)
			I = ICON_INVISIBLE
		else
			I = new /icon(initial_icon,initial_icon_state)

		for(var/id in additional_blends)
			var/icon_blend/IB = additional_blends[id]

			if(IB.layer)
				layer = IB.layer

			if(IB.special_type & ICON_BLEND_MASK)
				var/icon/OI = new (IB.icon,IB.icon_state)
				var/icon/MI = new (initial_icon,initial_icon_state)
				MI.Blend("#FFFFFF",ICON_ADD)
				MI.Blend(OI,ICON_MULTIPLY)
				I.Blend(MI,ICON_OVERLAY)

			else if(IB.special_type & ICON_BLEND_OVERLAY)
				var/icon/OI = new (IB.icon,IB.icon_state)
				world.log << IB.icon_state
				OI.Blend(IB.color,ICON_MULTIPLY)
				I.Blend(OI,ICON_OVERLAY)

			if(IB.special_type & ICON_BLEND_COLOR)
				I.Blend(IB.color,ICON_MULTIPLY)

		icon = I
	else
		icon = initial_icon
		icon_state = initial_icon_state