/obj/item/clothing/uniform/halo/covenant/unggoy
	name = "armored alien suit"
	desc = "A slightly reinforced jumpsuit for ungas."
	desc_extended = "A jumpsuit made to withstand the elements when doing the most dangerous job on war front."
	icon = 'icons/obj/item/clothing/uniforms/unggoy.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOHUMAN

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		HEAT = 10,
		COLD = 10,
		ARCANE = -30
	)

	value = 50