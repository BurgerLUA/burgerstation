/obj/item/bullet_cartridge/shotgun_23/
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/shotgun_23.dmi'
	item_count_max = 4
	item_count_max_icon = 4


	bullet_diameter = 23
	bullet_length = 75
	bullet_color = COLOR_BULLET

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 0.6

/obj/item/bullet_cartridge/shotgun_23/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	return TRUE

/obj/item/bullet_cartridge/shotgun_23/Generate()
	item_count_current = 4
	return ..()

/obj/item/bullet_cartridge/shotgun_23/slug
	name = "\improper 23x75mmR slug"
	desc = "This thing's huge!"
	desc_extended = "A shotgun slug designed specifically for the KS23"
	rarity = RARITY_RARE
	icon_state = "23slug"

	projectile_count = 1
	base_spread = 0.03

	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_23/slug

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04
	value = 4

/obj/item/bullet_cartridge/shotgun_23/buckshot
	name = "\improper 23x75mmR buckshot shell"
	desc = "Now with 50% more pellet per pellet"
	desc_extended = "A buckshot shell designed specifically for the KS23"
	rarity = RARITY_RARE
	icon_state = "23buck"

	projectile_count = 6
	base_spread = 0.06

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_23/buckshot

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 3.5

	inaccuracy_modifer = 1.5

/obj/item/bullet_cartridge/shotgun_23/fire
	name = "\improper 23x75mmR incendiary shell"
	desc = "I AM BURNING! I AM BURNING! I AM BURNING!"
	desc_extended = "An incendiary shell designed specifically for the KS23"
	rarity = RARITY_RARE
	icon_state = "23fire"

	projectile_count = 4
	base_spread = 0.12

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_23/fire


