obj/item/weapon/unarmed/brass_knuckles

	name = "brass knuckles"
	desc = "Cheat at unarmed combat."
	desc_extended = "A large piece of brass molded to fit around your fist. Delivers an extra punch when attacking, but makes you less agile."

	icon = 'icons/obj/item/weapons/unarmed/brass_knuckles.dmi'

	damage_type = /damagetype/unarmed/brass

	size = SIZE_1
	weight = 4

	value = 100

obj/item/weapon/unarmed/brass_knuckles/update_icon()

	. = ..()

	if(is_inventory(loc))
		var/obj/hud/inventory/I = loc
		if(I.click_flags & LEFT_HAND)
			icon_state = "inventory_left"
		else
			icon_state = "inventory_right"



obj/item/weapon/unarmed/brass_knuckles/mod
	name = "spiked knuckles"
	desc = "Cheat at unarmed combat."
	desc_extended = "A large piece of brass molded to fit around your fist. Delivers an extra punch when attacking, but makes you less agile. This one is spiked, and is especially deadly."

	icon = 'icons/obj/item/weapons/unarmed/spiked_knuckles.dmi'

	damage_type = /damagetype/unarmed/brass/spiked

	size = SIZE_1
	weight = 6

	value = 100