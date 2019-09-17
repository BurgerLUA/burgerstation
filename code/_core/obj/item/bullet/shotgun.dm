/obj/item/bullet/shotgun/
	id = "shotgun"
	icon = 'icons/obj/items/bullet/shotgun.dmi'
	item_count_max = 6
	item_count_max_icon = 6

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

/obj/item/bullet/shotgun/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/bullet/shotgun/on_spawn()
	item_count_current = 6

/obj/item/bullet/shotgun/slug
	name = "\improper 12 gauge slug"
	desc = ""
	icon_state = "slug"

	projectile_count = 1
	base_spread = 0
	bullet_speed = 31


	projectile = /obj/projectile/bullet/shotgun_slug

	damage_type = "12_slug"

/obj/item/bullet/shotgun/buckshot
	name = "\improper 12 gauge buckshot shell"
	desc = ""
	icon_state = "buckshot"

	projectile_count = 8
	base_spread = 0.1
	bullet_speed = 16

	projectile = /obj/projectile/bullet/shotgun_pellet

	damage_type = "12_buckshot"