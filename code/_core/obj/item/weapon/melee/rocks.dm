/obj/item/weapon/melee/rock
	name = "a rock"
	desc = "Wouldn't it be fucked up if there were two astronauts on the moon and one killed the other with a rock?."
	desc_extended = "Only an idiot or someone desperate would use this as a weapon, and if you have time to read this, chances are you aren't that desperate."

	icon = 'icons/obj/items/weapons/melee/nature/rocks.dmi'
	icon_state = "inventory01"


	icon_state_worn = "worn"

	damage_type = "rock"

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

/obj/item/weapon/melee/rock/New()
	. = ..()
	icon_state = pick("inventory0[rand(1,3)]")
	pixel_x = rand(-12,12)
	pixel_y = rand(-12,12)