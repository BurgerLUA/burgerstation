/obj/item/clothing/glasses/medical_hud
	name = "medical hud"
	rarity = RARITY_UNCOMMON
	desc = "This is just like a videogame!"
	desc_extended = "A medical heads up display eyepiece that analyzes the health of nearby living beings and displays them on the screen."
	icon = 'icons/obj/item/clothing/glasses/medical_hud.dmi'

	vision_mod = FLAG_VISION_MEDICAL

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 25
	)

	value = 10

/obj/item/clothing/glasses/medical_hud/advanced
	name = "advanced medical hud"
	rarity = RARITY_RARE
	desc = "This is just like a videogame!"
	desc_extended = "A medical heads up display eyepiece that analyzes the health of nearby living beings and displays them on the screen. This one also displays the type of injury, if any."
	icon = 'icons/obj/item/clothing/glasses/medical_hud.dmi'
	vision_mod = FLAG_VISION_MEDICAL | FLAG_VISION_MEDICAL_ADVANCED

	value = 30

/obj/item/clothing/glasses/security_hud
	name = "security hud"
	rarity = RARITY_RARE
	desc = "This is just like a videogame!"
	desc_extended = "A security heads up display sunglass kit that analyzes the IFF implant of nearby living beings and displays them on the screen."
	icon = 'icons/obj/item/clothing/glasses/security_hud.dmi'

	vision_mod = FLAG_VISION_SECURITY

	value = 10