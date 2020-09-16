/obj/item/bullet_cartridge/sniper_50/
	name = "\improper .50 sniper round"
	desc = "For when you want to shoot something so hard it's family will feel it too."
	desc_extended = "For sniper rifles that require .50 ammo."
	rarity = RARITY_RARE
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
	value = 12

/obj/item/bullet_cartridge/sniper_50/explosive
	name = "\improper .50 explosive sniper round"
	icon = 'icons/obj/item/bullet/50_explosive.dmi'
	rarity = RARITY_MYTHICAL
	damage_type_bullet = /damagetype/ranged/bullet/sniper_50/explosive
	value = 20

/obj/item/bullet_cartridge/sniper_50/ion
	name = "\improper .50 ion sniper round"
	icon = 'icons/obj/item/bullet/50_ion.dmi'
	rarity = RARITY_MYTHICAL
	damage_type_bullet = /damagetype/ranged/bullet/sniper_50/ion
	value = 80

/obj/item/bullet_cartridge/sniper_50/incendiary
	name = "\improper .50 incendiary sniper round"
	icon = 'icons/obj/item/bullet/50_incendiary.dmi'
	rarity = RARITY_MYTHICAL
	damage_type_bullet = /damagetype/ranged/bullet/sniper_50/incendiary
	value = 60

/obj/item/bullet_cartridge/sniper_50/ap
	name = "\improper .50 AP sniper round"
	icon = 'icons/obj/item/bullet/50_ap.dmi'
	rarity = RARITY_MYTHICAL
	damage_type_bullet = /damagetype/ranged/bullet/sniper_50/ap
	value = 28

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

	value = 1.8

	inaccuracy_modifer = 0.75

/obj/item/bullet_cartridge/rifle_939mm/Generate()
	item_count_current = 5
	return ..()
