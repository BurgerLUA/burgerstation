/obj/item/bullet_cartridge/sniper_762
	name = "\improper 7.62mm rifle bullet"
	desc = "For rifles that require 7.62mm"
	icon = 'icons/obj/items/bullet/762.dmi'

	id = "bullet"
	bullet_diameter = 7.62
	bullet_length = 51

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type = "7.62"

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	size = 0.04
	weight = 0.04

	value = 6

/obj/item/bullet_cartridge/sniper_762/on_spawn()
	item_count_current = 5
	return ..()

/*
/obj/item/bullet_cartridge/sniper_762/surplus
	name = "\improper 7.62mm surplus bullet"
	damage_type = "7.62_surplus"
	icon = 'icons/obj/items/bullet/762_surplus.dmi'

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY * SURPLUS_PENALTY

	misfire_chance = 1
*/

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
	damage_type = ".223"

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	size = 0.03
	weight = 0.03

	value = 4

/*
/obj/item/bullet_cartridge/rifle_223/surplus
	name = "\improper surplus .223 rifle bullet"
	desc = "For rifles and machineguns that requre .223"
	icon = 'icons/obj/items/bullet/223_surplus.dmi'

	damage_type = "223_surplus"

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT * SURPLUS_PENALTY
*/


/obj/item/bullet_cartridge/rifle_223/syndicate
	name = "\improper 5.56mm rifle bullet"
	desc = "For rifles and machineguns that requre 5,56mm."

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type = ".223"

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT