/obj/item/clothing
	name = "CLOTHING"
	desc = "THIS IS CLOTHING."
	worn_layer = LAYER_MOB
	var/flags_clothing = FLAG_CLOTHING_NONE
	value = 1

	color = "#FFFFFF"

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
	var/hide_hair = FALSE

	var/list/protection_cold = list()
	var/list/protection_heat = list()
	var/list/protection_pressure = list()

	var/list/obj/item/clothing/additional_clothing = list()
	var/list/obj/item/clothing/additional_clothing_stored

/obj/item/clothing/New(var/desired_loc)
	additional_clothing_stored = list()
	..()
	initialize_blends()

/obj/item/clothing/initialize_blends(var/desired_icon_state)

	if(length(polymorphs))
		if(!desired_icon_state)
			desired_icon_state = icon_state_worn
		var/icon/initial_icon = initial(icon)
		for(var/polymorph_name in polymorphs)
			var/polymorph_color = polymorphs[polymorph_name]
			add_blend("polymorph_[polymorph_name]", desired_icon = initial_icon, desired_icon_state = "[desired_icon_state]_[polymorph_name]", desired_color = polymorph_color, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)
		update_sprite()

	..()

/obj/item/clothing/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE


/obj/item/clothing/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc)
	. = ..()
	delete_additonal_clothing()
	return .