/obj/item/clothing/overwear/armor/vest/
	name = "tactical vest"
	icon = 'icons/obj/items/clothing/suit/black_vest.dmi'

	rarity = RARITY_UNCOMMON

	desc = "I NEED MORE POCKETS."
	desc_extended = "A sturdy vest that protects against bullets and inventory management."

	size = 8

	is_container = TRUE
	dynamic_inventory_count = 4

	container_max_weight = 8
	container_max_size = 2

	defense_rating = list(
		BLADE = 20,
		BLUNT = 10,
		PIERCE = 30,
		LASER = 0,
		MAGIC = -25,
		HEAT = 0,
		COLD = 10,
		BOMB = 10,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	weight = WEIGHT_4

/obj/item/clothing/overwear/armor/vest/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	if(is_inventory(object))
		click_self(caller,location,control,params)
		return TRUE

	return ..()