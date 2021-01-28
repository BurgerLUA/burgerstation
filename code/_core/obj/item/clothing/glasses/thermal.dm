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

//Commented out 'till thermals are fixed.
//obj/item/clothing/glasses/thermal/rev
//	name = "OUTAD Thermonocle."
//	desc = "Bravo Six, going wallhack."
//	desc_extended = " Slav-Safe's in-built thermal imagery monocle. Theoretically shouldn't be detachable in any way possible."
//	icon = 'icons/obj/item/clothing/glasses/thermal_rev.dmi'
//	value = 1000

//	defense_rating = list(
//		BLUNT = AP_DAGGER,
//		PIERCE = AP_DAGGER,
//		BLADE = AP_DAGGER,
//		ARCANE = -AP_DAGGER
//	)
//
//	sight_mod = SEE_MOBS
//	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL
//	see_in_dark = VIEW_RANGE + ZOOM_RANGE