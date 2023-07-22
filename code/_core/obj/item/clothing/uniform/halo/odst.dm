/obj/item/clothing/uniform/halo/odst
	name = "ODST's troops uniform"
	desc = "A slightly reinforced jumpsuit for helljumpers."
	desc_extended = "A jumpsuit made to withstand the elements when doing the most dangerous and least well paid job on war front."
	icon = 'icons/obj/item/clothing/uniforms/odst.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		HEAT = 20,
		COLD = 20,
		ARCANE = -20
	)

	value = 50