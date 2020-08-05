/obj/item/clothing/uniform/priest
	name = "priest's uniform"
	desc = "The void of space turns men to religion, especially if they get thrown into it without a suit."
	desc_extended = "The uniform of NT approved Chaplains, which already tells you they're rarely gonna be good chaplains."
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/item/clothing/uniforms/religious.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		ARCANE = 25,
		HEAT = 10,
		COLD = 15,
		HOLY = 100,
		DARK = -50
	)

	value = 120