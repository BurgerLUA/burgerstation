obj/item/weapon/unarmed/holy
	name = "blessed knuckles"
	desc = "It is God who guides my hand."
	desc_extended = "A large piece of gold-plated steel molded to fit around your fist. Consecrates your foe when attacking, but makes you less agile. Blessed by the Space Pope."

	icon = 'icons/obj/item/weapons/unarmed/holy_knuckle.dmi'

	damage_type = /damagetype/unarmed/holy

	size = SIZE_1
	weight = 5

	value = 1000

obj/item/weapon/unarmed/holy/update_icon()

	. = ..()

	if(is_inventory(loc))
		var/obj/hud/inventory/I = loc
		if(I.click_flags & LEFT_HAND)
			icon_state = "inventory_left"
		else
			icon_state = "inventory_right"


obj/item/weapon/unarmed/holy/spiked
	name = "cursed knuckles"
	desc = "It is Nar'sie who guides my hand."
	desc_extended = "A large piece of cursed steel molded to fit around your fist. Curses your foe when attacking, but makes you less agile. Cursed by Nar'sie himself!"

	icon = 'icons/obj/item/weapons/unarmed/dark_knuckle.dmi'

	damage_type = /damagetype/unarmed/holy/spiked

	size = SIZE_1
	weight = 5

	value = 1000