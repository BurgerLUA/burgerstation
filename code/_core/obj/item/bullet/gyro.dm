/obj/item/bullet/gyrojet/
	name = "\improper 20mm gyrorocket"
	desc = "For pistols and rifles that require gyrojet rounds. Even well made rounds are known for their high misfire chance."
	id = "gyrojet"
	icon = 'icons/obj/items/bullet/gyrojet.dmi'

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/pistol
	damage_type = "gyrojet"

	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	misfire_chance = 5

/obj/item/bullet/gyrojet/surplus
	name = "\improper surplus 20mm gyrorocket"
	misfire_chance = 20

/*
/obj/item/bullet/gyrojet/spend_bullet()

	. = ..()

	invisible = 100

	return .
*/