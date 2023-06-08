/obj/item/magazine/sniper_308
	name = "\improper .308 rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/762_rifle.dmi'
	icon_state = "762"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/service = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/advanced = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/dmr = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/dmr/specop = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/mod = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/nato
	ammo_surplus = /obj/item/bullet_cartridge/rifle_308/surplus

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2

	icon_states = 1

	value = 15

/obj/item/magazine/sniper_308/ap
	name = "\improper .308 AP sniper magazine"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber. This one contains AP rounds."
	icon = 'icons/obj/item/magazine/762_rifle_ap.dmi'

	ammo = /obj/item/bullet_cartridge/rifle_308/ap
	rarity = RARITY_UNCOMMON

/obj/item/magazine/sniper_308/nato
	name = "\improper 7.62mm rifle magazine"

	ammo = /obj/item/bullet_cartridge/rifle_308/nato
	ammo_surplus = /obj/item/bullet_cartridge/rifle_308/surplus

/obj/item/magazine/sniper_308/nato/ap
	name = "\improper 7.62mm AP sniper magazine"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber. This one contains AP rounds."
	icon = 'icons/obj/item/magazine/762_rifle_ap.dmi'
	rarity = RARITY_UNCOMMON

	ammo = /obj/item/bullet_cartridge/rifle_308/nato/ap

/obj/item/magazine/sniper_308/du
	name = "\improper .308 DP sniper magazine"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber. This one contains DU rounds."
	icon = 'icons/obj/item/magazine/762_rifle_du.dmi'
	prem_restock_ammo = /obj/item/bullet_cartridge/rifle_308
	rarity = RARITY_RARE
	ammo = /obj/item/bullet_cartridge/rifle_308/du
	value_burgerbux = 1

/obj/item/magazine/sniper_308/nato/du
	name = "\improper 7.62mm DP sniper magazine"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber. This one contains DU rounds."
	icon = 'icons/obj/item/magazine/762_rifle_du.dmi'
	prem_restock_ammo = /obj/item/bullet_cartridge/rifle_308/nato
	rarity = RARITY_RARE
	ammo = /obj/item/bullet_cartridge/rifle_308/nato/du
	value_burgerbux = 1
