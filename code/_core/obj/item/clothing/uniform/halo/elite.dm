/obj/item/clothing/uniform/halo/covenant/elite
	name = "Sangheili Body-suit"
	desc = "A slightly reinforced jumpsuit for high-ranked soldiers."
	desc_extended = "A sealed, airtight bodysuit. Meant to be worn underneath combat harnesses."
	icon = 'icons/obj/item/clothing/uniforms/elite.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOHUMAN

	defense_rating = list(
		BLADE = 25,
		BLUNT = 20,
		PIERCE = 10,
		HEAT = 40,
		COLD = 40,
		ARCANE = -30
	)

	value = 80