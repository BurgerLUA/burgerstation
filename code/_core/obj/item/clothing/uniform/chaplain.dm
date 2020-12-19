/obj/item/clothing/uniform/priest
	name = "priest's uniform"
	desc = "The void of space turns men to religion, especially if they get thrown into it without a suit."
	desc_extended = "The uniform of NT approved Chaplains, which already tells you they're rarely gonna be good chaplains."
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/item/clothing/uniforms/religious.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = -AP_DAGGER,
		COLD = AP_DAGGER,
		HOLY = AP_GREATSWORD,
		DARK = -AP_GREATSWORD
	)

	value = 120