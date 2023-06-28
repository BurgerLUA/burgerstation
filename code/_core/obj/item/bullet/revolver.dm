/obj/item/bullet_cartridge/revolver_38
	name = "\improper .38 revolver cartridge"
	desc = "For when your gun needs something a little special."
	desc_extended = "For revolvers that require .38 ammo."
	icon = 'icons/obj/item/bullet/38.dmi'


	bullet_diameter = 9
	bullet_length = 29
	bullet_color = COLOR_BULLET

	amount_max = 6
	amount_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_38

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.02
	value = 1 //Dummy value.

/obj/item/bullet_cartridge/revolver_38/surplus
	name = "\improper surplus .38 revolver cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/revolver_38/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/revolver_357
	name = "\improper .357 revolver cartridge"
	desc = "DRAW!"
	desc_extended = "For revolvers that require .357 ammo."
	icon = 'icons/obj/item/bullet/357.dmi'


	bullet_diameter = 9
	bullet_length = 33
	bullet_color = COLOR_BULLET

	amount_max = 6
	amount_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_357

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.03
	value = 1 //Dummy value.

/obj/item/bullet_cartridge/revolver_357/heap
	name = "\improper .357 HEAP revolver cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/revolver_357/heap


/obj/item/bullet_cartridge/revolver_357/surplus
	name = "\improper surplus .357 revolver cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/revolver_357/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/revolver_44
	name = "\improper .44 revolver cartridge"
	desc = "I'm feeling lucky"
	desc_extended = "For revolvers that require .44 revolver ammo."
	icon = 'icons/obj/item/bullet/44.dmi'


	bullet_diameter = 10.9
	bullet_length = 29
	bullet_color = COLOR_BULLET

	amount_max = 6
	amount_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_44

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.035
	value = 1 //Dummy value.

/obj/item/bullet_cartridge/revolver_44/surplus
	name = "\improper surplus .44 revolver cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/revolver_44/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/pistol_22
	name = "\improper .22 pistol cartridge"
	desc = "For when you need to mildly bother someone."
	desc_extended = "For pistols and revolvers that require .22 ammo."
	icon = 'icons/obj/item/bullet/22.dmi'

	bullet_diameter = 5.6
	bullet_length = 17.7
	bullet_color = COLOR_BULLET

	amount_max = 6
	amount_max_icon = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_22

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	value = 1 //Dummy value.

/obj/item/bullet_cartridge/pistol_22/surplus
	name = "\improper surplus .22 pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/revolver_22/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/revolver_300
	name = "\improper .300 revolver cartridge"
	desc = "For pocket sized bear deterrers, ask for no substitute."
	desc_extended = "For revolvers that require .300 revolver ammo."
	icon = 'icons/obj/item/bullet/300.dmi'

	bullet_diameter = 7.62
	bullet_length = 67
	bullet_color = COLOR_BULLET

	amount_max = 5
	amount_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_300

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.06
	value = 1 //Dummy value.

/obj/item/bullet_cartridge/revolver_762
	name = "\improper 7.62x38mmR revolver cartridge"
	desc = "Isn't this just a cut down rifle bullet?"
	desc_extended = "For revolvers that require 7.62x38mmR revolver ammo."
	icon = 'icons/obj/item/bullet/762_revolver.dmi'

	bullet_diameter = 7.62
	bullet_length = 38
	bullet_color = COLOR_BULLET

	amount_max = 7
	amount_max_icon = 7

	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/revolver_762

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.06
	value = 1 //Dummy value.

/obj/item/bullet_cartridge/revolver_762/surplus
	name = "\improper surplus 7.62x38mmR revolver cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/revolver_762/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN