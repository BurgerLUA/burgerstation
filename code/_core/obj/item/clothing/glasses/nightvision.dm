/obj/item/clothing/glasses/nightvision
	name = "nightvision goggles"
	rarity = RARITY_RARE
	desc = "Kept you waiting, huh?"
	desc_extended = "A pair of tactical nightvision goggles. Keep away from light."
	icon = 'icons/obj/item/clothing/glasses/nightvision.dmi'

	defense_rating = list(
		LASER = -50,
		ARCANE = -50,
		HOLY = -50
	)

	value = 25


/obj/item/clothing/glasses/nightvision/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(is_inventory(old_location))
		var/obj/hud/inventory/I = old_location
		I.owner.remove_color_mod("eyes")

	if(new_location.item_slot & SLOT_EYES)
		var/list/desired_color = list(
			1.5,2,0,0,
			0,2.5,0,0,
			0,2,1.5,0,
			0,0,0,1,
			0,0,0,0
		)
		new_location.owner.add_color_mod("eyes",desired_color)

	return .