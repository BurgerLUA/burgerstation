/obj/item/clothing/overwear/coat/apron
	name = "blacksmith's apron"
	icon = 'icons/obj/item/clothing/suit/apron_leather.dmi'
	desc = "Perfect for the blacksmith in you."
	desc_extended = "Contains large pockets, capable of holding two Size 3 items."
	worn_layer = LAYER_MOB_CLOTHING_COAT

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	is_container = TRUE
	dynamic_inventory_count = 2

	container_max_size = SIZE_3

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 25,
		HEAT = 75
	)

	size = SIZE_3
	weight = WEIGHT_3

	value = 15