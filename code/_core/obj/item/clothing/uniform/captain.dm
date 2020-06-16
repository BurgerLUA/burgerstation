/obj/item/clothing/uniform/captain
	name = "\improper Captain's uniform"
	icon = 'icons/obj/items/clothing/uniforms/captain.dmi'
	rarity = RARITY_MYTHICAL

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -25,
		HEAT = 15,
		COLD = 15,
		BOMB = 25,
		BIO = 25
	)

	value = 300

/obj/item/clothing/uniform/captain/formal
	name = "formal Captain's uniform"
	icon = 'icons/obj/items/clothing/uniforms/captain_formal.dmi'