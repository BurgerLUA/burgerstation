/obj/item/clothing/head/hat/space_cop
	name = "space cop's hood"
	desc = "Conform to hair standards."
	desc_extended = "A hood commonly used by the Space Cops."
	icon = 'icons/obj/item/clothing/hats/space_cop.dmi'
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	worn_layer = LAYER_MOB_CLOTHING_HEADWRAP

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_DAGGER,
		COLD = AP_DAGGER
	)

	size = SIZE_2