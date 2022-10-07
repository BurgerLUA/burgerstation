/obj/item/clothing/glasses/medical_hud
	name = "medical hud"

	desc = "This is just like a videogame!"
	desc_extended = "A medical heads up display eyepiece that analyzes the health of nearby living beings and displays them on the screen."
	icon = 'icons/obj/item/clothing/glasses/medical_hud.dmi'

	vision_mod = FLAG_VISION_MEDICAL

	value = 120

	armor = /armor/mechanical

	item_slot_layer = 2

	mob_values_add = list(
		SKILL_MEDICINE = 3
	)


/obj/item/clothing/glasses/medical_hud/advanced
	name = "advanced medical hud"

	desc = "This is just like a videogame!"
	desc_extended = "A medical heads up display eyepiece that analyzes the health of nearby living beings and displays them on the screen. This one also displays the type of injury, if any."
	icon = 'icons/obj/item/clothing/glasses/medical_hud.dmi'
	vision_mod = FLAG_VISION_MEDICAL | FLAG_VISION_MEDICAL_ADVANCED

	value = 200

	mob_values_add = list(
		SKILL_MEDICINE = 5
	)