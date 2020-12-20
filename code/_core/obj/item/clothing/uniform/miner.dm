/obj/item/clothing/uniform/miner
	name = "miner's uniform"
	desc = "A slightly reinforced jumpsuit for miners."
	desc_extended = "A jumpsuit made to withstand the elements when doing the most dangerous and least well paid job NT has to offer."
	icon = 'icons/obj/item/clothing/uniforms/miner.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		HEAT = AP_SWORD,
		COLD = AP_SWORD,
		ARCANE = -AP_SWORD
	)

	value = 100


