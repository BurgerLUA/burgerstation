/obj/item/bullet/pistol_10mm/
	name = "\improper 10mm pistol cartridge"
	desc = "For pistols, revolvers, and smgs that require 10mm auto ammo."
	icon = 'icons/obj/items/bullet/10mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 10
	bullet_length = 32


	projectile = /obj/projectile/bullet/pistol
	damage_type = "10mm"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.02
	weight = 0.02

	value = 3

/*
/obj/item/bullet/pistol_10mm/surplus
	name = "\improper surplus 10mm pistol cartridge"
	desc = "For pistols and smgs that requre .45 ammo. Cheaply made."
	icon = 'icons/obj/items/bullet/10mm_surplus.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = "10mm_surplus"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY*SURPLUS_PENALTY

	misfire_chance = 1
*/

/obj/item/bullet/pistol_50/
	name = "\improper .50 pistol cartridge"
	desc = "For pistols that require .50."
	icon = 'icons/obj/items/bullet/50ae.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 12.7
	bullet_length = 33


	projectile = /obj/projectile/bullet/revolver/
	damage_type = ".50_pistol"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.025
	weight = 0.025

	value = 4

/obj/item/bullet/pistol_12mm/
	name = "\improper 12.7mm pistol catridge"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo."
	icon = 'icons/obj/items/bullet/12mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 12.7
	bullet_length = 33


	projectile = /obj/projectile/bullet/revolver
	damage_type = "12.7mm"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.025
	weight = 0.025

	value = 4

/obj/item/bullet/pistol_9mm/
	name = "\improper 9mm pistol cartridge"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo."
	icon = 'icons/obj/items/bullet/9mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 9
	bullet_length = 19


	projectile = /obj/projectile/bullet/pistol
	damage_type = "9mm"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	weight = 0.01

	value = 1

/*
/obj/item/bullet/pistol_9mm/surplus
	name = "surplus 9mm round"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo. This one was mass produced."
	icon = 'icons/obj/items/bullet/9mm_surplus.dmi'

	damage_type = "9mm_surplus"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT * SURPLUS_PENALTY

	misfire_chance = 1

	size = 0.01
	weight = 0.01
*/

/obj/item/bullet/pistol_40/
	name = "\improper .40 pistol cartridge"
	desc = "For pistols, revolvers, and smgs that require .40 ammo."
	icon = 'icons/obj/items/bullet/40.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 10
	bullet_length = 22


	projectile = /obj/projectile/bullet/pistol
	damage_type = ".40"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	weight = 0.01

	value = 1

/obj/item/bullet/pistol_45/
	name = "\improper .45 pistol catridge"
	desc = "For pistols and smgs that requre .45 ammo."
	icon = 'icons/obj/items/bullet/45.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 11.43
	bullet_length = 23

	projectile = /obj/projectile/bullet/smg
	damage_type = ".45"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.015
	weight = 0.015

	value = 2

/*
/obj/item/bullet/pistol_45/surplus
	name = "\improper surplus .45 bullet"
	desc = "For pistols and smgs that requre .45 ammo. Cheaply made."
	id = ".45"
	icon = 'icons/obj/items/bullet/45_surplus.dmi'

	projectile = /obj/projectile/bullet/smg
	damage_type = ".45_surplus"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT * SURPLUS_PENALTY

	misfire_chance = 1


/obj/item/bullet/pistol_45/rubber
	name = "\improper rubber .45 bullet"
	desc = "For pistols and smgs that requre .45 ammo. For less-than-lethal takedowns."
	id = ".45"
	icon = 'icons/obj/items/bullet/45_rubber.dmi'

	projectile = /obj/projectile/bullet/shotgun_pellet
	damage_type = ".45_rubber"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	jam_chance = 2 //Rubber bullets are infamous for not having enough power to move the slide all the way back.
*/

/obj/item/bullet/pistol_8mm //TODO: REWORK
	name = "\improper 8mm pistol bullet"
	desc = "For pistols and smgs that requre 8mm ammo. It's subsonic, and small."
	icon = 'icons/obj/items/bullet/8mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	id = "bullet"
	bullet_diameter = 8
	bullet_length = 12

	projectile = /obj/projectile/bullet/pistol
	damage_type = "8mm"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	size = 0.01
	weight = 0.01

	value = 2

/*
/obj/item/bullet/pistol_8mm/hollowpoint
	name = "\improper hollowpoint 8mm pistol bullet"
	desc = "For pistols and smgs that requre 8mm ammo. It's subsonic, and small. It's hollowpoint for extra punch, but poor penetration. Critical hits on headshots."
	icon = 'icons/obj/items/bullet/8mm_hollowpoint.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = "8mm_hp"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE
*/