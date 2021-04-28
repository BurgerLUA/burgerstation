/obj/item/clothing/overwear/hardsuit/syndie
	name = "mauler hardsuit mk1"
	desc = "GET DAT FUKKEN DISK!"
	desc_extended = "The first model of mauler hardsuit, and a common sight during the Nuclear Operatives era. Today it's mostly surplus worn by Syndicate grunts."
	icon = 'icons/obj/item/clothing/suit/syndie_basic.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -40,
		HEAT = 40,
		COLD = 40,
		BOMB = 40,
		BIO = 20,
		RAD = 20,
		PAIN = 60
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie)

	value = 400

	loyalty_tag = "Syndicate"

/obj/item/clothing/overwear/hardsuit/syndie/advanced
	name = "mauler hardsuit mk2"
	desc = "Perimeter Secured."
	desc_extended = "The current model in service by medium to high level Syndicate operatives. People wearing this are not to be treated lightly."
	icon = 'icons/obj/item/clothing/suit/syndie_advanced.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 40,
		BLUNT = 60,
		PIERCE = 60,
		LASER = 60,
		ARCANE = -60,
		HEAT = 40,
		COLD = 40,
		BOMB = 40,
		BIO = 20,
		RAD = 20,
		PAIN = 60
	)

	size = SIZE_6


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie/advanced)

	value = 600

/obj/item/clothing/overwear/hardsuit/syndie/elite
	name = "mauler hardsuit mk3"
	desc = "May I make a suggestion? Run."
	desc_extended = "A prototype suit in use by the best of the best of Syndicate Operatives. Lightweight and agile but still heavily armored. Don't attempt to face someone wearing this alone."
	icon = 'icons/obj/item/clothing/suit/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 60,
		ARCANE = -60,
		HEAT = 40,
		COLD = 40,
		BOMB = 40,
		BIO = 20,
		RAD = 20,
		PAIN = 60
	)

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/syndie/elite)

	size = SIZE_6

	value = 1200

	speed_bonus = 0.1