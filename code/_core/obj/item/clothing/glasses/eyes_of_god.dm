/obj/item/clothing/glasses/eyes_of_god
	name = "eyes of god"
	rarity = RARITY_LEGENDARY
	desc = "Wear them, if you dare."
	desc_extended = "A pair of eyeballs that let you see how the gods see things. You may lose your sanity."
	icon = 'icons/obj/item/clothing/glasses/eyes_of_god.dmi'

	vision_mod = FLAG_VISION_SECURITY

	value = 5000

	vision_mod = FLAG_VISION_ALL
	sight_mod = SEE_TURFS | SEE_MOBS | SEE_OBJS | SEE_THRU
	see_invisible = INVISIBILITY_ALL


/obj/item/clothing/glasses/eyes_of_god/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(is_inventory(old_location))
		var/obj/hud/inventory/I = old_location
		I.owner.remove_color_mod("eyes")

	if(new_location.item_slot & SLOT_EYES)
		var/list/desired_color = list(
			2,0,0,0,
			0,2,0,0,
			0,0,2,0,
			0,0,0,0.5,
			0,0,0,0
		)
		new_location.owner.add_color_mod("eyes",desired_color)

	return .