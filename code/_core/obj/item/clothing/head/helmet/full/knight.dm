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
		BLADE = AP_CLUB,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		HEAT = -AP_AXE,
		ARCANE = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_3

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE | SLOT_EYES

/obj/item/clothing/head/helmet/knight/red
	name = "red knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_red.dmi'
	desc = "Deus Vult."
	desc_extended = "A knight's helmet. Made out of the finest metal."

	value = 160

/obj/item/clothing/head/helmet/knight/blue
	name = "blue knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_blue.dmi'

	value = 160

/obj/item/clothing/head/helmet/knight/green
	name = "green knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_green.dmi'

	value = 160

/obj/item/clothing/head/helmet/knight/yellow
	name = "yellow knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_yellow.dmi'

	value = 160

/obj/item/clothing/head/helmet/knight/templar
	name = "templar knight helmet"
	icon = 'icons/obj/item/clothing/hats/knight_templar.dmi'

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		HEAT = -AP_AXE,
		ARCANE = -AP_CLUB,
		HOLY = AP_CLUB,
		PAIN = AP_CLUB
	)

	value = 110

/obj/item/clothing/head/helmet/knight/battlemage
	name = "battlemage helmet"
	icon = 'icons/obj/item/clothing/hats/knight_battlemage.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_SWORD,
		HEAT = -AP_SWORD,
		ARCANE = AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_4


	value = 300

/obj/item/clothing/head/helmet/knight/clockwork
	name = "clockwork helmet"
	icon = 'icons/obj/item/clothing/hats/clockwork.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = -AP_CLUB,
		ARCANE = AP_CLUB,
		HEAT = -AP_AXE
	)

	value = 500

	size = SIZE_2
