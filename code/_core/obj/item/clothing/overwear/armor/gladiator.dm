/obj/item/clothing/overwear/armor/gladiator
	name = "gladiator armor"
	desc = "Look mom, i'm a real gladiator!"
	desc_extended = "A replica Gladiator Armor. Won't protect you from anything, but it looks cool."
	icon = 'icons/obj/item/clothing/suit/gladiator.dmi'
	rarity = RARITY_UNCOMMON

	value = 40

	dyeable = TRUE

/obj/item/clothing/overwear/armor/gladiator/brass
	name = "bronze gladiator armor"
	desc = "It belongs in a museum!"
	desc_extended = "A set of real bronze Gladiator Armor. Weaker than modern armor, but much cooler."
	color = "#B7A33E"

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -75
	)

	size = SIZE_5

