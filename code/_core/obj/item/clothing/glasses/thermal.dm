/obj/item/clothing/glasses/thermal
	name = "thermal goggles"
	desc = "Wallhacks that fit on your face!"
	desc_extended = "Some magical goggles that allow you to see mobs through walls."
	icon = 'icons/obj/item/clothing/glasses/thermal.dmi'
	rarity = RARITY_RARE

	defense_rating = list(,
		ARCANE = -AP_SWORD
	)

	size = SIZE_1

	sight_mod = SEE_MOBS

	value = 400


/obj/item/clothing/glasses/thermal/thermoncle
	name = "thermoncle"
	desc = "Wallhacks that fit on your eye!"
	desc_extended = "A magical thermoncle that allow you to see mobs through walls."
	icon = 'icons/obj/item/clothing/glasses/thermoncle.dmi'

/obj/item/clothing/glasses/thermal/thermal_rev
	name = "OUTAD thermonocular"
	desc = "Bravo six, going wallhack."
	desc_extended = "Slav-Safe's built-in thermal imagery/night vision monocle, fitted with an additional medical and security HUDs. Theoretically shouldn't be detachable in any way possible."
	icon = 'icons/obj/item/clothing/glasses/thermal_rev.dmi'

	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL
	see_in_dark = VIEW_RANGE + ZOOM_RANGE

	value = 1000