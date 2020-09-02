/obj/item/magazine/rifle_308
	name = "\improper .308 rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/308_rifle.dmi'
	icon_state = "308"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/assault = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/assault/equipped = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2


/obj/item/magazine/rifle_308/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()