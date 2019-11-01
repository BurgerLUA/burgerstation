/obj/item/bullet/gyrojet/
	name = "\improper 20mm gyrojet round"
	desc = "For pistols and rifles that require gyrojet rounds."
	id = "gyrojet"
	icon = 'icons/obj/items/bullet/gyrojet.dmi'

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/pistol
	damage_type = "gyrojet"

	bullet_speed = BULLET_SPEED_LARGE_PROJECTILE

/*
/obj/item/bullet/gyrojet/spend_bullet()

	. = ..()

	invisible = 100

	return .
*/