/obj/item/container/pill
	name = "pill"
	desc = "FLOORPILL"

	icon = 'icons/obj/items/container/pills.dmi'
	icon_state = "rectangle"

	desc_extended = "Hope you remember what the pill is."

	var/marking = "A"
	var/double = FALSE

	var/reagent_container/reagents_2

/obj/item/container/pill/get_examine_text(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/pill/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I
	if(double)
		I = new/icon(icon,"[icon_state]_double_left")
		I.Blend(reagents.color,ICON_MULTIPLY)
		var/icon/I2 = new/icon(icon,"[icon_state]_double_right")
		I2.Blend(reagents_2.color,ICON_MULTIPLY)
		I.Blend(I2,ICON_OVERLAY)
	else
		I = new/icon(icon,icon_state)
		I.Blend(reagents.color,ICON_MULTIPLY)

	icon = I

	return TRUE

/obj/item/container/pill/New(var/desired_loc,var/desired_double=FALSE)

	double = desired_double

	if(double)
		reagents_2 = new/reagent_container/pill/half(src)
		reagents = /reagent_container/pill/half //new is made somewhere else
	else
		reagents = /reagent_container/pill/

	return ..()