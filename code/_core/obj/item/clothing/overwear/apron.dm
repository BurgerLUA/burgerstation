/obj/item/clothing/neck/apron
	name = "leather apron"
	icon = 'icons/obj/items/clothing/suit/apron_leather.dmi'
	desc_extended = "A leather apron, perfect for the blacksmith in you. Contains large pockets"
	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	is_container = TRUE
	dynamic_inventory_count = 2

	container_max_size = SIZE_3

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 15,
		MAGIC = 10,
		HEAT = 75,
		COLD = 10
	)

	size = SIZE_3*2
	weight = WEIGHT_3

	value = 15