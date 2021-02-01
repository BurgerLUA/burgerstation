/obj/item/magazine/sniper_762
	name = "\improper 7.62mm sniper magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/762_rifle.dmi'
	icon_state = "762"
	bullet_count_max = 15

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/service = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/service/nt = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_nt = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/advanced = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/nato

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2

	icon_states = 1

	value = 15


/obj/item/magazine/sniper_762/ap
	name = "\improper 7.62mm AP sniper magazine"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber. This one contains AP rounds."
	icon = 'icons/obj/item/magazine/762_rifle_ap.dmi'
	icon_state = "762"

	ammo = /obj/item/bullet_cartridge/rifle_308/nato/ap