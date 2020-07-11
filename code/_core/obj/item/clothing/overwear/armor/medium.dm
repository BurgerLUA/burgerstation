/obj/item/clothing/overwear/armor/medium_armor
	name = "medium armor"
	desc = "9/10, it's ok."
	desc_extended = "A very cheap armor. Not very effective, but better than nothing."
	icon = 'icons/obj/item/clothing/suit/medium_chest_armor.dmi'

	value = 30

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE

/obj/item/clothing/overwear/armor/medium_armor/leather
	name = "medium leather armor"
	desc = "This is medieval, right?"
	desc_extended = "A suit of leather armor. Often seeing at renessaince faires, despite the fact medieval soldiers wore wool gambesons."
	color = "#8C4438"

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		COLD = 25
	)

	size = SIZE_4


	value = 30

	dyeable = TRUE

/obj/item/clothing/overwear/armor/medium_armor/security
	name = "padded kevlar security armor"
	desc = "Morning, Mr. Freeman. Looks like you're running late."
	desc_extended = "Standard-issue armor of the Nanotrasen security force. Bulky, but also better than nothing."
	color = COLOR_BLACK

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 50,
		MAGIC = -50,
		COLD = 15
	)

	size = SIZE_4


	value = 50