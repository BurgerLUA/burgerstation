/obj/item/clothing
	name = "CLOTHING"
	desc = "THIS IS CLOTHING."
	worn_layer = LAYER_MOB
	var/flags_clothing = FLAG_CLOTHING_NONE

	appearance_flags = PIXEL_SCALE | LONG_GLIDE | TILE_BOUND | KEEP_TOGETHER

	weight = 0

	can_rename = TRUE

	color = "#FFFFFF"

	icon_state = "inventory"
	icon_state_worn = "worn"

	var/armor/armor = /armor/ //GOD THIS SYSTEM IS A PAIN IN THE ASS, BUT IT WERKS.

	var/list/protected_limbs = list()
	var/list/protection_cold = list()
	var/list/protection_heat = list()
	var/list/protection_pressure = list()

	var/list/obj/item/additional_clothing = list()
	var/list/obj/item/additional_clothing_stored

	var/list/hidden_organs = list() //List of organ IDs that are hidden when this object is equipped. Includes clothing attached to this.

	drop_sound = 'sound/items/drop/clothing.ogg'

	can_wear = TRUE

	value = 0

	var/speed_bonus = 0

	enable_blood_stains = TRUE
	enable_damage_overlay = TRUE
	enable_torn_overlay = TRUE

	var/list/mob_values_add
	var/list/mob_values_mul

	quality = 100


/obj/item/clothing/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	var/obj/hud/inventory/IN = loc
	if(IN.worn && is_living(IN.owner))
		var/mob/living/L = IN.owner
		for(var/k in mob_values_add)
			L.add_mob_value("\ref[src]",k,mob_values_add[k],ADDITION)
		for(var/k in mob_values_mul)
			L.add_mob_value("\ref[src]",k,mob_values_mul[k],MULTIPLICATION)

/obj/item/clothing/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	if(old_inventory.worn && is_living(old_inventory.owner))
		var/mob/living/L = old_inventory.owner
		for(var/k in mob_values_add)
			L.remove_mob_value("\ref[src]",k,ADDITION)
		for(var/k in mob_values_mul)
			L.remove_mob_value("\ref[src]",k,MULTIPLICATION)
	remove_additonal_clothing()

/obj/item/clothing/PreDestroy()
	QDEL_CUT(additional_clothing_stored)
	. = ..()

/obj/item/clothing/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	if(length(polymorphs)) .["polymorphs"] = polymorphs

	/*
	if(length(clothing_enchantments))
		.["clothing_enchantments"] = list()
		for(var/k in clothing_enchantments)
			var/ench/E = k
			.["clothing_enchantments"][E.type] = E.magnitude
	*/


/obj/item/clothing/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	if(object_data["polymorphs"]) polymorphs = object_data["polymorphs"]
	/*
	if(object_data["clothing_enchantments"])
		for(var/k in object_data["clothing_enchantments"])
			var/ench/E = new k
			E.magnitude = object_data["clothing_enchantments"][k]
			clothing_enchantments += E
	*/

/obj/item/clothing/New(var/desired_loc)
	additional_clothing_stored = list()
	. = ..()

/obj/item/clothing/Initialize()

	weight = calculate_weight()

	for(var/k in additional_clothing)
		var/obj/item/C = new k(src)
		INITIALIZE(C)
		FINALIZE(C)
		C.additional_clothing_parent = src
		additional_clothing_stored += C

	sync_additional_clothing()

	. = ..()

/obj/item/clothing/proc/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps