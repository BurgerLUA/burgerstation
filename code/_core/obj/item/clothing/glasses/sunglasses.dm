/obj/item/clothing/glasses/sun
	name = "sunglasses"
	rarity = RARITY_UNCOMMON
	desc = "Deal with it."
	desc_extended = "A simple pair of sleek sunglasses designed to reflect sunlight, and lasers. The inverse of prescription glasses."
	icon = 'icons/obj/item/clothing/glasses/sunglasses.dmi'

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		LASER = AP_GREATSWORD,
		ARCANE = -AP_CLUB,
		HEAT = AP_SWORD
	)

	value = 30

/obj/item/clothing/glasses/sun/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(is_inventory(old_location))
		var/obj/hud/inventory/I = old_location
		I.owner.remove_color_mod("eyes")

	if(new_location.item_slot & SLOT_EYES)
		var/list/desired_color = list(
			0.9,0,0,0,
			0,0.9,0,0,
			0,0,0.9,0,
			0,0,0,1,
			0,0,0,0
		)
		new_location.owner.add_color_mod("eyes",desired_color)

	return .


/obj/item/clothing/glasses/sun/augmented
	name = "augmented shades"
	desc = "Your vision is augmented."
	desc_extended = "Powerful augmented shades meant for security personel. These come with a built in security HUD as well as thermal imaging. For the badass."
	icon = 'icons/obj/item/clothing/glasses/abomb_shades.dmi'
	rarity = RARITY_MYTHICAL
	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_CLUB,
		ARCANE = -AP_CLUB,
		HEAT = AP_SWORD,
		BOMB = -AP_GREATCLUB
	)

	sight_mod = SEE_MOBS
	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL

	value = 1400