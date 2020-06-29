/obj/item/clothing/uniform/stealth
	name = "stealth uniform"
	desc = "SM DELAM CALL THE SHUTTLE"
	icon = 'icons/obj/item/clothing/uniforms/stealth.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 25,
		BLUNT = 15,
		PIERCE = 25,
		LASER = -15,
		MAGIC = 25,
		HEAT = 15,
		COLD = 15,
		BOMB = 15
	)

	value = 60