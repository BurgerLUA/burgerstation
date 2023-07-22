/obj/item/clothing/uniform/halo/captain
	name = "UNSC captain uniform"
	desc = "A slightly reinforced jumpsuit."
	desc_extended = "A jumpsuit made to withstand the elements."
	icon = 'icons/obj/item/clothing/uniforms/unsc_captain.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		HEAT = 10,
		COLD = 10,
		ARCANE = -30
	)

	value = 50