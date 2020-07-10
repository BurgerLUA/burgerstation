/obj/item/bullet_cartridge/sniper_50/
	name = "\improper .50 sniper round"
	desc = "For when you want to shoot something so hard it's family will feel it too."
	desc_extended = "For sniper rifles that require .50 ammo."
	rarity = RARITY_RARE
	id = ".50"
	icon = 'icons/obj/item/bullet/50.dmi'


	bullet_diameter = 12.7
	bullet_length = 99
	bullet_color = COLOR_BULLET

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/sniper
	damage_type_bullet = /damagetype/ranged/bullet/sniper_50

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.1
	weight = 0.1
	value = 12

/obj/item/bullet_cartridge/rifle_939mm
	name = "\improper 9x39mm rifle bullet"
	desc = "Be vewy, vewy quiet."
	desc_extended = "For rifles that require 9x39mm."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/223.dmi'


	bullet_diameter = 9
	bullet_length = 39
	bullet_color = COLOR_BULLET

	item_count_max = 5
	item_count_max_icon = 5
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_939mm

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	size = 0.04
	weight = 0.04

	value = 1.8

	inaccuracy_modifer = 0.75

/obj/item/bullet_cartridge/rifle_939mm/Generate()
	item_count_current = 5
	return ..()
