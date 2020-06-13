/obj/item/bullet_cartridge/shotgun/
	id = "shotgun"
	icon = 'icons/obj/items/bullet/shotgun.dmi'
	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 18.5
	bullet_length = 18.5
	bullet_color = COLOR_BULLET

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	weight = 0.04
	value = 0.6

/obj/item/bullet_cartridge/shotgun/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/bullet_cartridge/shotgun/Generate()
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


	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/slug

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

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/buckshot

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	weight = 0.04
	value = 0.6

	inaccuracy_modifer = 1.5