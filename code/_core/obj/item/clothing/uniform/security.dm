/obj/item/clothing/uniform/security
	name = "outdated security uniform"
	desc = "I swear his head was already caved in when i found him!"
	desc_extended = "The old shitcurity uniform."
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/item/clothing/uniforms/security.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		ARCANE = -20,
		HEAT = 10
	)

	value = 40


/obj/item/clothing/uniform/ABOMB
	name = "\improper A.B.O.M.B. uniform"
	desc = "LOOK OUT JC!"
	desc_extended = "It's said a team of scientists were close to figuring out what the acronym means, but were interrupted when A BOMB was found in their building."
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/item/clothing/uniforms/abomb_suit.dmi'
	rarity = RARITY_RARE

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = 20,
		ARCANE = -20,
		COLD = 20,
		BOMB = -20
	)

	value = 400

/*
/obj/item/clothing/uniform/tacticool
	name = "tacticool uniform"
	desc = "Look mom! I'm a real soldier!"
	desc_extended = "A tacticool shirt for less than cool people."
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/item/clothing/uniforms/tacticool.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 15,
		LASER = -15,
		ARCANE = -15,
		COLD = 15
	)

	value = 30
*/