/obj/item/clothing/uniform/mummy
	name = "mummy wraps"
	desc = "Doesn't actually stop bleeding."
	desc_extended = "For when you want to look like an ancient corpse, or a person who's been in a really bad accident."
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/item/clothing/uniforms/mummy.dmi'
	rarity = RARITY_UNCOMMON

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 10,
		PIERCE = 10,
		LASER = -10,
		ARCANE = 40,
		HEAT = 10,
		COLD = -10,
		HOLY = -40,
		DARK = 40
	)

	value = 120