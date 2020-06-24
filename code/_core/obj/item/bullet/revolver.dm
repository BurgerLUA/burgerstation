/obj/item/bullet_cartridge/revolver_38
	name = "\improper .38 revolver cartridge"
	desc = "For revolvers that require .38 ammo."
	icon = 'icons/obj/items/bullet/38.dmi'


	bullet_diameter = 9
	bullet_length = 29
	bullet_color = COLOR_BULLET

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_38

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.02
	weight = 0.02

	value = 0.3

/obj/item/bullet_cartridge/revolver_357
	name = "\improper .357 revolver cartridge"
	desc = "For revolvers that require .357 ammo."
	icon = 'icons/obj/items/bullet/357.dmi'


	bullet_diameter = 9
	bullet_length = 33
	bullet_color = COLOR_BULLET

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_357

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.03
	weight = 0.03

	value = 0.3

/obj/item/bullet_cartridge/revolver_44
	name = "\improper .44 revolver cartridge"
	desc = "For revolvers that require .44 revolver ammo."
	icon = 'icons/obj/items/bullet/44.dmi'


	bullet_diameter = 10.9
	bullet_length = 29
	bullet_color = COLOR_BULLET

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_44

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.035
	weight = 0.035
	value = 0.4

/obj/item/bullet_cartridge/pistol_22
	name = "\improper .22 pistol cartridge"
	desc = "For pistols and revolvers that require .22 ammo."
	icon = 'icons/obj/items/bullet/22.dmi'


	bullet_diameter = 5.6
	bullet_length = 17.7
	bullet_color = COLOR_BULLET

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_22

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	weight = 0.01
	value = 0.1

/obj/item/bullet_cartridge/revolver_300
	name = "\improper .300 revolver cartridge"
	desc = "For revolvers that require .300 revolver ammo."
	icon = 'icons/obj/items/bullet/300.dmi'

	bullet_diameter = 7.62
	bullet_length = 46
	bullet_color = COLOR_BULLET

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_300

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.06
	weight = 0.06
	value = 1.2

/obj/item/bullet_cartridge/revolver_300/Generate()
	item_count_current = 5
	return ..()