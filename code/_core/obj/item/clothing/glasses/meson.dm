/obj/item/clothing/glasses/meson
	name = "meson goggles"
	desc = "MESON!"
	desc_extended = "Some almost magical goggles that allow you to see floors and walls through walls."
	icon = 'icons/obj/item/clothing/glasses/meson.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(,
		ARCANE = -AP_SWORD
	)

	size = SIZE_1

	sight_mod = SEE_TURFS

	value = 100

/obj/item/clothing/glasses/meson/night_vision
	name = "night vision meson goggles"
	desc = "MESON!"
	desc_extended = "Some almost magical goggles that allow you to see floors and walls through walls. This one can also see in the dark better."
	icon = 'icons/obj/item/clothing/glasses/meson_night_vision.dmi'
	rarity = RARITY_RARE

	see_in_dark = VIEW_RANGE + ZOOM_RANGE

	defense_rating = list(,
		ARCANE = -AP_SWORD
	)

	size = SIZE_1

	sight_mod = SEE_TURFS

	value = 200

/obj/item/clothing/glasses/meson/night_vision/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(is_inventory(old_location))
		var/obj/hud/inventory/I = old_location
		I.owner.remove_color_mod("\ref[src]")
		I.owner.remove_lighting_mod("\ref[src]")

	if(new_location.item_slot & SLOT_EYES)
		var/list/desired_color = list(
			1,1,0,0,
			0,1,0,0,
			0,1,1,0,
			0,0,0,1,
			0,0,0,0
		)
		new_location.owner.add_color_mod("\ref[src]",desired_color)
		new_location.owner.add_lighting_mod("\ref[src]",100)

	return .