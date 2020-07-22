/obj/item/magazine/sniper_50
	name = "\improper .50 sniper magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/50_sniper.dmi'
	icon_state = "50"
	bullet_count_max = 4

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper = TRUE
	)

	ammo = /obj/item/bullet_cartridge/sniper_50

	size = SIZE_2


/obj/item/magazine/sniper_50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()


/obj/item/magazine/sniper_50/explosive
	icon_state = "50EXP"
	ammo = /obj/item/bullet_cartridge/sniper_50/explosive

/obj/item/magazine/sniper_50/ion
	icon_state = "50ION"
	ammo = /obj/item/bullet_cartridge/sniper_50/ion

/obj/item/magazine/sniper_50/incendiary
	icon_state = "50INC"
	ammo = /obj/item/bullet_cartridge/sniper_50/incendiary

/obj/item/magazine/sniper_50/ap
	icon_state = "50AP"
	ammo = /obj/item/bullet_cartridge/sniper_50/ap