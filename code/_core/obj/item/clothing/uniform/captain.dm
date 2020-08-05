/obj/item/clothing/uniform/captain
	name = "\improper Captain's uniform"
	desc = "STUBBED MY TOE, CALL THE SHUTTLE!"
	desc_extended = "A suit worn by Captains of Nanotrasen stations. Does not resemble a giant comdom."
	icon = 'icons/obj/item/clothing/uniforms/captain.dmi'
	rarity = RARITY_MYTHICAL

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		ARCANE = -25,
		HEAT = 15,
		COLD = 15,
		BOMB = 25,
		BIO = 25
	)

	value = 600

/obj/item/clothing/uniform/captain/formal
	name = "formal Captain's uniform"
	icon = 'icons/obj/item/clothing/uniforms/captain_formal.dmi'