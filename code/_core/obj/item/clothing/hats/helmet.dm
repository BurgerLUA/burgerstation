/obj/item/clothing/head/helmet/
	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD

/obj/item/clothing/head/helmet/knight/

	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

	rarity = RARITY_UNCOMMON
	defense_rating = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 75,
		HEAT = -25,
		ARCANE = -75
	)

	size = SIZE_3


	value = 160

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE | SLOT_EYES

	slowdown_mul_worn = 1.05

/obj/item/clothing/head/helmet/knight/red
	name = "red knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_red.dmi'
	desc = "Deus Vult."
	desc_extended = "A knight's helmet. Made out of the finest metal."

/obj/item/clothing/head/helmet/knight/blue
	name = "blue knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_blue.dmi'

/obj/item/clothing/head/helmet/knight/green
	name = "green knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_green.dmi'

/obj/item/clothing/head/helmet/knight/yellow
	name = "yellow knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_yellow.dmi'

/obj/item/clothing/head/helmet/knight/templar
	name = "templar knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_templar.dmi'

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -25,
		HEAT = -25,
		HOLY = 50,
		DARK = -100
	)

	value = 110

/obj/item/clothing/head/helmet/knight/battlemage
	name = "battlemage helmet"
	icon = 'icons/obj/item/clothing/hats/knight_battlemage.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		ARCANE = 25,
		HOLY = -50,
		DARK = -50
	)

	size = SIZE_4


	value = 300