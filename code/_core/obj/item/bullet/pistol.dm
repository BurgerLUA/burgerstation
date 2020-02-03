/obj/item/bullet/pistol_10mm/
	name = "\improper 10mm auto round"
	desc = "For pistols, revolvers, and smgs that require 10mm auto ammo."
	id = "10mm_auto"
	icon = 'icons/obj/items/bullet/10mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/pistol
	damage_type = "10mm"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/pistol_10mm/surplus
	name = "\improper surplus 10mm auto round"
	desc = "For pistols and smgs that requre .45 ammo. Cheaply made."
	icon = 'icons/obj/items/bullet/10mm_surplus.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = "10mm_surplus"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY*SURPLUS_PENALTY

	misfire_chance = 1

/obj/item/bullet/pistol_50ae/
	name = "\improper .50 action express"
	desc = "For pistols that require .50."
	id = ".50"
	icon = 'icons/obj/items/bullet/50ae.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/revolver/
	damage_type = ".50_pistol"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/pistol_12mm/
	name = "\improper 12.7mm round"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo."
	id = "12.7mm"
	icon = 'icons/obj/items/bullet/12mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/revolver
	damage_type = "12.7mm"

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/pistol_9mm/
	name = "\improper 9mm round"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo."
	id = "9mm"
	icon = 'icons/obj/items/bullet/9mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/pistol
	damage_type = "9mm"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

/obj/item/bullet/pistol_9mm/surplus
	name = "surplus 9mm round"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo. This one was mass produced."
	icon = 'icons/obj/items/bullet/9mm_surplus.dmi'

	damage_type = "9mm_surplus"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT * SURPLUS_PENALTY

	misfire_chance = 1

/obj/item/bullet/pistol_45/
	name = "\improper .45 bullet"
	desc = "For pistols and smgs that requre .45 ammo."
	id = ".45"
	icon = 'icons/obj/items/bullet/45.dmi'

	projectile = /obj/projectile/bullet/smg
	damage_type = ".45"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT


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


/obj/item/bullet/pistol_8mm
	name = "\improper 8mm pistol bullet"
	desc = "For pistols and smgs that requre 8mm ammo. It's subsonic, and small."
	id = "8mm"
	icon = 'icons/obj/items/bullet/8mm.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = "8mm"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE


/obj/item/bullet/pistol_8mm/hollowpoint
	name = "\improper hollowpoint 8mm pistol bullet"
	desc = "For pistols and smgs that requre 8mm ammo. It's subsonic, and small. It's hollowpoint for extra punch, but poor penetration. Critical hits on headshots."
	id = "8mm"
	icon = 'icons/obj/items/bullet/8mm_hollowpoint.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = "8mm_hp"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE


/obj/item/bullet/pistol_40
	name = "\improper .40 pistol bullet"
	desc = "For pistols that requre .40 ammo."
	id = ".40"
	icon = 'icons/obj/items/bullet/40.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = ".40"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT