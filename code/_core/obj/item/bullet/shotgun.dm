/obj/item/bullet_cartridge/shotgun/
	id = "shotgun"
	icon = 'icons/obj/items/bullet/shotgun.dmi'
	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 18.5
	bullet_length = 18.5

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	weight = 0.04
	value = 0.6

/obj/item/bullet_cartridge/shotgun/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/bullet_cartridge/shotgun/on_spawn()
	item_count_current = 5
	return ..()

/obj/item/bullet_cartridge/shotgun/slug
	name = "\improper 12 gauge slug"
	desc = "A slug shell, load it into a shotgun to use."
	desc_extended = "This shell doesn't spread alot, and only has one projectile."
	icon_state = "slug"

	projectile_count = 1
	base_spread = 0
	projectile_speed = 31


	projectile = /obj/projectile/bullet/shotgun_slug

	damage_type = "12_slug"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04
	weight = 0.04
	value = 0.6

/obj/item/bullet_cartridge/shotgun/buckshot
	name = "\improper 12 gauge buckshot shell"
	desc = "A buckshot shell, load it into a shotgun to use."
	desc_extended = "This shell is not very accurate and has many projectiles."
	icon_state = "buckshot"

	projectile_count = 8
	base_spread = 0.03

	projectile = /obj/projectile/bullet/shotgun_pellet

	damage_type = "12_buckshot"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	weight = 0.04
	value = 0.6


/obj/item/bullet_cartridge/shotgun/rubber_balls
	name = "\improper 12 gauge rubber balls"
	desc = "A rubber shot shell, load it into a shotgun to use."
	desc = "This shell has many rubber balls in it to cause pain but not major injury"
	icon_state = "rubber"

	projectile_count = 8
	base_spread = 0.15

	projectile = /obj/projectile/bullet/shotgun_pellet

	damage_type = "12_rubber"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	weight = 0.04

	value = 6

