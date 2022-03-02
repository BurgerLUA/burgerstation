/obj/item/clothing/glasses/sun
	name = "sunglasses"

	desc = "Deal with it."
	desc_extended = "A simple pair of sleek sunglasses designed to reflect sunlight, and lasers. The inverse of prescription glasses."
	icon = 'icons/obj/item/clothing/glasses/sunglasses.dmi'

	armor = /armor/glasses/sunglasses

	value = 30

	item_slot_layer = 2

/obj/item/clothing/glasses/sun/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(is_inventory(old_location))
		var/obj/hud/inventory/I = old_location
		I.owner?.remove_color_mod("eyes")

	if(new_location.item_slot & SLOT_FACE)
		var/list/desired_color = list(
			0.9,0,0,0,
			0,0.9,0,0,
			0,0,0.9,0,
			0,0,0,1,
			0,0,0,0
		)
		new_location.owner.add_color_mod("eyes",desired_color)


/obj/item/clothing/glasses/sun/big
	name = "big shades"
	icon = 'icons/obj/item/clothing/glasses/sunglasses_big.dmi'

/obj/item/clothing/glasses/sun/gar
	name = "gar shades"
	icon = 'icons/obj/item/clothing/glasses/gar.dmi'

	damage_type = /damagetype/melee/sword/grazer

	value = 1000

	worn_layer = LAYER_MOB_HAIR_ABOVE

/obj/item/clothing/glasses/sun/gar/giga
	name = "gigagar shades"
	icon = 'icons/obj/item/clothing/glasses/gigagar.dmi'
	damage_type = /damagetype/melee/sword/katana

	value = 2500

/obj/item/clothing/glasses/sun/augmented
	name = "augmented shades"
	desc = "Your vision is augmented."
	desc_extended = "Powerful augmented shades meant for security personel. These come with a built in security HUD as well as thermal imaging. For the badass."
	icon = 'icons/obj/item/clothing/glasses/abomb_shades.dmi'

	sight_mod = SEE_MOBS
	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL

	armor = /armor/mechanical

	value = 1400


/obj/item/clothing/glasses/sun/security
	name = "security sunglasses"

	desc = "This is just like a videogame!"
	desc_extended = "A security heads up display sunglass kit that analyzes the IFF implant of nearby living beings and displays them on the screen."
	icon = 'icons/obj/item/clothing/glasses/security_hud.dmi'

	vision_mod = FLAG_VISION_SECURITY

	armor = /armor/mechanical

	value = 160

/obj/item/clothing/glasses/sun/security/red
	name = "combat sensors suite sunglasses"

	desc_extended = "A syndicate heads up display sunglass kit that analyzes the IFF implant of nearby living beings and displays them on the screen. This model is more advanced, and is usually found on high ranking syndicate operatives. Comes with built-in thermals as well."
	value = 1000

	armor = /armor/mechanical

	sight_mod = SEE_MOBS
	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL

/obj/item/clothing/glasses/sun/security/revolutionary
	name = "ballistic goggles"

	desc_extended = "An old yet well-maintained pair of ballistic goggles with a built-in heads up display kit that analyzes the IFF implant of nearby living beings and displays them on the screen. This model is more advanced, and is usually found on high ranking revolutionary soldiers. Comes with built-in thermals as well."
	icon = 'icons/obj/item/clothing/glasses/rev_goggles.dmi'
	value = 1000


	armor = /armor/mechanical

	sight_mod = SEE_MOBS
	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL