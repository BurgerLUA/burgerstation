/obj/item/bullet/pistol_10mm/
	name = "\improper 10mm auto round"
	desc = "For pistols, revolvers, and smgs that require 10mm auto ammo."
	id = "10mm_auto"
	icon = 'icons/obj/items/bullet/10mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/pistol
	damage_type = "10mm_auto"

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/pistol_10mm/surplus
	name = "\improper surplus 10mm auto round"
	desc = "For pistols and smgs that requre .45 ammo. Cheaply made."
	icon = 'icons/obj/items/bullet/10mm_surplus.dmi'

	projectile = /obj/projectile/bullet/pistol
	damage_type = "10mm_auto_surplus"

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY*SURPLUS_PENALTY

/obj/item/bullet/pistol_50ae/
	name = "\improper .50 action express"
	desc = "For pistols that require .50ae."
	id = ".50ae"
	icon = 'icons/obj/items/bullet/50ae.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/revolver/
	damage_type = ".50ae"

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/pistol_9mm/
	name = "\improper 9mm round"
	desc = "For pistols, revolvers, and smgs that require 9mm auto ammo."
	id = "9mm"
	icon = 'icons/obj/items/bullet/9mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/pistol
	damage_type = "9mm"

	bullet_speed = BULLET_SPEED_PISTOL_LIGHT

/obj/item/bullet/pistol_45/
	name = "\improper .45 bullet"
	desc = "For pistols and smgs that requre .45 ammo."
	id = ".45"
	icon = 'icons/obj/items/bullet/45.dmi'

	projectile = /obj/projectile/bullet/smg
	damage_type = ".45"

	bullet_speed = BULLET_SPEED_PISTOL_LIGHT


/obj/item/bullet/pistol_45/surplus
	name = "\improper surplus .45 bullet"
	desc = "For pistols and smgs that requre .45 ammo. Cheaply made."
	id = ".45"
	icon = 'icons/obj/items/bullet/45_surplus.dmi'

	projectile = /obj/projectile/bullet/smg
	damage_type = ".45_surplus"

	bullet_speed = BULLET_SPEED_PISTOL_LIGHT * SURPLUS_PENALTY


/obj/item/bullet/pistol_45/rubber
	name = "\improper rubber .45 bullet"
	desc = "For pistols and smgs that requre .45 ammo. For less-than-lethal takedowns."
	id = ".45"
	icon = 'icons/obj/items/bullet/45_rubber.dmi'

	projectile = /obj/projectile/bullet/shotgun_pellet
	damage_type = ".45_rubber"

	bullet_speed = BULLET_SPEED_LARGE_PROJECTILE