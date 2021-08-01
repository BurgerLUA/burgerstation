/obj/item/clothing
	name = "CLOTHING"
	desc = "THIS IS CLOTHING."
	worn_layer = LAYER_MOB
	var/flags_clothing = FLAG_CLOTHING_NONE

	weight = 0

	can_rename = TRUE

	color = "#FFFFFF"

	icon_state = "inventory"
	icon_state_worn = "worn"

	var/list/defense_rating = list()

	/*
	defense_rating = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		SANITY = 0,
		ION = 0,
		PAIN = 0
	)
	*/


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

	var/hidden_clothing = 0x0 //Flags of Clothing slots that it should hide when this object is equipped.
	var/list/hidden_organs = list() //List of organ IDs that are hidden when this object is equipped.

	drop_sound = 'sound/items/drop/clothing.ogg'

	can_wear = TRUE

	value = -1

	var/speed_bonus = 0

	var/loyalty_tag //Set to a loyalty tag here to restrict this to those who have this tag.

	var/list/ench/clothing_enchantments = list()

/obj/item/clothing/Destroy()
	QDEL_CUT(additional_clothing_stored)
	. = ..()

/obj/item/clothing/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)

	if(loyalty_tag && owner.loyalty_tag != loyalty_tag)
		if(messages) owner.to_chat(span("warning","<b>\The [src.name]</b> dings, \"Invalid Loyalty Tag detected!\""))
		return FALSE

	return ..()

/obj/item/clothing/proc/get_defense_rating()
	return defense_rating.Copy()

/obj/item/clothing/save_item_data(var/save_inventory = TRUE)
	. = ..()
	if(length(polymorphs)) .["polymorphs"] = polymorphs

	if(length(clothing_enchantments))
		.["clothing_enchantments"] = list()
		for(var/k in clothing_enchantments)
			var/ench/E = k
			.["clothing_enchantments"][E.type] = E.magnitude


/obj/item/clothing/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(object_data["polymorphs"]) polymorphs = object_data["polymorphs"]
	if(object_data["clothing_enchantments"])
		for(var/k in object_data["clothing_enchantments"])
			var/ench/E = new k
			E.magnitude = object_data["clothing_enchantments"][k]
			clothing_enchantments += E

/obj/item/clothing/New(var/desired_loc)
	additional_clothing_stored = list()
	. = ..()

/obj/item/clothing/Initialize()

	weight = calculate_weight()

	initialize_blends()

	for(var/k in additional_clothing)
		var/obj/item/C = new k(src)
		C.should_save = FALSE
		C.size = 0
		INITIALIZE(C)
		FINALIZE(C)
		C.additional_clothing_parent = src
		additional_clothing_stored += C

	sync_additional_clothing()

	. = ..()


/obj/item/clothing/initialize_blends(var/desired_icon_state)

	. = ..()

	for(var/k in additional_clothing_stored)
		var/obj/item/C = k
		C.initialize_blends()



/obj/item/clothing/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc,var/silent=FALSE)
	. = ..()
	remove_additonal_clothing()

/obj/item/clothing/proc/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps