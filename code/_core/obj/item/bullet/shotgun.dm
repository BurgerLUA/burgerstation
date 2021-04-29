/obj/item/bullet_cartridge/shotgun_12/
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/shotgun.dmi'
	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 18.5
	bullet_length = 18.5
	bullet_color = COLOR_BULLET

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 2

/obj/item/bullet_cartridge/shotgun_12/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	return TRUE

/obj/item/bullet_cartridge/shotgun_12/Generate()
	item_count_current = 5
	return ..()

/obj/item/bullet_cartridge/shotgun_12/slug
	name = "\improper 12 gauge slug"
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

/obj/item/bullet_cartridge/shotgun_12/slug/surplus
	name = "\improper surplus 12 gauge slug"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/slug/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/shotgun_12/buckshot
	name = "\improper 12 gauge buckshot shell"
	desc = "Shoots a lot of small bullets at once."
	desc_extended = "This shell is not very accurate and has many projectiles."
	icon_state = "buckshot"

	projectile_count = 6
	base_spread = 0.03

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/buckshot

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 1.6

	inaccuracy_modifer = 1.25

/obj/item/bullet_cartridge/shotgun_12/buckshot/surplus
	name = "\improper surplus 12 gauge buckshot"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/buckshot/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/shotgun_12/fire
	name = "\improper 12 gauge drake breath shell"
	desc = "Sets everything on fire."
	desc_extended = "A magic imbued shotgun shell that shoots 3 high damaging incendiary rounds. Don't ask how it works."
	icon_state = "fire"
	rarity = RARITY_RARE

	projectile_count = 3
	base_spread = 0.01

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/magic/fireball

	projectile_speed = 8

	size = 0.04
	value = 5

	inaccuracy_modifer = 1


/obj/item/bullet_cartridge/shotgun_12/flechette
	name = "\improper 12 gauge flechette shell"
	desc = "Shoots a lot of small shards at once."
	desc_extended = "This shell is not very accurate and has many projectiles. Lower damage but pierces armor better."
	icon_state = "flechette"

	projectile_count = 5
	base_spread = 0.025

	projectile = /obj/projectile/bullet/firearm/shotgun_flechette
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/flechette

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04
	value = 1.8

	inaccuracy_modifer = 1.1

	penetrations = 1

/obj/item/bullet_cartridge/shotgun_12/flechette/surplus
	name = "\improper surplus 12 gauge flechette"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun/flechette/surplus
	jam_chance = 1
	value = 0

