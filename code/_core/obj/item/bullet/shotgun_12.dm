/obj/item/bullet_cartridge/shotgun_12/
	name = "\improper 12 gauge buckshot shell"
	desc = "Shoots a lot of small bullets at once."
	desc_extended = "This shell is not very accurate and has many projectiles."
	icon = 'icons/obj/item/bullet/shotgun.dmi'
	icon_state = "buckshot"

	projectile_count = 6
	base_spread = 0.03

	bullet_diameter = 18.5
	bullet_length = 76.2

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.04
	value = 1.6

	inaccuracy_modifier = 1.25

	amount_max = 5
	amount_max_icon = 5

	view_punch_mod = 0.5

	value = 1 //Dummy value.

/obj/item/bullet_cartridge/shotgun_12/get_value()
	. = ..()
	. *= 0.5

/obj/item/bullet_cartridge/shotgun_12/can_be_worn(mob/living/advanced/owner,obj/hud/inventory/I,messages=FALSE)
	return TRUE

/obj/item/bullet_cartridge/shotgun_12/slug
	name = "\improper 12 gauge slug"
	rarity = RARITY_UNCOMMON
	desc = "Shoots one really big bullet."
	desc_extended = "This shell doesn't spread alot, and only has one projectile."
	icon_state = "slug"

	projectile_count = 1
	base_spread = 0

	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/slug

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04

/obj/item/bullet_cartridge/shotgun_12/slug/surplus
	name = "\improper surplus 12 gauge slug"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/slug/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/shotgun_12/slug/cleaning
	name = "\improper 12 gauge cleaning slug"
	rarity = RARITY_UNCOMMON
	desc = "Shoots one really big bullet."
	desc_extended = "This shell doesn't spread alot, and only has one projectile that also CLEANS."
	icon_state = "oldrubber"

	projectile_count = 1
	base_spread = 0

	projectile = /obj/projectile/bullet/cleaning_shot
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/slug/cleaning

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.04

	caseless = TRUE


/obj/item/bullet_cartridge/shotgun_12/surplus
	name = "\improper surplus 12 gauge buckshot"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/surplus
	jam_chance = 1
	value = 0
	rarity = RARITY_BROKEN

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

	inaccuracy_modifier = 1


/obj/item/bullet_cartridge/shotgun_12/flechette
	name = "\improper 12 gauge flechette shell"
	rarity = RARITY_UNCOMMON
	desc = "Shoots a lot of small shards at once."
	desc_extended = "This shell is not very accurate and has many projectiles. Lower damage but pierces armor better."
	icon_state = "flechette"

	projectile_count = 5
	base_spread = 0.025

	projectile = /obj/projectile/bullet/firearm/shotgun_flechette
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/flechette

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.04

	inaccuracy_modifier = 1.1

	penetrations = 1

/obj/item/bullet_cartridge/shotgun_12/flechette/surplus
	name = "\improper surplus 12 gauge flechette"
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/flechette/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/shotgun_12/rubber // yes i literally just copied the ks-23's rubber slugs shut up
	name = "\improper 12 gauge rubber slug shell"
	desc = "Because real men use the concussive force of a huge fucking piece of rubber."
	desc_extended = "A rubber slug shell, supposedly less lethal. Causes a lot of pain, but not much damage."
	rarity = RARITY_UNCOMMON
	icon_state = "rubber"

	projectile_count = 1
	base_spread = 0.03

	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/rubber_slug



/obj/item/bullet_cartridge/shotgun_12/frag
	name = "\improper 12 gauge frag"
	rarity = RARITY_RARE
	desc = "Shoots one really big bullet."
	desc_extended = "This shell doesn't spread alot, and only has one projectile."
	icon_state = "slug"

	projectile_count = 1
	base_spread = 0

	projectile = /obj/projectile/bullet/firearm/shotgun_slug
	damage_type_bullet = /damagetype/ranged/bullet/shotgun_12/frag

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.04


/obj/item/bullet_cartridge/shotgun_12/techshot
	name = "\improper 12 gauge techshot"
	rarity = RARITY_RARE
	desc = "Shoots one really big bullet."
	desc_extended = "Shoots a focused laser."
	icon_state = "techshot"

	projectile_count = 1
	base_spread = 0

	projectile = /obj/projectile/bullet/laser/plasma_cutter
	damage_type_bullet = /damagetype/ranged/laser/pulse

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.04