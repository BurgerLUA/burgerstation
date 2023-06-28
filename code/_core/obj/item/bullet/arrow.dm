/obj/item/bullet_cartridge/arrow
	name = "arrow"
	icon_state = "arrow"
	icon = 'icons/obj/item/bullet/arrow.dmi'

	projectile = /obj/projectile/bullet/arrow
	damage_type_bullet = /damagetype/ranged/bow/

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	amount_max = 5
	amount_max_icon = 5

	bullet_length = -1
	bullet_diameter = -1

	size = SIZE_1
	value = 1 //Dummy value.

	caseless = TRUE

/obj/item/bullet_cartridge/arrow/spend_bullet(var/mob/caller,var/bonus_misfire_chance=0)
	src.projectile_count = amount
	qdel(src)
	return src

/obj/item/bullet_cartridge/arrow/ashen
	name = "ashen arrow"
	icon = 'icons/obj/item/bullet/arrow_ashen.dmi'
	rarity = RARITY_UNCOMMON

	projectile = /obj/projectile/bullet/arrow/ashen
	damage_type_bullet = /damagetype/ranged/bow/ashen

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	amount_max = 3
	amount_max_icon = 3

/obj/item/bullet_cartridge/arrow/hardlight
	name = "hardlight arrow"
	icon = 'icons/obj/item/bullet/arrow_hardlight.dmi'
	rarity = RARITY_RARE

	projectile = /obj/projectile/bullet/arrow/hardlight
	damage_type_bullet = /damagetype/ranged/bow/hardlight

	projectile_speed = TILE_SIZE-1

	amount_max = 1
	amount_max_icon = 1

	value = 0
	value_burgerbux = 1

/obj/item/bullet_cartridge/arrow/hardlight/spend_bullet(var/mob/caller,var/bonus_misfire_chance=0)
	return src


/obj/item/bullet_cartridge/arrow/hardlight/syndicate
	icon = 'icons/obj/item/bullet/arrow_hardlight_syndicate.dmi'
	projectile = /obj/projectile/bullet/arrow/hardlight/syndicate
	damage_type = /damagetype/ranged/bow/hardlight/syndicate