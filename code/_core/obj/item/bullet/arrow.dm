/obj/item/bullet_cartridge/arrow
	name = "arrow"
	icon_state = "arrow"
	icon = 'icons/obj/item/bullet/arrow.dmi'

	projectile = /obj/projectile/bullet/arrow
	damage_type_bullet = /damagetype/ranged/bow/

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	item_count_max = 5
	item_count_max_icon = 5

	bullet_length = -1
	bullet_diameter = -1

	size = SIZE_1
	value = 5

/obj/item/bullet_cartridge/arrow/Generate()
	item_count_current = item_count_max
	update_sprite()
	return ..()

/obj/item/bullet_cartridge/arrow/spend_bullet(var/mob/caller,var/bonus_misfire_chance=0)
	src.projectile_count = item_count_current
	qdel(src)
	return src