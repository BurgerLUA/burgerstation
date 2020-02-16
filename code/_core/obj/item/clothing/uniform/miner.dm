/obj/item/clothing/uniform/miner
	name = "miner's uniform"
	desc = "A slightly reinforced jumpsuit for miners."
	icon = 'icons/obj/items/clothing/uniforms/miner.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		HEAT = ARMOR_C,
		COLD = -ARMOR_C,
		MAGIC = -ARMOR_E
	)

	value = 20


