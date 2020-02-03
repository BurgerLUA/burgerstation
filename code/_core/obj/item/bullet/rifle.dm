/obj/item/bullet/rifle_762
	name = "\improper 7.62mm bullet"
	desc = "For rifles that require 7.62mm"
	id = "7.62"
	icon = 'icons/obj/items/bullet/762.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type = "7.62"

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY


/obj/item/bullet/rifle_762/on_spawn()
	item_count_current = 5
	return ..()


/obj/item/bullet/rifle_762/surplus
	name = "\improper 7.62mm surplus bullet"
	damage_type = "7.62_surplus"
	icon = 'icons/obj/items/bullet/762_surplus.dmi'

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY * SURPLUS_PENALTY

	misfire_chance = 1

/obj/item/bullet/rifle_223
	name = "\improper .223 rifle bullet"
	desc = "For rifles and machineguns that requre .223."
	id = ".223"
	icon = 'icons/obj/items/bullet/223.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/rifle
	damage_type = ".223"

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT


/obj/item/bullet/rifle_223/surplus
	name = "\improper surplus .223 rifle bullet"
	desc = "For rifles and machineguns that requre .223"
	icon = 'icons/obj/items/bullet/223_surplus.dmi'

	damage_type = "223_surplus"

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT * SURPLUS_PENALTY