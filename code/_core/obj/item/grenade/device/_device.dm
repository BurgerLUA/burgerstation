/obj/item/grenade/device/
	icon = 'icons/obj/item/grenade_new.dmi'
	icon_state = "grenade"

	var/marker_color = "#FFFFFF"
	var/paint_color

	value = 1

/obj/item/grenade/device/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(spent)
		icon_state = "[icon_state]_spent"
	else if(stored_trigger?.active)
		icon_state = "[icon_state]_active"
	else if(open)
		icon_state = "[icon_state]_casing"

/obj/item/grenade/device/update_overlays()

	. = ..()

	if(!open && paint_color)
		var/image/I = new/image(icon,null)
		if(spent)
			I.icon_state = "[initial(icon_state)]_spent_paint"
		else
			I.icon_state = "[initial(icon_state)]_paint"
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = paint_color
		add_overlay(I)

	if(!spent && !open && marker_color)
		var/image/I = new/image(icon,"[initial(icon_state)]_marking")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = marker_color
		add_overlay(I)