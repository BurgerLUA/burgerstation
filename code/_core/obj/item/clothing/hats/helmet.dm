/obj/item/clothing/head/helmet/
	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

/obj/item/clothing/head/helmet/knight/

	rarity = RARITY_UNCOMMON
	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		MAGIC = -50,
		HEAT = -50
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 160


/obj/item/clothing/head/helmet/knight/red
	name = "red knight helmet"
	icon = 'icons/obj/items/clothing/hats/knight_red.dmi'
	desc = "Deus Vult."
	desc_extended = "A knight's helmet. Made out of the finest metal."

/obj/item/clothing/head/helmet/knight/blue
	name = "blue knight helmet"
	icon = 'icons/obj/items/clothing/hats/knight_blue.dmi'

/obj/item/clothing/head/helmet/knight/green
	name = "green knight helmet"
	icon = 'icons/obj/items/clothing/hats/knight_green.dmi'

/obj/item/clothing/head/helmet/knight/yellow
	name = "yellow knight helmet"
	icon = 'icons/obj/items/clothing/hats/knight_yellow.dmi'

/obj/item/clothing/head/helmet/knight/templar
	name = "templar knight helmet"
	icon = 'icons/obj/items/clothing/hats/knight_templar.dmi'

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		MAGIC = -25,
		HEAT = -50,
		DARK = 75
	)

/obj/item/clothing/head/helmet/knight/battlemage
	name = "battlemage helmet"
	icon = 'icons/obj/items/clothing/hats/knight_battlemage.dmi'

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		MAGIC = 75,
		HEAT = -50
	)

	size = SIZE_4
	weight = WEIGHT_4

	value = 200