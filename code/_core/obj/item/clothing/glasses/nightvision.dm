/obj/item/clothing/glasses/nightvision
	name = "nightvision goggles"
	rarity = RARITY_RARE
	desc = "Kept you waiting, huh?"
	desc_extended = "A pair of tactical nightvision goggles. Keep away from light."
	icon = 'icons/obj/item/clothing/glasses/nightvision.dmi'

	see_in_dark = VIEW_RANGE + ZOOM_RANGE

	defense_rating = list(
		LASER = -AP_CLUB,
		ARCANE = -AP_CLUB,
		HOLY = -AP_CLUB
	)

	value = 100


/obj/item/clothing/glasses/nightvision/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

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