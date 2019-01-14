/obj/item/weapon/melee/rock
	name = "a rock"
	desc = "So much religious significance."

	icon = 'icons/obj/items/weapons/melee/nature/rocks.dmi'
	icon_state = "inventory01"


	icon_state_worn = "worn"

	damage_type = /damagetype/sword/sabre

	item_slot = SLOT_GROIN
	worn_layer = LAYER_MOB_CLOTHING_BACK

/obj/item/weapon/melee/rock/New()
	. = ..()
	icon_state = pick("inventory0[rand(1,3)]")
	pixel_x = rand(-12,12)
	pixel_y = rand(-12,12)