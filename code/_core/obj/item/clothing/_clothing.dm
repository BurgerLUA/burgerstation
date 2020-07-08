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

	//Armor guide. Uses bullets as an example.
	//10 is very minor protection, like reinforced clothing.
	//25 is minor protection, like a makeshift plate vest.
	//50 is moderate protection, like police grade kevlar.
	//75 is serious protection, like military grade kevlar.
	//100 is ultra protection, like syndicate elite space armor.

	var/list/protected_limbs = list()
	var/list/protection_cold = list()
	var/list/protection_heat = list()
	var/list/protection_pressure = list()

	var/list/obj/item/additional_clothing = list()
	var/list/obj/item/additional_clothing_stored

	var/blocks_clothing = 0x0 //Flags of Clothing slots that are blocked from being equipped when this object is equipped.
	var/hidden_clothing = 0x0 //Flags of Clothing slots that it should hide when this object is equipped.
	var/list/hidden_organs = list() //List of organ IDs that are hidden when this object is equipped.



/obj/item/clothing/save_item_data(var/save_inventory = TRUE)
	. = ..()
	if(length(polymorphs)) .["polymorphs"] = polymorphs
	return .

/obj/item/clothing/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(object_data["polymorphs"]) polymorphs = object_data["polymorphs"]
	return .

/obj/item/clothing/New(var/desired_loc)
	additional_clothing_stored = list()
	..()
	initialize_blends()

/obj/item/clothing/Destroy()
	additional_clothing_stored.Cut()
	return ..()

/obj/item/clothing/Initialize()

	for(var/k in additional_clothing)
		var/obj/item/C = new k(src)
		C.should_save = FALSE
		C.color = color
		C.weight = 0
		C.size = 0
		C.additional_blends = additional_blends
		C.additional_clothing_parent = src
		C.delete_on_drop = FALSE
		additional_clothing_stored += C

	return ..()


/obj/item/clothing/initialize_blends(var/desired_icon_state)

	if(length(polymorphs))
		if(!desired_icon_state)
			desired_icon_state = icon_state_worn
		var/icon/initial_icon = initial(icon)
		for(var/polymorph_name in polymorphs)
			var/polymorph_color = polymorphs[polymorph_name]
			add_blend("polymorph_[polymorph_name]", desired_icon = initial_icon, desired_icon_state = "[desired_icon_state]_[polymorph_name]", desired_color = polymorph_color, desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)
		update_sprite()

	for(var/obj/item/C in additional_clothing_stored)
		C.initialize_blends()

	..()

/obj/item/clothing/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/clothing/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc)
	. = ..()
	remove_additonal_clothing()
	return .