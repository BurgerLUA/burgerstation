/obj/item/clothing/uniform/polymorphic
	name = "jumpsuit"
	desc = "A nice jumpsuit."

	icon_state = "inventory"
	icon_state_worn = "worn"

	icon = 'icons/obj/items/clothing/uniforms/poly_suit.dmi'

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	item_slot = SLOT_TORSO | SLOT_GROIN

	color = "#FFFFFF"

	var/color_primary = "#FF0000"
	var/color_secondary = "#00FF00"
	var/color_tertiary = "#0000FF"

/obj/item/clothing/uniform/New(var/desired_loc)
	..()
	initialize_blends()
/*
/obj/item/clothing/uniform/polymorphic/update_icon()

	icon = initial(icon)

	var/icon/I1 = new/icon(icon,"[icon_state]_primary")
	var/icon/I2 = new/icon(icon,"[icon_state]_secondary")
	var/icon/I3 = new/icon(icon,"[icon_state]_tertiary")
	I1.Blend(color_primary,ICON_MULTIPLY)
	I2.Blend(color_secondary,ICON_MULTIPLY)
	I3.Blend(color_tertiary,ICON_MULTIPLY)

	I1.Blend(I2,ICON_OVERLAY)
	I1.Blend(I3,ICON_OVERLAY)

	icon = I1
*/

/obj/item/clothing/uniform/polymorphic/initialize_blends()

	add_blend("outfit_primary", desired_icon = icon, desired_icon_state = "[icon_state_worn]_primary", desired_color = color_primary, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)
	add_blend("outfit_secondary", desired_icon = icon, desired_icon_state = "[icon_state_worn]_secondary", desired_color = color_secondary, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)
	add_blend("outfit_tertiary", desired_icon = icon, desired_icon_state = "[icon_state_worn]_tertiary", desired_color = color_tertiary, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)

	..()