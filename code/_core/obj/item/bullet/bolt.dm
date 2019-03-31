/obj/item/bullet/bolt
	name = "crossbow bolt"
	desc = "A crudely designed bolt meant for crossbows."
	id = "bolt"
	icon = 'icons/obj/items/bullet/bolt.dmi'
	bullet_capacity = 6
	bullet_capacity_icon = 6
	icon_state = "bolt"

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

	projectile = /obj/projectile/bullet/bolt/
	damage_type = "bolt_metal"

/obj/item/bullet/bolt/on_spawn()
	bullet_count = 3
	update_icon()


/obj/item/bullet/bolt/can_be_worn()
	return TRUE