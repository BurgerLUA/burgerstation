/obj/item/bullet_cartridge/bolt
	name = "crossbow bolt"
	desc = "For when you need to go medieval on someone's ass."
	desc_extended = "A crudely constructed bolt meant for crossbow"
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/bolt.dmi'
	item_count_max = 6
	item_count_max_icon = 6
	icon_state = "bolt"

	bullet_length = -1
	bullet_diameter = -1

	projectile = /obj/projectile/bullet/bolt
	damage_type_bullet = /damagetype/ranged/bullet/crossbow_bolt

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.5
	value = 10


/obj/item/bullet_cartridge/bolt/Generate()
	item_count_current = 3
	return ..()

/obj/item/bullet_cartridge/bolt/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	return TRUE