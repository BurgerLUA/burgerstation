/obj/item/bullet_cartridge/shotgun_20/
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/shotgun_20.dmi'
	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 17.5
	bullet_length = 17.5
	bullet_color = COLOR_BULLET

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 2

/obj/item/bullet_cartridge/shotgun_20/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	return TRUE

/obj/item/bullet_cartridge/shotgun_20/Generate()
	item_count_current = 5
	return ..()

/obj/item/bullet_cartridge/shotgun_20/slug
	name = "\improper 20 gauge slug"
	desc = "Shoots one really big bullet."
	desc_extended = "This shell doesn't spread alot, and only has one projectile."
	icon_state = "slug"

	projectile_count = 1
	base_spread = 0

	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/slug

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04
	value = 1.8

/obj/item/bullet_cartridge/shotgun_20/buckshot
	name = "\improper 20 gauge buckshot shell"
	desc = "Shoots a lot of small bullets at once."
	desc_extended = "This shell is not very accurate and has many projectiles."
	icon_state = "buckshot"

	projectile_count = 5
	base_spread = 0.03

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/buckshot

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 1.6

	inaccuracy_modifer = 1.5

