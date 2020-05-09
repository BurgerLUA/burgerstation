/obj/item/bullet_cartridge/rifle_308
	name = "\improper .308 rifle bullet"
	desc = "For rifles that require .308."
	icon = 'icons/obj/items/bullet/762.dmi'

	id = "bullet"
	bullet_diameter = 7.62
	bullet_length = 51

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_308

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	size = 0.04
	weight = 0.04

	value = 0.7

/obj/item/bullet_cartridge/rifle_308/on_spawn()
	item_count_current = 5
	return ..()

/obj/item/bullet_cartridge/rifle_308/syndicate
	name = "\improper 7.62mm rifle bullet"
	desc = "For rifles that require 7.62mm"
	icon = 'icons/obj/items/bullet/762.dmi'
	damage_type_bullet = /damagetype/ranged/bullet/rifle_762mm

/obj/item/bullet_cartridge/rifle_223
	name = "\improper .223 rifle bullet"
	desc = "For rifles and machineguns that requre .223."
	icon = 'icons/obj/items/bullet/223.dmi'

	id = "bullet"
	bullet_diameter = 5.56
	bullet_length = 45

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_223

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	size = 0.03
	weight = 0.03

	value = 0.4

/obj/item/bullet_cartridge/rifle_223/syndicate
	name = "\improper 5.56mm rifle bullet"
	desc = "For rifles and machineguns that requre 5,56mm."

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT