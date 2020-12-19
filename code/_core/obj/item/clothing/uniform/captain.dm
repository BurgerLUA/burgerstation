/obj/item/clothing/uniform/captain
	name = "\improper Captain's uniform"
	desc = "STUBBED MY TOE, CALL THE SHUTTLE!"
	desc_extended = "A suit worn by Captains of Nanotrasen stations. Does not resemble a giant comdom."
	icon = 'icons/obj/item/clothing/uniforms/captain.dmi'
	rarity = RARITY_MYTHICAL

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_SWORD,
		ARCANE = -AP_AXE,
		COLD = AP_DAGGER
	)

	value = 600

/obj/item/clothing/uniform/captain/formal
	name = "formal Captain's uniform"
	icon = 'icons/obj/item/clothing/uniforms/captain_formal.dmi'