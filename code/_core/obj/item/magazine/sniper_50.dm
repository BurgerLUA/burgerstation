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

	icon_states = 1

	value = 20

/obj/item/magazine/sniper_50/explosive
	name = "\improper .50 sniper magazine - explosive"
	icon_state = "50EXP"
	ammo = /obj/item/bullet_cartridge/sniper_50/explosive

/obj/item/magazine/sniper_50/ion
	name = "\improper .50 sniper magazine - ion"
	icon_state = "50ION"
	ammo = /obj/item/bullet_cartridge/sniper_50/ion

/obj/item/magazine/sniper_50/incendiary
	name = "\improper .50 sniper magazine - incendiary"
	icon_state = "50INC"
	ammo = /obj/item/bullet_cartridge/sniper_50/incendiary

/obj/item/magazine/sniper_50/ap
	name = "\improper .50 sniper magazine - armor piercing"
	icon_state = "50AP"
	ammo = /obj/item/bullet_cartridge/sniper_50/ap