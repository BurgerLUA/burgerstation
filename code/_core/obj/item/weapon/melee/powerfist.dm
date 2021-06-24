/obj/item/weapon/melee/powerfist

	name = "powerfist"
	desc = "What you've always wanted."
	desc_extended = "A bulky glove attached to a massive hydraulic press. What could possibly go wrong?"

	icon = 'icons/obj/item/weapons/unarmed/powerfist.dmi'

	damage_type = /damagetype/unarmed/powerfist

	size = SIZE_2
	weight = 10

	value = 400

/obj/item/weapon/melee/powerfist/update_icon()

	. = ..()

	if(is_inventory(loc))
		var/obj/hud/inventory/I = loc
		if(I.click_flags & LEFT_HAND)
			icon_state = "inventory_left"
		else
			icon_state = "inventory_right"