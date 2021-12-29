/obj/item/bullet_cartridge/shotgun_20/
	name = "\improper 20 gauge buckshot shell"
	desc = "Shoots a lot of small bullets at once."
	desc_extended = "This shell is not very accurate and has many projectiles."
	icon = 'icons/obj/item/bullet/shotgun_20.dmi'
	icon_state = "buckshot"

	projectile_count = 5
	base_spread = 0.03

	bullet_diameter = 17.5
	bullet_length = 17.5

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_20

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 1.6

	inaccuracy_modifer = 1.25

	item_count_max = 5
	item_count_max_icon = 5

/obj/item/bullet_cartridge/shotgun_20/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	return TRUE

/obj/item/bullet_cartridge/shotgun_20/Generate()
	item_count_current = item_count_max
	return ..()

/obj/item/bullet_cartridge/shotgun_20/slug
	name = "\improper 20 gauge slug"
	rarity = RARITY_UNCOMMON
	desc = "Shoots one really big bullet."
	desc_extended = "This shell doesn't spread alot, and only has one projectile."
	icon_state = "slug"

	projectile_count = 1
	base_spread = 0

	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_20/slug

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04
	value = 1.8

/obj/item/bullet_cartridge/shotgun_20/slug/surplus
	name = "\improper surplus 20 gauge slug"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/slug/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/shotgun_20/surplus
	name = "\improper surplus 20 gauge slug"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_20/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/shotgun_20/cursed
	name = "\improper 20 gauge curse shell"
	desc = "Shoots a lot of small magic circles at once."
	desc_extended = "This shell is covered in mysterious runes, and smells like the ocean???"
	icon_state = "buckshot"

	bullet_diameter = 17.5
	bullet_length = 16.66

	projectile_count = 7
	base_spread = 0.03

	projectile = /obj/projectile/magic/chaos
	damage_type_bullet = /damagetype/ranged/magic/chaos

	projectile_speed = TILE_SIZE*0.2 - 1

	size = 0.04
	value = 1.6

	inaccuracy_modifer = 1.25
