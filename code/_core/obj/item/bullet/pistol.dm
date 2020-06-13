/obj/item/bullet_cartridge/pistol_10mm/
	name = "\improper 10mm pistol cartridge"
	desc = "For pistols, revolvers, and smgs that require 10mm auto ammo."
	icon = 'icons/obj/items/bullet/10mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 10.17
	bullet_length = 32
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_10mm

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.02
	weight = 0.02
	value = 0.3


/obj/item/bullet_cartridge/pistol_50/
	name = "\improper .50 pistol cartridge"
	desc = "For pistols that require .50."
	icon = 'icons/obj/items/bullet/50ae.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 12.7
	bullet_length = 33
	bullet_color = COLOR_BULLET


	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/pistol_50

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.025
	weight = 0.025

	value = 0.4

/obj/item/bullet_cartridge/pistol_12mm/
	name = "\improper 12.7mm pistol catridge"
	desc = "For pistols, revolvers, and smgs that require 12mm ammo."
	icon = 'icons/obj/items/bullet/12mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 12.7
	bullet_length = 33
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/revolver
	damage_type_bullet = /damagetype/ranged/bullet/pistol_12mm

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.025
	weight = 0.025
	value = 0.4

/obj/item/bullet_cartridge/pistol_9mm/
	name = "\improper 9mm pistol cartridge"
	desc = "For pistols, revolvers, and smgs that require 9mm ammo."
	icon = 'icons/obj/items/bullet/9mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 9
	bullet_length = 19
	bullet_color = COLOR_BULLET


	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_9mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	weight = 0.01
	value = 0.1

/obj/item/bullet_cartridge/pistol_4mm/
	name = "\improper 4.6x30mm smg cartridge"
	desc = "For smgs that require 4.6x30mm ammo."
	icon = 'icons/obj/items/bullet/8mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 4.6
	bullet_length = 30
	bullet_color = COLOR_BULLET


	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	weight = 0.01
	value = 0.1

/obj/item/bullet_cartridge/pistol_40/
	name = "\improper .40 pistol cartridge"
	desc = "For pistols, revolvers, and smgs that require .40 ammo."
	icon = 'icons/obj/items/bullet/40.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 10
	bullet_length = 22
	bullet_color = COLOR_BULLET


	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_40

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	weight = 0.01
	value = 0.1

/obj/item/bullet_cartridge/pistol_45/
	name = "\improper .45 pistol catridge"
	desc = "For pistols and smgs that requre .45 ammo."
	icon = 'icons/obj/items/bullet/45.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 11.43
	bullet_length = 23
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/smg
	damage_type_bullet = /damagetype/ranged/bullet/pistol_45

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.015
	weight = 0.015
	value = 0.2

/obj/item/bullet_cartridge/pistol_8mm //TODO: REWORK
	name = "\improper 8mm pistol bullet"
	desc = "For pistols and smgs that requre 8mm ammo. It's subsonic, and small."
	icon = 'icons/obj/items/bullet/8mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 8
	bullet_length = 12
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_8mm

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.01
	weight = 0.01
	value = 0.2