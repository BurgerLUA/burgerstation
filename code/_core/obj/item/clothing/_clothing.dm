/obj/item/clothing
	name = "CLOTHING"
	desc = "THIS IS CLOTHING."
	var/flags_clothing = FLAG_CLOTHING_NONE
	color = "#ffffff"

	var/polymorphic = FALSE

	color = "#FFFFFF"

	var/color_primary = "#FF0000"
	var/color_secondary = "#00FF00"
	var/color_tertiary = "#0000FF"

	icon_state = "inventory"
	icon_state_worn = "worn"

	var/list/defense_rating = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	var/list/protected_limbs = list()

/obj/item/clothing/New(var/desired_loc)
	..()
	initialize_blends()

/obj/item/clothing/on_spawn()
	if(polymorphic)
		update_icon()
	..()

/obj/item/clothing/initialize_blends()

	if(polymorphic)
		add_blend("outfit_primary", desired_icon = icon, desired_icon_state = "[icon_state_worn]_primary", desired_color = color_primary, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)
		add_blend("outfit_secondary", desired_icon = icon, desired_icon_state = "[icon_state_worn]_secondary", desired_color = color_secondary, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)
		add_blend("outfit_tertiary", desired_icon = icon, desired_icon_state = "[icon_state_worn]_tertiary", desired_color = color_tertiary, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)

	..()


/obj/item/clothing/update_icon()

	if(!polymorphic)
		return ..()

	if(layer == LAYER_MOB_HELD)
		return ..()

	var/icon/I1 = new /icon(icon,"[icon_state]_primary")
	var/icon/I2 = new /icon(icon,"[icon_state]_secondary")
	var/icon/I3 = new /icon(icon,"[icon_state]_tertiary")
	I1.Blend(color_primary,ICON_MULTIPLY)
	I2.Blend(color_secondary,ICON_MULTIPLY)
	I3.Blend(color_tertiary,ICON_MULTIPLY)

	I1.Blend(I2,ICON_OVERLAY)
	I1.Blend(I3,ICON_OVERLAY)

	icon = I1

	..()

/obj/item/clothing/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE