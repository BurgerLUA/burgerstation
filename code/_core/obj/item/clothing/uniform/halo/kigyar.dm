/obj/item/clothing/uniform/halo/covenant/kigyar
	name = "armored alien suit"
	desc = "A slightly reinforced jumpsuit for snipers."
	desc_extended = "A jumpsuit made for Kig-Yars."
	icon = 'icons/obj/item/clothing/uniforms/kigyar.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOHUMAN

	defense_rating = list(
		BLADE = 25,
		BLUNT = 20,
		PIERCE = 10,
		HEAT = 20,
		COLD = 20,
		ARCANE = -30
	)

	value = 80

/obj/item/clothing/uniform/halo/covenant/kigyar/less
	icon = 'icons/obj/item/clothing/uniforms/kigyar2.dmi'
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	value = 50