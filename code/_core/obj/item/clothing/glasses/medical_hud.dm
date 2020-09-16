/obj/item/clothing/glasses/medical_hud
	name = "medical hud"
	rarity = RARITY_UNCOMMON
	desc = "This is just like a videogame!"
	desc_extended = "A medical heads up display eyepiece that analyzes the health of nearby living beings and displays them on the screen."
	icon = 'icons/obj/item/clothing/glasses/medical_hud.dmi'

	vision_mod = FLAG_VISION_MEDICAL

	value = 120

	defense_rating = list(
		ARCANE = -25,
	)

/obj/item/clothing/glasses/medical_hud/advanced
	name = "advanced medical hud"
	rarity = RARITY_UNCOMMON
	desc = "This is just like a videogame!"
	desc_extended = "A medical heads up display eyepiece that analyzes the health of nearby living beings and displays them on the screen. This one also displays the type of injury, if any."
	icon = 'icons/obj/item/clothing/glasses/medical_hud.dmi'
	vision_mod = FLAG_VISION_MEDICAL | FLAG_VISION_MEDICAL_ADVANCED

	value = 200

	defense_rating = list(
		ARCANE = -50,
	)

/obj/item/clothing/glasses/security_hud
	name = "security hud"
	rarity = RARITY_UNCOMMON
	desc = "This is just like a videogame!"
	desc_extended = "A security heads up display sunglass kit that analyzes the IFF implant of nearby living beings and displays them on the screen."
	icon = 'icons/obj/item/clothing/glasses/security_hud.dmi'

	vision_mod = FLAG_VISION_SECURITY

	value = 160

	defense_rating = list(
		ARCANE = -25,
	)

/obj/item/clothing/glasses/security_hud/red
	name = "security sensors suite"
	rarity = RARITY_MYTHICAL
	desc_extended = "A syndicate heads up display sunglass kit that analyzes the IFF implant of nearby living beings and displays them on the screen. This model is more advanced, and is usually found on high ranking syndicate operatives. Comes with build-in thermals as well."
	value = 1000

	defense_rating = list(
		BLUNT = 10,
		PIERCE = 10,
		BLADE = 10
	)

	sight_mod = SEE_MOBS
	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL