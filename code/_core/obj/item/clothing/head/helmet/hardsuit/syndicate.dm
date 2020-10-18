/obj/item/clothing/head/helmet/hardsuit/syndie
	name = "mauler helmet mk1"
	desc = "GET DAT FUKKEN DISK!"
	desc_extended = "The first model of mauler hardsuit, and a common sight during the Nuclear Operatives era. Today it's mostly surplus worn by Syndicate grunts."
	icon = 'icons/obj/item/clothing/hats/syndie_basic.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 75,
		ARCANE = -75,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 50,
		RAD = 50
	)

	size = SIZE_4

	slowdown_mul_worn = 1.05

/obj/item/clothing/head/helmet/hardsuit/syndie/advanced
	name = "mauler helmet mk2"
	desc = "Perimeter Secured."
	desc_extended = "The current model in service by medium to high level Syndicate operatives. People wearing this are not to be treated lightly."
	icon = 'icons/obj/item/clothing/hats/syndie_advanced.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		ARCANE = -75,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 50,
		RAD = 50
	)

	size = SIZE_3

	slowdown_mul_worn = 1.1

/obj/item/clothing/head/helmet/hardsuit/syndie/elite
	name = "mauler helmet mk3"
	desc = "May I make a suggestion? Run."
	desc_extended = "A prototype suit in use by the best of the best of Syndicate Operatives. Lightweight and agile but still heavily armored. Don't attempt to face someone wearing this alone."
	icon = 'icons/obj/item/clothing/hats/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 75,
		ARCANE = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 50,
		RAD = 50
	)

	size = SIZE_3

	slowdown_mul_worn = 0.75