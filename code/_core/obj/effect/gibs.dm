/obj/effect/gibs/
	name = "gibs"
	desc = "Disgusting."
	icon = 'icons/obj/effects/blood.dmi'
	icon_state = "gib1"
	var/blood_color = "#ff0000"
	var/flesh_color = "#0000ff"

	layer = LAYER_FLOOR_DECAL

/obj/effect/gibs/New(var/desired_loc,var/desired_blood_color,var/desired_flesh_color)
	..()
	// force_move(desired_loc) TODO: WHY IS THIS HERE
	blood_color = desired_blood_color
	flesh_color = desired_flesh_color
	update_sprite()
	queue_delete(src,600)

/obj/effect/gibs/update_icon()

	icon = initial(icon)

	var/icon/blood_icon = new /icon(icon,icon_state)
	blood_icon.Blend(blood_color,ICON_MULTIPLY)

	var/icon/gibs_icon = new /icon(icon,"[icon_state]_flesh")
	gibs_icon.Blend(blood_color,ICON_MULTIPLY)

	blood_icon.Blend(gibs_icon,ICON_OVERLAY)

	icon = blood_icon

	..()

/obj/effect/gibs/random/New(var/desired_loc,var/desired_blood_color,var/desired_flesh_color)
	icon_state = "gib[rand(1,5)]"
	..()