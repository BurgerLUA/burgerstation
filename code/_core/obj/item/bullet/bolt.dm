/obj/item/bullet/bolt
	name = "crossbow bolt"
	desc = "A crudely designed bolt meant for crossbows."
	icon = 'icons/obj/items/bullet/bolt.dmi'
	item_count_max = 6
	item_count_max_icon = 6
	icon_state = "bolt"

	id = "bolt"
	bullet_length = -1
	bullet_diameter = -1

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

	projectile = /obj/projectile/bullet/bolt
	damage_type = "bolt_metal"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.5
	weight = 1

	value = 3

/obj/item/bullet/bolt/on_spawn()
	item_count_current = 3
	return ..()

/obj/item/bullet/bolt/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE