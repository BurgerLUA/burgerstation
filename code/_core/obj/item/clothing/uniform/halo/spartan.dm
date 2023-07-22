/obj/item/clothing/uniform/halo/spartan
	name = "MJOLNIR Body-suit"
	desc = "A slightly reinforced jumpsuit for high-ranked soldiers."
	desc_extended = "A sealed, airtight bodysuit. Meant to be worn underneath the MJOLNIR Mark V armor."
	icon = 'icons/obj/item/clothing/uniforms/spartan.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_SPARTAN

	defense_rating = list(
		BLADE = 25,
		BLUNT = 20,
		PIERCE = 10,
		HEAT = 40,
		COLD = 40,
		ARCANE = -30
	)

	value = 80